using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace StudentTransport.App_Code
{
    public class User
    {
        public int UserID { get; set; }
        public string Email { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Role { get; set; }
    }
}