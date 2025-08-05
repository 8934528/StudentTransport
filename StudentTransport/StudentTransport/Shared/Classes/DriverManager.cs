using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace StudentTransport.Shared.Classes
{
    public class DriverManager
    {
        private readonly string connectionString;

        public DriverManager()
        {
            connectionString = ConfigurationManager.ConnectionStrings["StudentTransportDB"].ConnectionString;
        }

        // Get driver details by ID
        public DataTable GetDriverDetails(int driverId)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"SELECT 
                                    u.UserID, u.FirstName, u.LastName, u.Email, u.PhoneNumber,
                                    d.LicenseNumber, b.BusNumber, b.Capacity,
                                    CASE 
                                        WHEN bl.Status IS NULL THEN 'OffDuty'
                                        ELSE bl.Status
                                    END AS CurrentStatus
                                FROM Users u
                                JOIN Drivers d ON u.UserID = d.DriverID
                                LEFT JOIN Buses b ON d.DriverID = b.CurrentDriverID
                                LEFT JOIN (
                                    SELECT BusID, Status
                                    FROM BusStatusLog
                                    WHERE StatusTime = (
                                        SELECT MAX(StatusTime)
                                        FROM BusStatusLog
                                        WHERE BusID = b.BusID
                                    )
                                ) bl ON b.BusID = bl.BusID
                                WHERE u.UserID = @DriverId";

                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                da.SelectCommand.Parameters.AddWithValue("@DriverId", driverId);
                DataTable dt = new DataTable();
                da.Fill(dt);
                return dt;
            }
        }

        // Get today's schedule for a driver
        public DataTable GetTodaysSchedule(int driverId)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"SELECT 
                                    s.ScheduleID,
                                    dep.StationName AS DepartureStation,
                                    arr.StationName AS ArrivalStation,
                                    FORMAT(s.DepartureTime, 'hh:mm tt') AS DepartureTime,
                                    FORMAT(s.EstimatedArrivalTime, 'hh:mm tt') AS ArrivalTime,
                                    CASE 
                                        WHEN s.DepartureTime > GETDATE() THEN 'Upcoming'
                                        WHEN s.EstimatedArrivalTime > GETDATE() THEN 'In Progress'
                                        ELSE 'Completed'
                                    END AS Status
                                FROM Schedules s
                                JOIN Buses b ON s.BusID = b.BusID
                                JOIN Drivers d ON b.CurrentDriverID = d.DriverID
                                JOIN Stations dep ON s.DepartureStationID = dep.StationID
                                JOIN Stations arr ON s.ArrivalStationID = arr.StationID
                                WHERE d.DriverID = @DriverId
                                AND CAST(s.DepartureTime AS DATE) = CAST(GETDATE() AS DATE)
                                ORDER BY s.DepartureTime";

                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                da.SelectCommand.Parameters.AddWithValue("@DriverId", driverId);
                DataTable dt = new DataTable();
                da.Fill(dt);
                return dt;
            }
        }

        // Get current passengers for a bus
        public DataTable GetCurrentPassengers(int busId)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"SELECT 
                                    st.StudentID,
                                    u.FirstName + ' ' + u.LastName AS FullName,
                                    dep.StationName AS BoardingPoint,
                                    arr.StationName AS Destination,
                                    CASE 
                                        WHEN s.DepartureTime <= GETDATE() AND s.EstimatedArrivalTime > GETDATE() 
                                            THEN 'On Board'
                                        ELSE 'Pending'
                                    END AS Status
                                FROM Bookings b
                                JOIN Students st ON b.StudentID = st.StudentID
                                JOIN Users u ON st.StudentID = u.UserID
                                JOIN Schedules s ON b.ScheduleID = s.ScheduleID
                                JOIN Stations dep ON s.DepartureStationID = dep.StationID
                                JOIN Stations arr ON s.ArrivalStationID = arr.StationID
                                WHERE s.BusID = @BusId
                                AND b.Status = 'Confirmed'
                                AND CAST(s.DepartureTime AS DATE) = CAST(GETDATE() AS DATE)";

                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                da.SelectCommand.Parameters.AddWithValue("@BusId", busId);
                DataTable dt = new DataTable();
                da.Fill(dt);
                return dt;
            }
        }

        // Update bus status
        public void UpdateBusStatus(int busId, int driverId, string status)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = @"INSERT INTO BusStatusLog (BusID, DriverID, Status) 
                                 VALUES (@BusId, @DriverId, @Status)";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@BusId", busId);
                cmd.Parameters.AddWithValue("@DriverId", driverId);
                cmd.Parameters.AddWithValue("@Status", status);
                cmd.ExecuteNonQuery();
            }
        }

        // Get bus status history
        public DataTable GetBusStatusHistory(int busId, int count = 5)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"SELECT TOP (@count) 
                                    Status,
                                    FORMAT(StatusTime, 'MMM dd, hh:mm tt') AS StatusTime,
                                    CASE Status
                                        WHEN 'Ready' THEN 'bg-success'
                                        WHEN 'InProgress' THEN 'bg-primary'
                                        WHEN 'OffDuty' THEN 'bg-secondary'
                                        WHEN 'Maintenance' THEN 'bg-danger'
                                    END AS StatusClass
                                FROM BusStatusLog
                                WHERE BusID = @BusId
                                ORDER BY StatusTime DESC";

                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                da.SelectCommand.Parameters.AddWithValue("@BusId", busId);
                da.SelectCommand.Parameters.AddWithValue("@count", count);
                DataTable dt = new DataTable();
                da.Fill(dt);
                return dt;
            }
        }

        // Get extended bus details
        public DataTable GetBusDetails(int busId)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"SELECT 
                            b.BusNumber, b.Capacity, b.Mileage,
                            s.StationName AS CurrentLocation,
                            bl.Status AS CurrentStatus
                        FROM Buses b
                        LEFT JOIN Stations s ON b.CurrentStationID = s.StationID
                        LEFT JOIN (
                            SELECT BusID, Status
                            FROM BusStatusLog
                            WHERE StatusID = (
                                SELECT MAX(StatusID) 
                                FROM BusStatusLog 
                                WHERE BusID = @BusId
                            )
                        ) bl ON b.BusID = bl.BusID
                        WHERE b.BusID = @BusId";

                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                da.SelectCommand.Parameters.AddWithValue("@BusId", busId);
                DataTable dt = new DataTable();
                da.Fill(dt);
                return dt;
            }
        }

        // Update bus location
        public void UpdateBusLocation(int busId, int stationId)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = "UPDATE Buses SET CurrentStationID = @StationId WHERE BusID = @BusId";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@StationId", stationId);
                cmd.Parameters.AddWithValue("@BusId", busId);
                cmd.ExecuteNonQuery();
            }
        }
    }
}