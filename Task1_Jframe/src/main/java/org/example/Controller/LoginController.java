package org.example.Controller;


import org.example.Model.LoginModel;
import org.example.View.LoginView;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class LoginController {
    private LoginModel model;
    private LoginView view;

    public LoginController(LoginView view){
        this.view = view;

        view.addLoginListener(new LoginListener());
    }

    class LoginListener implements ActionListener {
        public void actionPerformed(ActionEvent e) {
            try {
                model = view.getUser();
                if(checkUser(model)){
                    view.showMessage("Login succesfully!");
                }else{
                    view.showMessage("Invalid username and/or password!");
                }
            } catch (Exception ex) {
                view.showMessage(ex.getStackTrace().toString());
            }
        }
    }

    public boolean checkUser(LoginModel user) throws Exception {

        // Thông tin kết nối
        String url = "jdbc:mysql://localhost:3306/ecommerce_db"; // Thay thế 'your_database_name' bằng tên database của bạn
        String username = "root"; // Username mặc định của MySQL trên XAMPP thường là 'root'
        String password = ""; // Mặc định, password của 'root' thường để trống trên XAMPP

        try {
            // Tạo kết nối đến cơ sở dữ liệu
            Connection conn = DriverManager.getConnection(url, username, password);

            // Kiểm tra kết nối
            if (conn != null) {
                System.out.println("Connected to the database!");

                // Tạo statement
                Statement stmt = conn.createStatement();

                // Thực thi câu truy vấn SQL
                String sql = "SELECT * FROM customers"; // Thay 'users' bằng tên bảng của bạn
                ResultSet rs = stmt.executeQuery(sql);

                // Duyệt qua kết quả
                while (rs.next()) {
                    String username1 = rs.getString("username"); // Thay 'name' bằng tên cột của bạn
                    String pass = rs.getString("password"); // Thay 'name' bằng tên cột của bạn
                    if(username1.equals(user.getUserName()) && pass.equals(user.getPassword())) return true;
                }

                // Đóng kết nối
                conn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;



//        String dbUrl = "jdbc:mysql://your.database.domain/LoginManagement";
//        String dbClass = "com.mysql.jdbc.Driver";
//        String query = "Select * FROM users WHERE username ='" + user.getUserName()
//                + "' AND password ='" + user.getPassword() + "'";
//        try {
//            Class.forName(dbClass);
//            Connection con = DriverManager.getConnection (dbUrl);
//            Statement stmt = con.createStatement();
//            ResultSet rs = stmt.executeQuery(query);
//            if (rs.next()) {
//                return true;
//            }
//            con.close();
//        }catch(Exception e) {
//            throw e;
//        }
//
//        if(user.getUserName().equals("minhpn") && user.getPassword().equals("123"))
//            return true;
//        else return false;
    }
} 