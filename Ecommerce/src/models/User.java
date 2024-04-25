package models;

public class User {
	private String email;
	private String password;

	public User(String email, String password) {
		this.email = email;
		this.password = password;
	}

	// Getters and setters
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	@Override
	public String toString() {
		return "User [email=" + email + ", password=" + password + "]";
	}

	public void setPassword(String password) {
		this.password = password;
	}
}
