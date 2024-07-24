package com.customer.servlet;

import com.customer.model.Customer;
import com.customer.util.DBUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/updateCustomer")
public class UpdateCustomerServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect("error.jsp"); // Redirect to an error page or show an error message
            return;
        }

        int id;
        try {
            id = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            response.sendRedirect("error.jsp"); // Redirect to an error page or show an error message
            return;
        }

        Customer customer = null;

        try (Connection connection = DBUtil.getConnection()) {
            String sql = "SELECT * FROM customers WHERE id = ?";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setInt(1, id);
                try (ResultSet resultSet = statement.executeQuery()) {
                    if (resultSet.next()) {
                        customer = new Customer();
                        customer.setId(resultSet.getInt("id"));
                        customer.setFirstName(resultSet.getString("first_name"));
                        customer.setLastName(resultSet.getString("last_name"));
                        customer.setStreet(resultSet.getString("street"));
                        customer.setAddress(resultSet.getString("address"));
                        customer.setCity(resultSet.getString("city"));
                        customer.setState(resultSet.getString("state"));
                        customer.setEmail(resultSet.getString("email"));
                        customer.setPhone(resultSet.getString("phone"));
                    } else {
                        response.sendRedirect("error.jsp"); // Redirect to an error page or show an error message
                        return;
                    }
                }
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }

        request.setAttribute("customer", customer);
        request.getRequestDispatcher("updateCustomer.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect("error.jsp"); // Redirect to an error page or show an error message
            return;
        }

        int id;
        try {
            id = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            response.sendRedirect("error.jsp"); // Redirect to an error page or show an error message
            return;
        }

        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String street = request.getParameter("street");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        if (firstName == null || lastName == null || street == null || address == null ||
            city == null || state == null || email == null || phone == null) {
            response.sendRedirect("error.jsp"); // Redirect to an error page or show an error message
            return;
        }

        try (Connection connection = DBUtil.getConnection()) {
            String sql = "UPDATE customers SET first_name = ?, last_name = ?, street = ?, address = ?, city = ?, state = ?, email = ?, phone = ? WHERE id = ?";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, firstName);
                statement.setString(2, lastName);
                statement.setString(3, street);
                statement.setString(4, address);
                statement.setString(5, city);
                statement.setString(6, state);
                statement.setString(7, email);
                statement.setString(8, phone);
                statement.setInt(9, id);

                statement.executeUpdate();
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }

        response.sendRedirect("listCustomers");
    }
}
