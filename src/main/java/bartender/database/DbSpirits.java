package bartender.database;

import java.util.List;
import java.util.Map;

/**
 * Created by Jaspar Mang on 12.01.17.
 */
public class DbSpirits extends DbObject {

    public List<Map<String, Object>> getSpirits() {
        String sql = "SELECT * FROM spirits";
        return executeStatementReturnsListMapWithMapWithKeys(sql, "name");
    }

    public Map<String, Object> getSpirit(String name) {
        String sql = "SELECT * FROM spirits WHERE name='" + name + "'";
        return executeStatementReturnsMap(sql);
    }

    public void setInStockOfSpirit(boolean inStock, String name) {
        String sql = "UPDATE `bartender`.`spirits` SET `in_stock` = " + inStock + " WHERE `spirits`.`name` = '" + name +
                     "'";
        executeUpdateStatement(sql);
    }

    public String getPump(String name){
        String sql = "SELECT pump FROM spirits WHERE name='" + name + "'";
        return executeStatementReturnsString(sql, "pump");
    }

}
