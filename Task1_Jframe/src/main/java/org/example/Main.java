package org.example;

import org.example.Controller.LoginController;
import org.example.View.LoginView;

public class Main {
    public static void main(String[] args) {
        LoginView view= new LoginView();
        LoginController controller = new LoginController(view);
        view.setVisible(true);
    }
}