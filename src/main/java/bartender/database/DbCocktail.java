package bartender.database;

import java.util.List;
import java.util.Map;

/**
 * Created by Jaspar Mang on 12.01.17.
 */
public class DbCocktail extends DbObject {

    public List<Map<String, Object>> getCocktails() {
        String sql
                = "SELECT cocktails.name, cocktails.description FROM cocktails, ingredients, spirits " +
                  "WHERE cocktail_name = cocktails.name AND spirit_name = spirits.name AND spirits.in_stock = TRUE " +
                  "GROUP BY cocktails.name";
        return executeStatementReturnsListMapWithMapWithKeys(sql, "name");
    }

    public Map<String, Object> getCocktail(String name) {
        String sql = "SELECT cocktails.name, cocktails.description FROM cocktails, ingredients, spirits " +
                     "WHERE cocktail_name = cocktails.name AND spirit_name = spirits.name AND spirits.in_stock = TRUE " +
                     "AND cocktails.name='" + name + "'";
        return executeStatementReturnsMap(sql);
    }
}
