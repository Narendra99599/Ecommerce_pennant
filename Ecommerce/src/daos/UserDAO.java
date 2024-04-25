package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dbutils.DBConnection;
import models.User;
import models.UserData;

public class UserDAO {
	public static User getUserByEmail(String email) {
		String query = "SELECT cemail,cpassword FROM os_customer WHERE cemail=?";
		try (Connection con = DBConnection.getConnection(); PreparedStatement pst = con.prepareStatement(query)) {
			pst.setString(1, email);
			try (ResultSet rs = pst.executeQuery()) {
				if (rs.next()) {
					String password = rs.getString("cpassword");
					return new User(email, password);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public static void addUser(UserData user) {
		String query = "INSERT INTO os_customer (cname, cemail, cmobile, cpassword, clocation) VALUES (?, ?, ?, ?, ?)";
		try (Connection con = DBConnection.getConnection(); PreparedStatement pst = con.prepareStatement(query)) {
			pst.setString(1, user.getName());
			pst.setString(2, user.getEmail());
			pst.setString(3, user.getPhone());
			pst.setString(4, user.getPassword());
			pst.setString(5, user.getAddress());
			pst.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static boolean isUserRegistered(String email) {
		String query = "SELECT COUNT(*) FROM os_customer WHERE cemail=?";
		try (Connection con = DBConnection.getConnection(); PreparedStatement pst = con.prepareStatement(query)) {
			pst.setString(1, email);
			try (ResultSet rs = pst.executeQuery()) {
				if (rs.next()) {
					int count = rs.getInt(1);
					return count > 0;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

}
