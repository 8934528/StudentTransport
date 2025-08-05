using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;


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

        // NEW METHOD: Add a new driver
        public void AddDriver(string firstName, string lastName, string email, string password, string licenseNumber)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                using (SqlTransaction transaction = conn.BeginTransaction())
                {
                    try
                    {
                        // Insert into Users table
                        string userQuery = @"INSERT INTO Users (Email, PasswordHash, FirstName, LastName, Role) 
                                            VALUES (@Email, @Password, @FirstName, @LastName, 'Driver');
                                            SELECT SCOPE_IDENTITY();";

                        SqlCommand userCmd = new SqlCommand(userQuery, conn, transaction);
                        userCmd.Parameters.AddWithValue("@Email", email);
                        userCmd.Parameters.AddWithValue("@Password", BCrypt.Net.BCrypt.HashPassword(password)); // Hash password
                        userCmd.Parameters.AddWithValue("@FirstName", firstName);
                        userCmd.Parameters.AddWithValue("@LastName", lastName);

                        int userId = Convert.ToInt32(userCmd.ExecuteScalar());

                        // Insert into Drivers table
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
    }
}