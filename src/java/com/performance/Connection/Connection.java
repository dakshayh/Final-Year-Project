
package com.Performance.Connection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionFactory{
    
        private static ConnectionFactory instance = new ConnectionFactory();
	public static final String Connect = "jdbc:mysql://localhost:3306/performance";
	public static final String UserName = "root";
	public static final String PassWord = "root";
	public static final String Url = "com.mysql.jdbc.Driver"; 
	
	
	private ConnectionFactory() {
		try {
			Class.forName(Url);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	private Connection createConnection() {
		Connection connection = null;
		try {
			connection = DriverManager.getConnection(Connect, UserName, PassWord);
		} catch (SQLException e) {
			System.out.println("ERROR: Unable to Connect to Database.");
		}
		return connection;
	}	
	
	public static Connection getConnection() {
		return instance.createConnection();
	}
    
}
