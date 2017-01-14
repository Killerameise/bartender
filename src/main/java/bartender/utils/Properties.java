package bartender.utils;

import java.util.ResourceBundle;

/**
 * Created by Jaspar Mang on 14.01.17.
 */
public class Properties {
    private static Properties instance;
    private ResourceBundle resourceBundle;

    private Properties(){}

    public static synchronized Properties getInstance() {
        if (instance == null) {
            instance = new Properties();
            instance.resourceBundle = ResourceBundle.getBundle("application");
        }
        return instance;
    }

    public String getDbUsername(){
        return resourceBundle.getString("db_username");
    }
    public String getDbPassword(){
        return resourceBundle.getString("db_password");
    }
    public String getDbUrl(){
        return resourceBundle.getString("db_url");
    }

    public boolean getOnRaspberryPi(){
        return Boolean.parseBoolean(resourceBundle.getString("on_raspberry_pi"));
    }
}
