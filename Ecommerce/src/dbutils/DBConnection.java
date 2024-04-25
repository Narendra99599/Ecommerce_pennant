package dbutils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	public static final String URL = "jdbc:postgresql://192.168.110.48:5432/plf_training";
	public static final String UNAME = "plf_training_admin";
	public static final String PWD = "pff123";

	public static Connection getConnection() throws SQLException {
		try {
			Class.forName("org.postgresql.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		return DriverManager.getConnection(URL, UNAME, PWD);
	}
}
