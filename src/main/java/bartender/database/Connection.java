package bartender.database;


import bartender.utils.Properties;

import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ResourceBundle;


/**
 * This class knows the database credentials and provides a method to connect to the database. It initializes the JDBC
 * Driver and checks whether the schema version used in the database is smaller then the version used by the engine. In
 * that case the database is updated.
 */
public final class Connection {
    private static Connection instance = null;
    private String username;
    private String password;
    private String url;
    private static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";

    /**
     * Empty constructor. Use getInstance() to get the singleton instance.
     */
    private Connection() {
    }

    /**
     * This method builds a connection for the database with the credentials taken from the config.properties file. It
     * compares the schema version to the version used in the database and "updates" the database by dropping the schema
     * and executing a SQL script to recreate it.
     *
     * @return the instance of a new Connection.
     */
    public static synchronized Connection getInstance() {
        if (instance == null) {
            instance = new Connection();
            instance.initializeDatabaseConfiguration();
        }
        return instance;
    }

    /**
     * Connects to the database and return the {@link java.sql.Connection} object.
     *
     * @return the open connection
     */
    public java.sql.Connection connect() {
        java.sql.Connection conn = null;
        try {
            // Register JDBC driver
            Class.forName(JDBC_DRIVER);
            // Open a connection
            conn = DriverManager.getConnection(url, username, password);
        } catch (ClassNotFoundException | SQLException e) {
            // Handle errors for Class.forName
            e.printStackTrace();
        }
        return conn;
    }

    /**
     * Reads database credentials from the property file and stores them in fields.
     */
    private void initializeDatabaseConfiguration() {
        Properties properties = Properties.getInstance();

        username = properties.getDbUsername();
        password = properties.getDbPassword();
        url = properties.getDbUrl();
    }

}