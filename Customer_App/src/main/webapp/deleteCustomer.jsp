<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete Customer</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh; /* Ensure the page is centered vertically */
        }
        .container {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 800px;
        }
        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
            color: #333;
            font-weight: bold;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        form {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        button {
            background-color: #d9534f;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin-right: 10px;
        }
        button:hover {
            background-color: #c9302c;
        }
        a {
            color: #007bff;
            text-decoration: none;
            font-size: 16px;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Delete Customer</h2>
        
        <% 
            // Retrieve the customer ID from the request
            String idStr = request.getParameter("id");
            if (idStr != null && !idStr.isEmpty()) {
                int id = Integer.parseInt(idStr);

                // Fetch the customer details from the database
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;
                try {
                    // Database connection details
                    String URL = "jdbc:mysql://127.0.0.1:3306/customer_db";
                    String USER = "root";
                    String PASSWORD = "root";
                    
                    conn = DriverManager.getConnection(URL, USER, PASSWORD);
                    String sql = "SELECT * FROM customers WHERE id = ?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setInt(1, id);
                    rs = pstmt.executeQuery();

                    if (rs.next()) {
                        // Display customer details
        %>
                        <form action="deleteCustomer" method="get">
                            <p>Are you sure you want to delete the following customer?</p>
                            <table>
                                <tr>
                                    <th>ID</th>
                                    <td><%= rs.getInt("id") %></td>
                                </tr>
                                <tr>
                                    <th>First Name</th>
                                    <td><%= rs.getString("first_name") %></td>
                                </tr>
                                <tr>
                                    <th>Last Name</th>
                                    <td><%= rs.getString("last_name") %></td>
                                </tr>
                                <tr>
                                    <th>Street</th>
                                    <td><%= rs.getString("street") %></td>
                                </tr>
                                <tr>
                                    <th>Address</th>
                                    <td><%= rs.getString("address") %></td>
                                </tr>
                                <tr>
                                    <th>City</th>
                                    <td><%= rs.getString("city") %></td>
                                </tr>
                                <tr>
                                    <th>State</th>
                                    <td><%= rs.getString("state") %></td>
                                </tr>
                                <tr>
                                    <th>Email</th>
                                    <td><%= rs.getString("email") %></td>
                                </tr>
                                <tr>
                                    <th>Phone</th>
                                    <td><%= rs.getString("phone") %></td>
                                </tr>
                            </table>
                            <input type="hidden" name="id" value="<%= id %>">
                            <button type="submit">Delete</button>
                            <a href="listCustomers.jsp">Cancel</a>
                        </form>
        <% 
                    } else {
                        out.println("<p>No customer found with ID " + id + "</p>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<p>Error fetching customer details.</p>");
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (pstmt != null) pstmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            } else {
                out.println("<p>Invalid customer ID.</p>");
            }
        %>
    </div>
</body>
</html>
