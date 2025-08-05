using System;
using System.Collections.Generic;
using System.Web;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text; 

namespace StudentTransport.Classes
{
    public class UserManager
    {
        private readonly string connectionString;

        public UserManager()
        {
            connectionString = ConfigurationManager.ConnectionStrings["StudentTransportDB"].ConnectionString;
        }

        public bool RegisterUser(string firstName, string lastName, string email, string password, string role,
                                string residence = null, string campusLocation = null, string licenseNumber = null)
        {
            string passwordHash = HashPassword(password);

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlTransaction transaction = connection.BeginTransaction();

                try
                {
                    // Insert into Users table
                    string userQuery = @"INSERT INTO Users (FirstName, LastName, Email, PasswordHash, Role) 
                                       OUTPUT INSERTED.UserID
                                       VALUES (@FirstName, @LastName, @Email, @PasswordHash, @Role)";

                    int userId;
                    using (SqlCommand command = new SqlCommand(userQuery, connection, transaction))
                    {
                        command.Parameters.AddWithValue("@FirstName", firstName);
                        command.Parameters.AddWithValue("@LastName", lastName);
                        command.Parameters.AddWithValue("@Email", email);
                        command.Parameters.AddWithValue("@PasswordHash", passwordHash);
                        command.Parameters.AddWithValue("@Role", role);

                        userId = (int)command.ExecuteScalar();
                    }

                    // Insert into specific role table
                    if (role == "Student")
                    {
                        string studentQuery = @"INSERT INTO Students (StudentID, Residence, CampusLocation) 
                                              VALUES (@StudentID, @Residence, @CampusLocation)";

                        using (SqlCommand command = new SqlCommand(studentQuery, connection, transaction))
                        {
                            command.Parameters.AddWithValue("@StudentID", userId);
                            command.Parameters.AddWithValue("@Residence", residence);
                            command.Parameters.AddWithValue("@CampusLocation", campusLocation);
                            command.ExecuteNonQuery();
                        }
                    }
                    else if (role == "Driver")
                    {
                        string driverQuery = @"INSERT INTO Drivers (DriverID, LicenseNumber) 
                                             VALUES (@DriverID, @LicenseNumber)";

                        using (SqlCommand command = new SqlCommand(driverQuery, connection, transaction))
                        {
                            command.Parameters.AddWithValue("@DriverID", userId);
                            command.Parameters.AddWithValue("@LicenseNumber", licenseNumber);
                            command.ExecuteNonQuery();
                        }
                    }

                    transaction.Commit();
                    return true;
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    HttpContext.Current.Trace.Warn("Registration Error", ex.Message);
                    return false;
                }
            }
        }

        public bool IsEmailRegistered(string email)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT COUNT(*) FROM Users WHERE Email = @Email";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Email", email);
                    connection.Open();
                    int count = (int)command.ExecuteScalar();
                    return count > 0;
                }
            }
        }

        public UserInfo AuthenticateUser(string email, string password)
        {
            string passwordHash = HashPassword(password);

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"SELECT UserID, FirstName, LastName, Role 
                        FROM Users 
                        WHERE Email = @Email AND PasswordHash = @PasswordHash AND IsActive = 1";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Email", email);
                    command.Parameters.AddWithValue("@PasswordHash", passwordHash);
                    connection.Open();

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            return new UserInfo
                            {
                                IsAuthenticated = true,
                                UserId = (int)reader["UserID"],
                                FirstName = reader["FirstName"].ToString(),
                                LastName = reader["LastName"].ToString(),
                                Role = reader["Role"].ToString()
                            };
                        }
                    }
                }
            }

            return new UserInfo { IsAuthenticated = false, Message = "Invalid email or password" };
        }

        public class UserInfo
        {
            public bool IsAuthenticated { get; set; }
            public string Message { get; set; }
            public int UserId { get; set; }
            public string FirstName { get; set; }
            public string LastName { get; set; }
            public string Role { get; set; }
        }

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
    }
}
