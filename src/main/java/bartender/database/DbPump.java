package bartender.database;

/**
 * Created by Jaspar Mang on 14.01.17.
 */
public class DbPump extends DbObject{
    public int getPinForPump(String pump){
        String sql = "SELECT pin FROM pumps WHERE name = '" + pump +"'";
        return executeStatementReturnsInt(sql, "pin");
    }

    public int getMillisForCentiliterForPump(String pump){
        String sql = "SELECT millis_for_centiliter FROM pumps WHERE name = '" + pump +"'";
        return executeStatementReturnsInt(sql, "millis_for_centiliter");
    }
}
