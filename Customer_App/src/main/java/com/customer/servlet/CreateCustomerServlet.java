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
import java.sql.SQLException;

@WebServlet("/createCustomer")
public class CreateCustomerServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String street = request.getParameter("street");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        Customer customer = new Customer();
        customer.setFirstName(firstName);
        customer.setLastName(lastName);
        customer.setStreet(street);
        customer.setAddress(address);
        customer.setCity(city);
        customer.setState(state);
        customer.setEmail(email);
        customer.setPhone(phone);

        try (Connection connection = DBUtil.getConnection()) {
            String sql = "INSERT INTO customers (first_name, last_name, street, address, city, state, email, phone) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, customer.getFirstName());
                statement.setString(2, customer.getLastName());
                statement.setString(3, customer.getStreet());
                statement.setString(4, customer.getAddress());
                statement.setString(5, customer.getCity());
                statement.setString(6, customer.getState());
                statement.setString(7, customer.getEmail());
                statement.setString(8, customer.getPhone());

                statement.executeUpdate();
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }

        response.sendRedirect("listCustomers");
    }
}
