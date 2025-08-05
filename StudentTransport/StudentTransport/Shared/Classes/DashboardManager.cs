using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;


namespace StudentTransport.Shared.Classes
{
    public class DashboardManager
    {
        private readonly string connectionString;

        public DashboardManager()
        {
            connectionString = ConfigurationManager.ConnectionStrings["StudentTransportDB"].ConnectionString;
        }

        public int GetTotalStudents()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT COUNT(*) FROM Students";
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                return (int)cmd.ExecuteScalar();
            }
        }

        public int GetActiveDrivers()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT COUNT(*) FROM Drivers WHERE IsAvailable = 1";
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                return (int)cmd.ExecuteScalar();
            }
        }

        public int GetActiveBuses()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"SELECT COUNT(DISTINCT b.BusID) 
                                FROM Buses b
                                JOIN BusStatusLog bl ON b.BusID = bl.BusID
                                WHERE bl.Status IN ('Ready', 'InProgress')
                                AND bl.StatusTime = (
                                    SELECT MAX(StatusTime) 
                                    FROM BusStatusLog 
                                    WHERE BusID = b.BusID
                                )";
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                return (int)cmd.ExecuteScalar();
            }
        }

        public int GetTodaysBookings()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"SELECT COUNT(*) 
                                FROM Bookings 
                                WHERE CAST(BookingTime AS DATE) = CAST(GETDATE() AS DATE)
                                AND Status = 'Confirmed'";
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                return (int)cmd.ExecuteScalar();
            }
        }

        public DataTable GetRecentBookings(int count = 5)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"SELECT TOP (@count) 
                                    b.BookingID,
                                    u.FirstName + ' ' + u.LastName AS StudentName,
                                    dep.StationName + ' → ' + arr.StationName AS Route,
                                    FORMAT(s.DepartureTime, 'hh:mm tt') AS Time,
                                    CASE 
                                        WHEN s.DepartureTime > GETDATE() THEN 'Scheduled'
                                        WHEN s.EstimatedArrivalTime > GETDATE() THEN 'In Progress'
                                        ELSE 'Completed'
                                    END AS Status,
                                    CASE 
                                        WHEN s.DepartureTime > GETDATE() THEN 'bg-warning'
                                        WHEN s.EstimatedArrivalTime > GETDATE() THEN 'bg-primary'
                                        ELSE 'bg-success'
                                    END AS StatusClass
                                FROM Bookings b
                                JOIN Students st ON b.StudentID = st.StudentID
                                JOIN Users u ON st.StudentID = u.UserID
                                JOIN Schedules s ON b.ScheduleID = s.ScheduleID
                                JOIN Stations dep ON s.DepartureStationID = dep.StationID
                                JOIN Stations arr ON s.ArrivalStationID = arr.StationID
                                ORDER BY b.BookingTime DESC";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@count", count);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                return dt;
            }
        }

        public DataTable GetBusStatusOverview()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"SELECT 
                                    b.BusNumber,
                                    dep.StationName + ' → ' + arr.StationName AS Route,
                                    bl.Status,
                                    CASE bl.Status
                                        WHEN 'Ready' THEN 'bg-success'
                                        WHEN 'InProgress' THEN 'bg-primary'
                                        WHEN 'OffDuty' THEN 'bg-secondary'
                                        WHEN 'Maintenance' THEN 'bg-danger'
                                    END AS StatusClass,
                                    FORMAT(bl.StatusTime, 'hh:mm tt') AS StatusTime
                                FROM Buses b
                                JOIN (
                                    SELECT BusID, MAX(StatusTime) AS MaxTime
                                    FROM BusStatusLog
                                    GROUP BY BusID
                                ) latest ON b.BusID = latest.BusID
                                JOIN BusStatusLog bl ON b.BusID = bl.BusID AND bl.StatusTime = latest.MaxTime
                                JOIN Schedules s ON b.BusID = s.BusID
                                JOIN Stations dep ON s.DepartureStationID = dep.StationID
                                JOIN Stations arr ON s.ArrivalStationID = arr.StationID";

                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                return dt;
            }
        }

        // NEW METHOD: Get all drivers with details
        public DataTable GetAllDrivers()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"SELECT 
                                    u.UserID,
                                    u.FirstName + ' ' + u.LastName AS FullName,
                                    d.LicenseNumber,
                                    d.IsAvailable,
                                    b.BusNumber,
                                    u.Email,
                                    u.PhoneNumber,
                                    CASE 
                                        WHEN d.IsAvailable = 1 THEN 'Active'
                                        ELSE 'Inactive'
                                    END AS Status,
                                    CASE 
                                        WHEN d.IsAvailable = 1 THEN 'bg-success'
                                        ELSE 'bg-secondary'
                                    END AS StatusClass
                                FROM Users u
                                JOIN Drivers d ON u.UserID = d.DriverID
                                LEFT JOIN Buses b ON d.DriverID = b.CurrentDriverID
                                WHERE u.Role = 'Driver'";

                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                return dt;
            }
        }



        // NEW METHOD: Add a new driver (with SHA256 hashing)
        public void AddDriver(string firstName, string lastName, string email, string password, string licenseNumber)
        {
            string hashedPassword = HashPassword(password);

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                using (SqlTransaction transaction = conn.BeginTransaction())
                {
                    try
                    {
                        string userQuery = @"INSERT INTO Users (Email, PasswordHash, FirstName, LastName, Role) 
                                            VALUES (@Email, @Password, @FirstName, @LastName, 'Driver');
                                            SELECT SCOPE_IDENTITY();";

                        SqlCommand userCmd = new SqlCommand(userQuery, conn, transaction);
                        userCmd.Parameters.AddWithValue("@Email", email);
                        userCmd.Parameters.AddWithValue("@Password", hashedPassword);
                        userCmd.Parameters.AddWithValue("@FirstName", firstName);
                        userCmd.Parameters.AddWithValue("@LastName", lastName);

                        int userId = Convert.ToInt32(userCmd.ExecuteScalar());

                        string driverQuery = @"INSERT INTO Drivers (DriverID, LicenseNumber) 
                                               VALUES (@DriverID, @LicenseNumber)";

                        SqlCommand driverCmd = new SqlCommand(driverQuery, conn, transaction);
                        driverCmd.Parameters.AddWithValue("@DriverID", userId);
                        driverCmd.Parameters.AddWithValue("@LicenseNumber", licenseNumber);
                        driverCmd.ExecuteNonQuery();

                        transaction.Commit();
                    }
                    catch
                    {
                        transaction.Rollback();
                        throw;
                    }
                }
            }
        }

        // Password hashing using SHA256
        private string HashPassword(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                StringBuilder builder = new StringBuilder();
                for (int i = 0; i < bytes.Length; i++)
                {
                    builder.Append(bytes[i].ToString("x2"));
                }
                return builder.ToString();
            }
        }



        // NEW METHOD: Delete a driver
        public void DeleteDriver(int driverId)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                using (SqlTransaction transaction = conn.BeginTransaction())
                {
                    try
                    {
                        // First, remove driver from any bus assignment
                        string removeDriverQuery = @"UPDATE Buses SET CurrentDriverID = NULL 
                                                    WHERE CurrentDriverID = @DriverID";
                        SqlCommand removeCmd = new SqlCommand(removeDriverQuery, conn, transaction);
                        removeCmd.Parameters.AddWithValue("@DriverID", driverId);
                        removeCmd.ExecuteNonQuery();

                        // Delete from Drivers table
                        string deleteDriverQuery = "DELETE FROM Drivers WHERE DriverID = @DriverID";
                        SqlCommand driverCmd = new SqlCommand(deleteDriverQuery, conn, transaction);
                        driverCmd.Parameters.AddWithValue("@DriverID", driverId);
                        driverCmd.ExecuteNonQuery();

                        // Delete from Users table
                        string deleteUserQuery = "DELETE FROM Users WHERE UserID = @UserID";
                        SqlCommand userCmd = new SqlCommand(deleteUserQuery, conn, transaction);
                        userCmd.Parameters.AddWithValue("@UserID", driverId);
                        userCmd.ExecuteNonQuery();

                        transaction.Commit();
                    }
                    catch
                    {
                        transaction.Rollback();
                        throw;
                    }
                }
            }
        }


        // ========== THE FOLLOWING IS ALL ABOUT STUDENTS ===========

        public DataTable GetAllStudents()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"SELECT 
                            u.UserID,
                            u.FirstName + ' ' + u.LastName AS FullName,
                            s.StudentID,
                            s.Residence,
                            s.CampusLocation,
                            u.Email,
                            u.PhoneNumber,
                            CASE 
                                WHEN u.IsActive = 1 THEN 'Active'
                                ELSE 'Inactive'
                            END AS Status,
                            CASE 
                                WHEN u.IsActive = 1 THEN 'bg-success'
                                ELSE 'bg-secondary'
                            END AS StatusClass
                        FROM Users u
                        JOIN Students s ON u.UserID = s.StudentID
                        WHERE u.Role = 'Student'";

                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                return dt;
            }
        }

        public void AddStudent(string firstName, string lastName, string email, string password,
                               string campus, string residence)
        {
            string hashedPassword = HashPassword(password);

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                using (SqlTransaction transaction = conn.BeginTransaction())
                {
                    try
                    {
                        // Insert into Users table
                        string userQuery = @"INSERT INTO Users (Email, PasswordHash, FirstName, LastName, Role) 
                                    VALUES (@Email, @Password, @FirstName, @LastName, 'Student');
                                    SELECT SCOPE_IDENTITY();";

                        SqlCommand userCmd = new SqlCommand(userQuery, conn, transaction);
                        userCmd.Parameters.AddWithValue("@Email", email);
                        userCmd.Parameters.AddWithValue("@Password", hashedPassword);
                        userCmd.Parameters.AddWithValue("@FirstName", firstName);
                        userCmd.Parameters.AddWithValue("@LastName", lastName);

                        int userId = Convert.ToInt32(userCmd.ExecuteScalar());

                        // Insert into Students table
                        string studentQuery = @"INSERT INTO Students (StudentID, Residence, CampusLocation) 
                                       VALUES (@StudentID, @Residence, @CampusLocation)";

                        SqlCommand studentCmd = new SqlCommand(studentQuery, conn, transaction);
                        studentCmd.Parameters.AddWithValue("@StudentID", userId);
                        studentCmd.Parameters.AddWithValue("@Residence", residence);
                        studentCmd.Parameters.AddWithValue("@CampusLocation", campus);
                        studentCmd.ExecuteNonQuery();

                        transaction.Commit();
                    }
                    catch
                    {
                        transaction.Rollback();
                        throw;
                    }
                }
            }
        }

        public void DeleteStudent(int studentId)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                using (SqlTransaction transaction = conn.BeginTransaction())
                {
                    try
                    {
                        // First, delete student bookings
                        string deleteBookingsQuery = "DELETE FROM Bookings WHERE StudentID = @StudentID";
                        SqlCommand bookingsCmd = new SqlCommand(deleteBookingsQuery, conn, transaction);
                        bookingsCmd.Parameters.AddWithValue("@StudentID", studentId);
                        bookingsCmd.ExecuteNonQuery();

                        // Delete from Students table
                        string deleteStudentQuery = "DELETE FROM Students WHERE StudentID = @StudentID";
                        SqlCommand studentCmd = new SqlCommand(deleteStudentQuery, conn, transaction);
                        studentCmd.Parameters.AddWithValue("@StudentID", studentId);
                        studentCmd.ExecuteNonQuery();

                        // Delete from Users table
                        string deleteUserQuery = "DELETE FROM Users WHERE UserID = @UserID";
                        SqlCommand userCmd = new SqlCommand(deleteUserQuery, conn, transaction);
                        userCmd.Parameters.AddWithValue("@UserID", studentId);
                        userCmd.ExecuteNonQuery();

                        transaction.Commit();
                    }
                    catch
                    {
                        transaction.Rollback();
                        throw;
                    }
                }
            }
        }
    }
}
