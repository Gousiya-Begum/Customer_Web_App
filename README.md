# Customer_Web_App
#Project Structure

Customer_App/
├── src
│ ├── main
│ │ ├── java
│ │ │ └── com
│ │ │ └── customer
│ │ │ ├── servlet
│ │ │ │ ├── CreateCustomerServlet.java
│ │ │ │ ├── UpdateCustomerServlet.java
│ │ │ │ ├── GetCustomerServlet.java
│ │ │ │ ├── DeleteCustomerServlet.java
│ │ │ │ └── ListCustomersServlet.java
│ │ │ ├── model
│ │ │ │ └── Customer.java
│ │ │ ├── util
│ │ │ │ └── DBUtil.java
│ │ │ └── filter
│ │ │ └── JWTAuthenticationFilter.java
│ │ └── webapp
│ │ ├── WEB-INF
│ │ │ └── web.xml
│ │ ├── index.jsp
│ │ ├── createCustomer.jsp
│ │ ├── listCustomers.jsp
│ │ └── login.jsp
└── README.md


## Setup Instructions

### Prerequisites

- Java 11 or later
- Apache Tomcat or any other servlet container
- MySQL Database

  #jar files
  
  jbcrypt-0.4.jar
  jjwt-api-0.11.5.jar
  jjwt-api-0.12.0.jar
  json-20210307.jar
  mysql-connector-j-8.3.0.jar
  
  

### Database Setup

1. **Create a MySQL Database**: Create a database named `customer_db` (or any other name you prefer).

2. **Create a Table**: Use the following SQL script to create the `customers` table.

    ```sql
   CREATE DATABASE customer_db;

USE customer_db;

CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    street VARCHAR(100),
    address VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    email VARCHAR(50) UNIQUE NOT NULL,
    phone VARCHAR(15)
);

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL
);
    ```

### Configuration

1. **Database Connection**: Edit `DBUtil.java` to configure your database connection details.

    ```java
    package com.customer.util;

    import java.sql.Connection;
    import java.sql.DriverManager;
    import java.sql.SQLException;

    public class DBUtil {
        private static final String DB_URL = "jdbc:mysql://localhost:3306/customer_db";
        private static final String DB_USER = "your_database_username";
        private static final String DB_PASSWORD = "your_database_password";

        public static Connection getConnection() throws SQLException {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }
            return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        }
    }
    ```

2. **JWT Configuration**: Configure the JWT settings in `JWTAuthenticationFilter.java` according to your security needs.

### Building and Running the Project

1. **Compile the Project**: Dynamic Web Project

2. **Deploy the Application**: Deploy the WAR file to your servlet container (e.g., Apache Tomcat).

3. **Access the Application**: Open your browser and go to `http://localhost:8080/Customer_App`.

## File Descriptions

- **Servlets**:
  - `CreateCustomerServlet.java`: Handles the creation of new customers.
  - `UpdateCustomerServlet.java`: Handles updating existing customer details.
  - `GetCustomerServlet.java`: Retrieves a single customer based on ID.
  - `DeleteCustomerServlet.java`: Handles deletion of a customer.
  - `ListCustomersServlet.java`: Lists all customers with pagination, sorting, and searching.
  - `LoginServlet.java:Helps to login to see the Customer details

- **Model**:
  - `Customer.java`: Represents the customer data model.

- **Utilities**:
  - `DBUtil.java`: Provides methods to connect to the MySQL database.
  - `PasswordUtil.java`:for password Authentication
  - `JWTAuthenticationFilter.java`: Handles JWT authentication and authorization.

- **JSP Files**:
  - `index.jsp`: Main page showing the customer list and links to other functionalities.
  - `createCustomer.jsp`: Form for adding a new customer.
  - `listCustomers.jsp`: Displays the list of customers.

- **WEB-INF**:
  - `web.xml`: Servlet configuration and mappings.

## Usage

1. **Login**: Access `login.jsp` to authenticate and obtain a JWT token.
2. **Manage Customers**: Use `index.jsp` to view and manage customer data.
3. **Add Customers**: Use `createCustomer.jsp` to add new customers.








