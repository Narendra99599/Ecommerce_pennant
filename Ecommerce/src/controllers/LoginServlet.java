package controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import daos.UserDAO;
import models.User;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		System.out.println(email + password);
		User user = UserDAO.getUserByEmail(email);
		System.out.println(user);
		if (user != null && user.getPassword().equals(password)) {
			HttpSession hs = request.getSession();
			hs.setAttribute("LOGGEDIN", "YES");
			response.sendRedirect("index.jsp");
		} else {
			response.sendRedirect("register.html");
		}
	}

}
