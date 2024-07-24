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
import java.util.ArrayList;
import java.util.List;

@WebServlet("/listCustomers")
public class ListCustomersServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Customer> customers = new ArrayList<>();

        try (Connection connection = DBUtil.getConnection()) {
            String sql = "SELECT * FROM customers";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                try (ResultSet resultSet = statement.executeQuery()) {
                    while (resultSet.next()) {
                        Customer customer = new Customer();
                        customer.setId(resultSet.getInt("id"));
                        customer.setFirstName(resultSet.getString("first_name"));
                        customer.setLastName(resultSet.getString("last_name"));
                        customer.setStreet(resultSet.getString("street"));
                        customer.setAddress(resultSet.getString("address"));
                        customer.setCity(resultSet.getString("city"));
                        customer.setState(resultSet.getString("state"));
                        customer.setEmail(resultSet.getString("email"));
                        customer.setPhone(resultSet.getString("phone"));
                        customers.add(customer);
                    }
                }
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }

        request.setAttribute("customers", customers);
        request.getRequestDispatcher("listCustomers.jsp").forward(request, response);
    }
}
