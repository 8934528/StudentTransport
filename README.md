# Student Transport System

## Overview

The **Student Transport Management System** is a comprehensive web-based solution designed to streamline and optimize student transportation services for educational institutions. This system addresses common challenges faced by schools and universities in managing student transport, such as:

- **Inefficient Transportation Management**  
  Manual, paper-based systems often lead to scheduling conflicts and communication gaps.

- **Real-time Tracking Needs**  
  Parents and administrators require real-time visibility into bus locations and schedules for safety and planning.

- **Resource Optimization**  
  Schools need to maximize bus utilization while minimizing operational costs.

- **Communication Gaps**  
  Lack of direct communication between drivers, students, and transport managers hinders efficiency.

This system provides a centralized platform for managing all aspects of student transportation—from scheduling and route planning to real-time tracking and seamless communication.

---

## Key Features

### For Students
- **Real-time Bus Tracking** – View active buses live on a map  
- **Schedule Access** – Check departure and arrival times  
- **Booking Management** – Reserve seats on specific routes  
- **Notification System** – Receive alerts about delays or route changes  
- **Route Information** – View detailed and updated route information  

### For Bus Drivers
- **Status Management** – Update current status (Active, Off Duty, Maintenance)  
- **Route Navigation** – Access optimized routes and daily schedules  
- **Passenger Management** – View manifests and student check-ins  
- **Incident Reporting** – Report issues or delays in real-time  
- **Fuel Tracking** – Monitor fuel levels and consumption  

### For Transport Managers
- **Fleet Management** – Manage bus information, drivers, and routes  
- **Analytics Dashboard** – View performance metrics and utilization data  
- **Scheduling System** – Create, edit, and manage transportation timetables  
- **User Management** – Add/edit/remove student and driver accounts  
- **Reporting** – Generate operational and financial reports  

---

## Technology Stack

### Frontend
- **ASP.NET Web Forms** – For server-rendered web pages  
- **HTML5/CSS3** – Markup and styling  
- **Bootstrap** – Responsive design framework  
- **JavaScript** – Client-side interactivity  
- **jQuery** – Simplified DOM manipulation and AJAX requests  

### Backend
- **C#** – Primary programming language  
- **ASP.NET Framework** – Web application backend  
- **ADO.NET** – For data access  
- **SQL Server** – Relational database management  

---

## Database Structure

- **Users** – (Students, Drivers, Managers)  
- **Buses** – (Vehicle information)  
- **Routes** – (Transportation paths and stops)  
- **Schedules** – (Timetables for routes)  
- **Bookings** – (Student reservations)  
- **StatusLog** – (History of bus statuses and incidents)  

---

## ⚙️ Installation and Setup

### Prerequisites
- Microsoft Windows Server  
- .NET Framework 4.8  
- Microsoft SQL Server 2019 or later  
- IIS (Internet Information Services)  

## Project Structure

            StudentTransport/
            |
            ├── Student/
            │   ├── StudDefault/
            |   |   ├── css/
            |   |   |   └──StudDefault.css
            |   |   |
            |   |   ├── js/
            |   |   |   └── StudDefault.js
            |   |   |
            │   │   ├── StudDefault.aspx
            │   │   └── StudDefault.aspx.cs
            |   |   
            │   └── Schedule/
            |       ├── css/
            |       |   └── Schedule.css
            |       |
            |       ├── js/
            |       |   └── Schedule.js
            |       |
            │       ├── Schedule.aspx
            │       └── Schedule.aspx.cs
            |       
            ├── Driver/
            │   ├── DriDefault/
            |   |   ├── css/
            |   |   |   └── DriDefault.css
            |   |   |
            |   |   ├── js/
            |   |   |   └── DriDefault.js
            |   |   |
            │   │   ├── DriDefault.aspx
            │   │   └── DriDefault.aspx.cs
            |   |
            │   └── BusStatus/
            |       ├── css/
            |       |   └── BusStatus.css
            |       |
            |       ├── js/
            |       |   └── BusStatus.js
            |       |
            │       ├── BusStatus.aspx
            │       └── BusStatus.aspx.cs
            |       
            ├── TransportManager/
            │   ├── Dashboard/
            |   |   ├── css/
            |   |   |   └── Dashboard.css
            |   |   | 
            |   |   ├── js/
            |   |   |   └── Dashboard.js
            |   |   |
            │   │   ├── Dashboard.aspx
            │   │   └── Dashboard.aspx.cs
            |   |   
            │   ├── ManageStudents/
            |   |   ├── css/
            |   |   |   └── ManageStudents.css
            |   |   |
            |   |   ├── js/
            |   |   |   └── ManageStudents.js
            |   |   |
            │   │   ├── ManageStudents.aspx
            │   │   └── ManageStudents.aspx.cs
            |   |   
            │   └── ManageDrivers/
            |       ├── css/
            |       |   └── ManageDrivers.css
            |       | 
            |       ├── js/
            |       |   └── ManageDrivers.js
            |       |
            │       ├── ManageDrivers.aspx
            │       └── ManageDrivers.aspx.cs
            |    
            ├── Account/
            |       ├── css/
            |       |   ├── login.css
            |       |   └── register.css
            |       |
            |       ├── js/
            |       |   ├── login.js
            |       |   └── register.js
            |       |
            │       ├── Login.aspx
            │       ├── Login.aspx.cs
            │       ├── Register.aspx
            │       └── Register.aspx.cs
            |       
            ├── Shared/
            │   ├── Site.Master
            │   ├── Site.Master.cs
            │   ├── Site.Master.designer.cs
            |   |
            |   
            |   ├── About/
            |   |   ├── About.aspx
            |   |   ├── About.aspx.cs
            |   |   |
            |   |   ├── css/
            |   |   |    └── About.css
            |   |   └── js/
            |   |        └── About.js
            |   |
            |   ├── Classes/
            |   |   ├── StudentManager.cs
            |   |   ├── DriverManager.cs
            |   |   ├── DashboardManager.cs
            │   │   └── UserManager.cs
            |   |
            │   ├── css/
            │   │   ├── site.css
            │   │   └── layout.css
            |   |
            │   └── js/
            │       └── common.js
            |   
            ├── Global.asax
            └── Web.config

---

# Contributions
 *- Feel free to fork the repo, suggest improvements, or submit pull requests to make the system even better!*
