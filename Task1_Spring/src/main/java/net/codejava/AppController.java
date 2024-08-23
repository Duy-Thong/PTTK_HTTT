package net.codejava;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AppController {

	@Autowired
	private UserRepository userRepo;
	
	@GetMapping("")
	public String viewHomePage() {
		return "index";
	}
	@GetMapping("/login")
	public String showLoginPage() {
		return "login";  // Thymeleaf template named login.html
	}
	@GetMapping("/change_password")
	public String showChangePasswordPage() {
		return "change_password";
	}

	@PostMapping("/process_change_password")
	public String processChangePassword(
			@RequestParam("currentPassword") String currentPassword,
			@RequestParam("newPassword") String newPassword,
			@RequestParam("confirmPassword") String confirmPassword,
			Principal principal,
			Model model) {

		if (newPassword == null || confirmPassword == null || currentPassword == null) {
			model.addAttribute("error", "Password fields cannot be empty");
			return "change_password";
		}

		if (!newPassword.equals(confirmPassword)) {
			model.addAttribute("error", "New passwords do not match");
			return "change_password";
		}

		String username = principal.getName();
		User user = userRepo.findByEmail(username);
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

		if (!encoder.matches(currentPassword, user.getPassword())) {
			model.addAttribute("error", "Current password is incorrect");
			return "change_password";
		}

		user.setPassword(encoder.encode(newPassword));
		userRepo.save(user);

		return "login";
	}
	@GetMapping("/forgot_password")
	public String showForgotPasswordPage() {
		return "forgot_password";
	}
	@PostMapping("/process_forgot_password")
	public String processForgotPassword(@RequestParam("username") String username, Model model) {
		// Add logic for handling forgot password here
		// For example, generate a password reset token and send an email

		// Add the username to the model
		model.addAttribute("email", username);
		return "success_forgot_password";
	}



	@GetMapping("/register")
	public String showRegistrationForm(Model model) {
		model.addAttribute("user", new User());
		
		return "signup_form";
	}
	
	@PostMapping("/process_register")
	public String processRegister(User user) {
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		String encodedPassword = passwordEncoder.encode(user.getPassword());
		user.setPassword(encodedPassword);
		
		userRepo.save(user);
		
		return "register_success";
	}
	
	@GetMapping("/users")
	public String listUsers(Model model) {

		return "users";
	}
	@PostMapping("/change_password")
	public String changePassword(
			@RequestParam("currentPassword") String currentPassword,
			@RequestParam("newPassword") String newPassword,
			@RequestParam("confirmPassword") String confirmPassword,
			Principal principal,
			Model model) {

		if (newPassword == null || confirmPassword == null) {
			model.addAttribute("error", "Password fields cannot be empty");
			return "change_password";
		}

		if (!newPassword.equals(confirmPassword)) {
			model.addAttribute("error", "New passwords do not match");
			return "change_password";
		}

		String username = principal.getName();
		User user = userRepo.findByEmail(username);
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

		if (!encoder.matches(currentPassword, user.getPassword())) {
			model.addAttribute("error", "Current password is incorrect");
			return "change_password";
		}

		user.setPassword(encoder.encode(newPassword));
		userRepo.save(user);

		return "login";
	}

}
