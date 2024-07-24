<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, com.customer.util.DBUtil" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Management System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        h1 {
            background-color: #007bff;
            color: #ffffff;
            padding: 1rem;
            width: 100%;
            text-align: center;
            margin: 0;
        }

        div.container {
            width: 80%;
            max-width: 1200px;
            padding: 2rem;
            background: #ffffff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-top: 2rem;
        }

        a {
            color: #007bff;
            text-decoration: none;
            font-weight: bold;
            margin-right: 1rem;
        }

        a:hover {
            text-decoration: underline;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
        }

        table th, table td {
            border: 1px solid #ddd;
            padding: 0.75rem;
            text-align: left;
        }

        table th {
            background-color: #007bff;
            color: #ffffff;
        }

        table tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        table tr:hover {
            background-color: #f1f1f1;
        }

        .actions a {
            margin-right: 0.5rem;
            color: #dc3545;
        }

        .actions a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <h1>Customer Management System</h1>

    <div class="container">
        <div style="text-align: right; margin-bottom: 1rem;">
            <a href="login.jsp">Login</a>
            <a href="createCustomer.jsp">Add Customer</a>
            <a href="sync.jsp">Sync Customer Data</a>
        </div>

        <h2>Customers</h2>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Street</th>
                    <th>Address</th>
                    <th>City</th>
                    <th>State</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        Connection conn = DBUtil.getConnection();
                        String sql = "SELECT * FROM customers";
                        PreparedStatement stmt = conn.prepareStatement(sql);
                        ResultSet rs = stmt.executeQuery();
                        while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getInt("id") %></td>
                    <td><%= rs.getString("first_name") %></td>
                    <td><%= rs.getString("last_name") %></td>
                    <td><%= rs.getString("street") %></td>
                    <td><%= rs.getString("address") %></td>
                    <td><%= rs.getString("city") %></td>
                    <td><%= rs.getString("state") %></td>
                    <td><%= rs.getString("email") %></td>
                    <td><%= rs.getString("phone") %></td>
                    <td class="actions">
                        <a href="updateCustomer.jsp?id=<%= rs.getInt("id") %>">Edit</a>
                        <a href="deleteCustomer.jsp?id=<%= rs.getInt("id") %>">Delete</a>
                    </td>
                </tr>
                <%
                        }
                        conn.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
