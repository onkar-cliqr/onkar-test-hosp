package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Properties;
import java.util.ResourceBundle;

public class DBConnection {

	public String sDriverName = null;
	public String sServerName = null;
	public String sPort = null;
	public String sDatabaseName = null;
	public String sUserName = null;
	public String sPassword = null;
	public static Connection conn = null;

	public Connection getDBConnection() throws Exception {
		if (conn == null) {
			conn = null;
			// Properties prop=new Properties();
			// prop.load(getServletContext().getResourceAsStream("/WEB-INF/properties/sample.properties"));
			ResourceBundle rb = ResourceBundle.getBundle("connection_config");
			sDriverName = rb.getString("driver.name");
			sServerName = rb.getString("server.name");
			sPort = rb.getString("port.no");
			sDatabaseName = rb.getString("database.name");
			sUserName = rb.getString("user.name");
			sPassword = rb.getString("user.password");
			Class.forName(sDriverName).newInstance();
			String sURL = sServerName + ":" + sPort + "/" + sDatabaseName;
			conn = DriverManager.getConnection(sURL, sUserName, sPassword);
			System.out.println("successful connected");
			return conn;
		} else {
			return conn;
		}
	}

	public void closeDBConnection() {
		try {

			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}