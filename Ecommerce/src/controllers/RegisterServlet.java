package controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import daos.UserDAO;
import models.UserData;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String password = request.getParameter("password");
		String address = request.getParameter("address");

		// Check if user is already registered
		if (UserDAO.isUserRegistered(email)) {
			response.sendRedirect("login.jsp");
			return;
		}

		// Register the user
		UserData user = new UserData(name, email, phone, password, address);
		UserDAO.addUser(user);

		// Redirect to login page after successful registration
		response.sendRedirect("login.html");
	}
}
