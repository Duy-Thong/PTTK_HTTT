package org.example.logindemojsp;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    public static Connection getConnection() {
        Connection connection = null;
        try {
            // Tải driver JDBC
            Class.forName("com.mysql.cj.jdbc.Driver");

            // URL kết nối
            String url = "jdbc:mysql://localhost:3306/user_management";
            String user = "root"; // Thay thế bằng tên người dùng của bạn
            String password = ""; // Thay thế bằng mật khẩu của bạn

            // Kết nối đến cơ sở dữ liệu
            connection = DriverManager.getConnection(url, user, password);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return connection;
    }
}
