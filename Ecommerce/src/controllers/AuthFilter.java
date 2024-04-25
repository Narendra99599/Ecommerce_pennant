package controllers;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter({ "/cart" })
public class AuthFilter implements Filter {

	@Override
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest httpReq = (HttpServletRequest) req;
		HttpServletResponse httpRes = (HttpServletResponse) res;

		HttpSession session = httpReq.getSession(false);
		String isLoggedIn = session != null ? (String) session.getAttribute("LOGGEDIN") : null;

		if (isLoggedIn == null || !isLoggedIn.equals("YES")) {
			httpRes.sendRedirect("login.html");
		} else {
			chain.doFilter(req, res);
		}
	}
}
