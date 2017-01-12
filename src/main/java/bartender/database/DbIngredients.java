package bartender.database;

import java.util.List;
import java.util.Map;

/**
 * Created by Jaspar Mang on 12.01.17.
 */
public class DbIngredients extends DbObject {

    public List<Map<String, Object>> getIngredientsForCocktail(String cocktail){
        String sql = "SELECT * FROM ingredients WHERE cocktail_name ='" + cocktail +"'";
        return executeStatementReturnsListMapWithMapWithKeys(sql, "spirit_name", "quantity", "in_stock");
    }
}
