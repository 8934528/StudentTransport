using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace StudentTransport.App_Code
{
    public static class DatabaseHelper
    {
        private static string connectionString = ConfigurationManager.ConnectionStrings["TransportDB"].ConnectionString;

        public static SqlConnection GetConnection()
        {
            return new SqlConnection(connectionString);
        }

        public static User AuthenticateUser(string email, string password)
        {
            using (SqlConnection conn = GetConnection())
            {
                conn.Open();
                string query = "SELECT UserID, Email, FirstName, LastName, Role FROM Users WHERE Email = @Email AND PasswordHash = @Password";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Password", SecurityHelper.HashPassword(password));

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            return new User
                            {
                                UserID = Convert.ToInt32(reader["UserID"]),
                                Email = reader["Email"].ToString(),
                                FirstName = reader["FirstName"].ToString(),
                                LastName = reader["LastName"].ToString(),
                                Role = reader["Role"].ToString()
                            };
                        }
                    }
                }
            }
            return null;
        }

        public static DataTable GetActiveSchedules(string location)
        {
            DataTable dt = new DataTable();
            using (SqlConnection conn = GetConnection())
            {
                conn.Open();
                string query = @"SELECT s.ScheduleID, b.BusNumber, st1.StationName AS FromStation, 
                            st2.StationName AS ToStation, s.DepartureTime 
                            FROM Schedules s
                            JOIN Buses b ON s.BusID = b.BusID
                            JOIN Stations st1 ON s.DepartureStationID = st1.StationID
                            JOIN Stations st2 ON s.ArrivalStationID = st2.StationID
                            WHERE st1.Location = @Location AND s.IsActive = 1 
                            AND s.DepartureTime > GETDATE()";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Location", location);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }
            return dt;
        }

        // Additional database methods for drivers and managers
    }
}