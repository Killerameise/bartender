package bartender.database;

/**
 * Created by Jaspar Mang on 14.01.17.
 */
public class DbPump extends DbObject{
    public int getPin1ForPump(String pump){
        String sql = "SELECT pin1 FROM pumps WHERE name = '" + pump +"'";
        return executeStatementReturnsInt(sql, "pin1");
    }
}
