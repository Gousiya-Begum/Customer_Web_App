package com.customer.servlet;

import com.customer.util.DBUtil;
import org.json.JSONArray;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/syncCustomerData")
public class SyncCustomerDataServlet extends HttpServlet {

    private static final String REMOTE_API_URL = "https://remote.api/customers";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bearerToken = System.getenv("BEARER_TOKEN");
        if (bearerToken == null || bearerToken.isEmpty()) {
            throw new ServletException("Bearer token is not set in the environment variables");
        }

        try {
            URL url = new URL(REMOTE_API_URL);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");
            connection.setRequestProperty("Authorization", "Bearer " + bearerToken);

            BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
            StringBuilder content = new StringBuilder();
            String inputLine;
            while ((inputLine = in.readLine()) != null) {
                content.append(inputLine);
            }
            in.close();
            connection.disconnect();

            JSONArray jsonArray = new JSONArray(content.toString());
            syncCustomerData(jsonArray);

            response.sendRedirect("index.jsp");

        } catch (Exception e) {
            throw new ServletException("Error syncing customer data", e);
        }
    }

    private void syncCustomerData(JSONArray jsonArray) throws SQLException {
        String sql = "INSERT INTO customers (first_name, last_name, street, address, city, state, email, phone) VALUES (?, ?, ?, ?, ?, ?, ?, ?) " +
                     "ON DUPLICATE KEY UPDATE first_name=VALUES(first_name), last_name=VALUES(last_name), street=VALUES(street), address=VALUES(address), city=VALUES(city), state=VALUES(state), phone=VALUES(phone)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            for (int i = 0; i < jsonArray.length(); i++) {
                JSONObject jsonObject = jsonArray.getJSONObject(i);
                stmt.setString(1, jsonObject.getString("first_name"));
                stmt.setString(2, jsonObject.getString("last_name"));
                stmt.setString(3, jsonObject.getString("street"));
                stmt.setString(4, jsonObject.getString("address"));
                stmt.setString(5, jsonObject.getString("city"));
                stmt.setString(6, jsonObject.getString("state"));
                stmt.setString(7, jsonObject.getString("email"));
                stmt.setString(8, jsonObject.getString("phone"));
                stmt.addBatch();
            }
            stmt.executeBatch();
        }
    }
}
