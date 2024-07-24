package com.customer.servlet;

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
@WebServlet("/deleteCustomer")
public class DeleteCustomerServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect("error.jsp"); // Redirect to an error page or show an error message
            return;
        }

        try {
            int id = Integer.parseInt(idParam);
            // Proceed with deleting the customer with the given id
            // Example:
            deleteCustomer(id);
            response.sendRedirect("index.jsp");
        } catch (NumberFormatException e) {
            response.sendRedirect("error.jsp"); // Redirect to an error page or show an error message
        }
    }

    private void deleteCustomer(int id) throws ServletException {
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "DELETE FROM customers WHERE id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, id);
                stmt.executeUpdate();
            }
        } catch (SQLException e) {
            throw new ServletException("Error deleting customer", e);
        }
    }
}
