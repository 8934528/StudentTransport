using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace StudentTransport.Shared.Classes
{
    public class StudentManager
    {
        private readonly string connectionString;

        public StudentManager()
        {
            connectionString = ConfigurationManager.ConnectionStrings["StudentTransportDB"].ConnectionString;
        }

        public DataRow GetStudentDetails(int studentId)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"SELECT u.UserID, u.FirstName, u.LastName, u.Email, u.PhoneNumber, 
                                        s.Residence, s.CampusLocation
                                 FROM Users u
                                 JOIN Students s ON u.UserID = s.StudentID
                                 WHERE u.UserID = @StudentID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@StudentID", studentId);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                return dt.Rows.Count > 0 ? dt.Rows[0] : null;
            }
        }

        public DataRow GetNextRide(int studentId)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"SELECT TOP 1 
                                    b.BookingID, 
                                    sch.DepartureTime,
                                    sch.EstimatedArrivalTime,
                                    bus.BusNumber,
                                    dep.StationName AS DepartureStation,
                                    arr.StationName AS ArrivalStation,
                                    drv.FirstName + ' ' + drv.LastName AS DriverName,
                                    CASE 
                                        WHEN sch.DepartureTime > GETDATE() THEN 'Upcoming'
                                        WHEN sch.EstimatedArrivalTime > GETDATE() THEN 'In Progress'
                                        ELSE 'Completed'
                                    END AS Status
                                FROM Bookings b
                                JOIN Schedules sch ON b.ScheduleID = sch.ScheduleID
                                JOIN Buses bus ON sch.BusID = bus.BusID
                                JOIN Stations dep ON sch.DepartureStationID = dep.StationID
                                JOIN Stations arr ON sch.ArrivalStationID = arr.StationID
                                LEFT JOIN Drivers d ON bus.CurrentDriverID = d.DriverID
                                LEFT JOIN Users drv ON d.DriverID = drv.UserID
                                WHERE b.StudentID = @StudentID 
                                  AND b.Status = 'Confirmed'
                                  AND sch.DepartureTime > DATEADD(HOUR, -1, GETDATE())
                                ORDER BY sch.DepartureTime ASC";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@StudentID", studentId);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                return dt.Rows.Count > 0 ? dt.Rows[0] : null;
            }
        }

        public DataTable GetActiveBuses()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"SELECT 
                                    b.BusNumber,
                                    dep.StationName + ' → ' + arr.StationName AS Route,
                                    bl.Status,
                                    bl.StatusTime,
                                    CASE bl.Status
                                        WHEN 'Ready' THEN 'bg-success'
                                        WHEN 'InProgress' THEN 'bg-primary'
                                        WHEN 'OffDuty' THEN 'bg-secondary'
                                        ELSE 'bg-warning'
                                    END AS StatusClass
                                FROM Buses b
                                JOIN (
                                    SELECT BusID, MAX(StatusTime) AS MaxTime
                                    FROM BusStatusLog
                                    GROUP BY BusID
                                ) latest ON b.BusID = latest.BusID
                                JOIN BusStatusLog bl ON b.BusID = bl.BusID AND bl.StatusTime = latest.MaxTime
                                JOIN Schedules s ON b.BusID = s.BusID
                                JOIN Stations dep ON s.DepartureStationID = dep.StationID
                                JOIN Stations arr ON s.ArrivalStationID = arr.StationID
                                WHERE bl.Status IN ('Ready', 'InProgress')";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                return dt;
            }
        }

        public DataTable GetRecentBookings(int studentId, int count = 3)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"SELECT TOP (@count) 
                                    b.BookingID,
                                    dep.StationName + ' → ' + arr.StationName AS Route,
                                    sch.DepartureTime,
                                    sch.EstimatedArrivalTime,
                                    bus.BusNumber,
                                    drv.FirstName + ' ' + drv.LastName AS DriverName,
                                    CASE 
                                        WHEN sch.DepartureTime > GETDATE() THEN 'Upcoming'
                                        WHEN sch.EstimatedArrivalTime > GETDATE() THEN 'In Progress'
                                        ELSE 'Completed'
                                    END AS Status,
                                    CASE 
                                        WHEN sch.DepartureTime > GETDATE() THEN 'bg-primary'
                                        WHEN sch.EstimatedArrivalTime > GETDATE() THEN 'bg-info'
                                        ELSE 'bg-success'
                                    END AS StatusClass
                                FROM Bookings b
                                JOIN Schedules sch ON b.ScheduleID = sch.ScheduleID
                                JOIN Buses bus ON sch.BusID = bus.BusID
                                JOIN Stations dep ON sch.DepartureStationID = dep.StationID
                                JOIN Stations arr ON sch.ArrivalStationID = arr.StationID
                                LEFT JOIN Drivers d ON bus.CurrentDriverID = d.DriverID
                                LEFT JOIN Users drv ON d.DriverID = drv.UserID
                                WHERE b.StudentID = @StudentID
                                ORDER BY sch.DepartureTime DESC";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@StudentID", studentId);
                cmd.Parameters.AddWithValue("@count", count);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                return dt;
            }
        }

        public DataTable GetWeeklySchedule(DateTime weekStart)
        {
            DateTime weekEnd = weekStart.AddDays(7);
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"SELECT 
                                    sch.ScheduleID,
                                    sch.DepartureTime,
                                    sch.EstimatedArrivalTime,
                                    dep.StationName AS DepartureStation,
                                    arr.StationName AS ArrivalStation,
                                    bus.BusNumber,
                                    (SELECT COUNT(*) FROM Bookings b WHERE b.ScheduleID = sch.ScheduleID) AS BookedSeats,
                                    bus.Capacity,
                                    CASE 
                                        WHEN (SELECT COUNT(*) FROM Bookings b WHERE b.ScheduleID = sch.ScheduleID) < bus.Capacity 
                                        THEN 'Available'
                                        ELSE 'Full'
                                    END AS Availability
                                FROM Schedules sch
                                JOIN Buses bus ON sch.BusID = bus.BusID
                                JOIN Stations dep ON sch.DepartureStationID = dep.StationID
                                JOIN Stations arr ON sch.ArrivalStationID = arr.StationID
                                WHERE sch.DepartureTime >= @WeekStart AND sch.DepartureTime < @WeekEnd
                                ORDER BY sch.DepartureTime";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@WeekStart", weekStart);
                cmd.Parameters.AddWithValue("@WeekEnd", weekEnd);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                return dt;
            }
        }

        public int BookRide(int studentId, int scheduleId)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = @"INSERT INTO Bookings (StudentID, ScheduleID, BookingTime, Status)
                                VALUES (@StudentID, @ScheduleID, GETDATE(), 'Confirmed');
                                SELECT SCOPE_IDENTITY();";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@StudentID", studentId);
                cmd.Parameters.AddWithValue("@ScheduleID", scheduleId);
                return Convert.ToInt32(cmd.ExecuteScalar());
            }
        }

        public bool CancelBooking(int bookingId)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = "UPDATE Bookings SET Status = 'Cancelled' WHERE BookingID = @BookingID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@BookingID", bookingId);
                return cmd.ExecuteNonQuery() > 0;
            }
        }

        public DataTable GetUpcomingBookings(int studentId)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"SELECT 
                                    b.BookingID,
                                    FORMAT(sch.DepartureTime, 'ddd, MMM dd') AS BookingDate,
                                    FORMAT(sch.DepartureTime, 'hh:mm tt') AS BookingTime,
                                    dep.StationName + ' → ' + arr.StationName AS Route,
                                    bus.BusNumber
                                FROM Bookings b
                                JOIN Schedules sch ON b.ScheduleID = sch.ScheduleID
                                JOIN Buses bus ON sch.BusID = bus.BusID
                                JOIN Stations dep ON sch.DepartureStationID = dep.StationID
                                JOIN Stations arr ON sch.ArrivalStationID = arr.StationID
                                WHERE b.StudentID = @StudentID 
                                  AND b.Status = 'Confirmed'
                                  AND sch.DepartureTime > GETDATE()
                                ORDER BY sch.DepartureTime";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@StudentID", studentId);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                return dt;
            }
        }
    }
}
