package bartender.rest;

import bartender.database.DbCocktail;
import bartender.database.DbIngredients;
import bartender.database.DbShots;
import bartender.database.DbSpirits;
import com.google.common.net.UrlEscapers;
import com.google.gson.Gson;
import org.json.JSONException;
import org.json.JSONObject;

import javax.ws.rs.*;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriInfo;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 * Created by Jaspar Mang on 10.01.17.
 */

@Path("interface/v1")
public class Rest extends AbstractRest {
    private static final int[]         SHOT_SIZES    = new int[]{1, 2, 4};
    private final        DbSpirits     dbSpirits     = new DbSpirits();
    private final        DbCocktail    dbCocktail    = new DbCocktail();
    private final        DbShots       dbShots       = new DbShots();
    private final        DbIngredients dbIngredients = new DbIngredients();
    private final        Gson          gson          = new Gson();

    @GET
    @Path("cocktails")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getCocktails(@Context UriInfo uriInfo) {
        List<Map<String, Object>> cocktails = dbCocktail.getCocktails();
        addUrlToListMap(cocktails, uriInfo, "name", true);
        return buildOkResponse(gson.toJson(cocktails));
    }

    @GET
    @Path("shots")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getShots(@Context UriInfo uriInfo) {
        List<Map<String, Object>> shots = dbShots.getShots();
        addUrlToListMap(shots, uriInfo, "name", true);
        return buildOkResponse(gson.toJson(shots));
    }

    @GET
    @Path("spirits")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getSpirits(@Context UriInfo uriInfo) {
        List<Map<String, Object>> spirits = dbSpirits.getSpirits();
        addUrlToListMap(spirits, uriInfo, "name", true);
        return buildOkResponse(gson.toJson(spirits));
    }

    @GET
    @Path("spirits/{spiritName}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getSpirit(@Context UriInfo uriInfo, @PathParam("spiritName") String spiritName) {
        Map<String, Object> spirit = dbSpirits.getSpirit(spiritName);
        if (spirit != null) {
            addUrlToMap(spirit, uriInfo, "toggle_in_stock", false);
            return buildOkResponse(gson.toJson(spirit));
        }
        return buildNotFoundResponse("{\"error\":\"There is no spirit with the Name " + spiritName + ".\"}");

    }

    @GET
    @Path("cocktails/{cocktailName}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getCocktail(@Context UriInfo uriInfo, @PathParam("cocktailName") String cocktailName) {
        return getDrink(DrinkType.COCKTAIL, cocktailName, uriInfo);
    }

    @GET
    @Path("shots/{shotName}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getShot(@Context UriInfo uriInfo, @PathParam("shotName") String shotName) {
        return getDrink(DrinkType.SHOT, shotName, uriInfo);
    }

    private Response getDrink(DrinkType drinkType, String drinkName, UriInfo uriInfo) {
        Map<String, Object> drink = null;
        if (drinkType == DrinkType.SHOT) {
            drink = dbShots.getShot(drinkName);
        } else if (drinkType == DrinkType.COCKTAIL) {
            drink = dbCocktail.getCocktail(drinkName);
            if (drink != null) {
                List<Map<String, Object>> ingredients = dbIngredients.getIngredientsForCocktail(drinkName);
                drink.put("ingredients", ingredients);
            }
        }
        if (drink != null) {
            addUrlToMap(drink, uriInfo, "make", false);
            return buildOkResponse(gson.toJson(drink));
        }
        return buildNotFoundResponse(
                "{\"error\":\"There is no " + drinkType.getName() + " with the Name " + drinkName + ".\"}");

    }

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Path("shots/{shotName}/make")
    public Response makeShot(@PathParam("shotName") String shotName, String postBody) {
        JSONObject postJson = new JSONObject(postBody);
        if (postJson.has("centiliter")) {
            int centiliter;
            try {
                centiliter = postJson.getInt("centiliter");
            } catch (JSONException e) {
                return buildBadRequestResponse("{\"error\":\"Centiliter has to be an integer value.\"}");
            }
            if (Arrays.stream(SHOT_SIZES).anyMatch(s -> s == centiliter)) {
                if(dbShots.getShot(shotName)!=null) {
                    String spirits_pump = dbSpirits.getPump(shotName);
                    //TODO: make shot
                    return buildAcceptedResponse("{\"message\":\"Makes shot with pump "+ spirits_pump + ".\"}");
                }else{
                    return buildNotFoundResponse("{\"error\":\"There is no spirit with the Name " + shotName + ".\"}");

                }
            } else {
                return buildBadRequestResponse("{\"error\":\"Centiliter has to be 1, 2 or 4.\"}");
            }
        }

    return buildBadRequestResponse("{\"error\":\"Centiliter has to be 1, 2 or 4.\"}");
}

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Path("spirits/{spiritName}/toggle_in_stock")
    public Response toggleSpiritInStock(@PathParam("spiritName") String spiritName) {
        Map<String, Object> spirit = dbSpirits.getSpirit(spiritName);
        if (spirit != null) {
            boolean in_stock = (Boolean) spirit.get("in_stock");
            dbSpirits.setInStockOfSpirit(!in_stock, spiritName);
            return buildOkResponse("{\"message\":\"In stock of " + spiritName + " was set to " + !in_stock + ".\"}");
        }
        return buildNotFoundResponse("{\"error\":\"There is no spirit with the Name " + spiritName + ".\"}");
    }

    private void addUrlToListMap(List<Map<String, Object>> dbEntries, UriInfo uriInfo, String key, boolean dynamic) {
        dbEntries.stream().forEach(dbEntry -> addUrlToMap(dbEntry, uriInfo, key, dynamic));
    }

    private void addUrlToMap(Map<String, Object> dbEntry, UriInfo uriInfo, String key, boolean dynamic) {
        String uri = uriInfo.getAbsolutePath().toString();
        if (!Objects.equals(uri.substring(uri.length() - 1), "/")) {
            uri = uri + "/";
        }
        if (dynamic) {
            dbEntry.put("link", uri + UrlEscapers.urlFragmentEscaper().escape(dbEntry.get(key).toString()));
        } else {
            dbEntry.put("link", uri + UrlEscapers.urlFragmentEscaper().escape(key));
        }
    }

private enum DrinkType {
    SHOT("shot"),
    COCKTAIL("cocktail");

    private final String name;

    DrinkType(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }
}
}