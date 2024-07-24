<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, com.customer.util.DBUtil" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh; /* Adjusted to ensure the container is centered */
        }
        .container {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 1100px;
            margin: 1rem;
        }
        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 0 auto;
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
        .actions {
            display: flex;
            gap: 10px; /* Space between buttons */
            justify-content: center;
        }
        .actions a {
            display: inline-block;
            padding: 5px 10px; /* Adjusted padding */
            font-size: 14px;
            color: #007bff;
            text-decoration: none;
            border: 1px solid #007bff;
            border-radius: 4px;
            transition: background-color 0.3s, color 0.3s;
            text-align: center;
        }
        .actions a:hover {
            background-color: #007bff;
            color: #fff;
        }
        .error-message {
            color: red;
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Customer List</h1>
        <table>
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
            <%
                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;
                try {
                    conn = DBUtil.getConnection();
                    String sql = "SELECT * FROM customers";
                    stmt = conn.prepareStatement(sql);
                    rs = stmt.executeQuery();
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
                } catch (Exception e) {
                    out.println("<tr><td colspan='10' class='error-message'>Error retrieving customer list. Please try again later.</td></tr>");
                    e.printStackTrace();  // Optionally log this error instead
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    } catch (Exception e) {
                        e.printStackTrace();  // Optionally log this error instead
                    }
                }
            %>
        </table>
    </div>
</body>
</html>
