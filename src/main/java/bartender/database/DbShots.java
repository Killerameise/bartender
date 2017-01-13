package bartender.database;

import java.util.List;
import java.util.Map;

/**
 * Created by Jaspar Mang on 12.01.17.
 */
public class DbShots extends DbObject{

    public List<Map<String, Object>> getShots() {
        String sql = "SELECT name FROM spirits WHERE in_stock = true";
        return executeStatementReturnsListMapWithMapWithKeys(sql, "name");
    }

    public Map<String, Object> getShot(String name) {
        String sql = "SELECT name, description FROM spirits WHERE in_stock = true AND name='" + name +"'";
        return executeStatementReturnsMap(sql);
    }


}
