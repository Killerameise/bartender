package bartender.rest;

import bartender.database.DbCocktail;
import bartender.database.DbIngredients;
import bartender.database.DbShots;
import bartender.database.DbSpirits;
import bartender.gpio.PumpController;
import bartender.hue.Bridge;
import bartender.utils.Utils;
import com.google.common.net.UrlEscapers;
import com.google.gson.Gson;
import org.json.JSONException;
import org.json.JSONObject;

import javax.ws.rs.*;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriInfo;
import java.io.File;
import java.util.*;

/**
 * Created by Jaspar Mang on 10.01.17.
 */

@Path("interface/v1")
public class Rest extends AbstractRest {
    private static final int[]          SHOT_SIZES      = new int[]{1, 2, 4};
    private static final String         RANDOM_SHOT     = "Random Shot";
    private static final String         RANDOM_COCKTAIL = "Random Cocktail";
    private final        DbSpirits      dbSpirits       = new DbSpirits();
    private final        DbCocktail     dbCocktail      = new DbCocktail();
    private final        DbShots        dbShots         = new DbShots();
    private final        DbIngredients  dbIngredients   = new DbIngredients();
    private final        Gson           gson            = new Gson();
    private final        PumpController pumpController  = new PumpController();
    private static final Bridge         bridge          = Bridge.getInstance();


    /**
     * Returns a list of all cocktails.
     *
     * @param uriInfo The URI info of the get call.
     *
     * @return a List of all cocktails.
     */
    @GET
    @Path("cocktails")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getCocktails(@Context UriInfo uriInfo) {
        List<Map<String, Object>> cocktails = dbCocktail.getCocktails();
        if (!cocktails.isEmpty()) {
            cocktails.add(new HashMap<>());
            cocktails.get(cocktails.size() - 1).put("name", RANDOM_COCKTAIL);
        }
        addUrlToListMap(cocktails, uriInfo, "name", true);
        return buildOkResponse(gson.toJson(cocktails));
    }

    /**
     * Returns a list of all shots.
     *
     * @param uriInfo The URI info of the get call.
     *
     * @return a List of all shots.
     */
    @GET
    @Path("shots")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getShots(@Context UriInfo uriInfo) {
        List<Map<String, Object>> shots = dbShots.getShots();
        if (!shots.isEmpty()) {
            shots.add(new HashMap<>());
            shots.get(shots.size() - 1).put("name", RANDOM_SHOT);
        }
        addUrlToListMap(shots, uriInfo, "name", true);
        return buildOkResponse(gson.toJson(shots));
    }

    /**
     * Returns a list of all spirits.
     *
     * @param uriInfo The URI info of the get call.
     *
     * @return a List of all spirits.
     */
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
            addAttributeToMap("link", spirit, uriInfo, "toggle_in_stock", false);
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
            if (drinkName.equals(RANDOM_SHOT)) {
                drink = createRandomEntry(RANDOM_SHOT);
            } else {
                drink = dbShots.getShot(drinkName);
            }
        } else if (drinkType == DrinkType.COCKTAIL) {
            if (drinkName.equals(RANDOM_COCKTAIL)) {
                drink = createRandomEntry(RANDOM_COCKTAIL);
                drink.put("ingredients", new ArrayList<>());
            } else {
                drink = dbCocktail.getCocktail(drinkName);
                if (drink != null) {
                    List<Map<String, Object>> ingredients = dbIngredients.getIngredientsForCocktail(drinkName);
                    drink.put("ingredients", ingredients);
                }
            }
        }
        if (drink != null) {
            addAttributeToMap("link", drink, uriInfo, "make", false);
            addAttributeToMap("image", drink, uriInfo, "image", false);
            return buildOkResponse(gson.toJson(drink));
        }
        return buildNotFoundResponse(
                "{\"error\":\"There is no " + drinkType.getName() + " with the Name " + drinkName + ".\"}");

    }

    @GET
    @Path("/shots/{shotName}/image")
    @Produces({"image/png", "image/jpeg", "image/gif"})
    public Response getShotImage(@PathParam("shotName") String shotName) {
        if (shotName.equals(RANDOM_SHOT)) {
            return getImage(RANDOM_SHOT);
        } else {
            String filePath = dbShots.getImage(shotName);
            return getImage(filePath);
        }
    }

    @GET
    @Path("/cocktails/{cocktailName}/image")
    @Produces({"image/png", "image/jpeg", "image/gif"})
    public Response getCocktailImage(@PathParam("cocktailName") String cocktailName) {
        if (cocktailName.equals(RANDOM_COCKTAIL)) {
            return getImage(RANDOM_COCKTAIL);
        } else {
            String filePath = dbCocktail.getImage(cocktailName);
            return getImage(filePath);
        }
    }

    private Response getImage(String filePath) {
        File file;
        if (filePath.equals("")) {
            ClassLoader classLoader = getClass().getClassLoader();
            file = new File(classLoader.getResource("imgnotfound.jpg").getFile());
        } else if (filePath.equals(RANDOM_SHOT) || filePath.equals(RANDOM_COCKTAIL)) {
            ClassLoader classLoader = getClass().getClassLoader();
            file = new File(classLoader.getResource("random.jpg").getFile());
        } else {
            file = new File(filePath);
        }
        Response.ResponseBuilder response = Response.ok(file);
        return response.build();
    }

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Path("shots/{shotName}/make")
    public Response makeShot(@PathParam("shotName") String shotName, String postBody) {
        try {
            JSONObject postJson = new JSONObject(postBody);
            if (postJson.has("centiliter")) {
                int centiliter;
                try {
                    centiliter = postJson.getInt("centiliter");
                } catch (JSONException e) {
                    return buildBadRequestResponse("{\"error\":\"Centiliter has to be an integer value.\"}");
                }
                if (Arrays.stream(SHOT_SIZES).anyMatch(s -> s == centiliter)) {
                    if (shotName.equals(RANDOM_SHOT) || (dbShots.getShot(shotName) != null)) {
                        if (shotName.equals(RANDOM_SHOT)) {
                            shotName = getRandomShotName();
                        }
                        String spirits_pump = dbSpirits.getPump(shotName);
                        boolean successful = false;
                        try {
                            successful = pumpController.makeShot(shotName, spirits_pump, centiliter, true);
                        } catch (InterruptedException e) {
                            e.printStackTrace();
                        }
                        if (successful) {
                            return buildAcceptedResponse(
                                    "{\"message\":\"Makes shot " + shotName + " with pump " + spirits_pump + ".\"}");
                        } else {
                            return buildConflictResponse("{\"message\":\"The system is making a other drink.\"}");
                        }
                    } else {
                        return buildNotFoundResponse(
                                "{\"error\":\"There is no spirit with the Name " + shotName + ".\"}");

                    }
                } else {
                    return buildBadRequestResponse("{\"error\":\"Centiliter has to be 1, 2 or 4.\"}");
                }
            }
            return buildBadRequestResponse("{\"error\":\"Centiliter has to be 1, 2 or 4.\"}");
        } catch (JSONException e) {
            return buildBadRequestResponse("{\"error\":\"Centiliter has to be specified e.g. {\"centiliter\": 2}\"}");
        }
    }

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Path("cocktails/{cocktail}/make")
    public Response makeCocktail(@PathParam("cocktail") String cocktail, String postBody) {
        if (cocktail.equals(RANDOM_COCKTAIL) || (dbCocktail.getCocktail(cocktail) != null)) {
            if (cocktail.equals(RANDOM_COCKTAIL)) {
                cocktail = getRandomCocktailName();
            }
            boolean successful = false;
            try {
                successful = pumpController.makeCocktail(cocktail);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            if (successful) {
                return buildAcceptedResponse("{\"message\":\"Makes cocktail " + cocktail + ".\"}");
            } else {
                return buildConflictResponse("{\"message\":\"The system is making a other drink.\"}");
            }
        } else {
            return buildNotFoundResponse("{\"error\":\"There is no cocktail with the Name " + cocktail + ".\"}");

        }
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
        dbEntries.stream().forEach(dbEntry -> addAttributeToMap("link", dbEntry, uriInfo, key, dynamic));
    }

    private void addAttributeToMap(String attribute, Map<String, Object> dbEntry, UriInfo uriInfo, String key,
                                   boolean dynamic) {
        String uri = uriInfo.getAbsolutePath().toString();
        if (!Objects.equals(uri.substring(uri.length() - 1), "/")) {
            uri = uri + "/";
        }
        if (dynamic) {
            dbEntry.put(attribute, uri + UrlEscapers.urlFragmentEscaper().escape(dbEntry.get(key).toString()));
        } else {
            dbEntry.put(attribute, uri + UrlEscapers.urlFragmentEscaper().escape(key));
        }
    }

    private Map<String, Object> createRandomEntry(String randomDrink) {
        Map<String, Object> randomShotEntry = new HashMap<>();
        randomShotEntry.put("name", randomDrink);
        randomShotEntry.put("description", "Feeling Lucky? Get a " + randomDrink + ".");
        return randomShotEntry;
    }

    private String getRandomShotName() {
        List<Map<String, Object>> shots = dbShots.getShots();
        return shots.get(Utils.randInt(0, shots.size() - 1)).get("name").toString();
    }

    private String getRandomCocktailName() {
        List<Map<String, Object>> cocktail = dbCocktail.getCocktails();
        return cocktail.get(Utils.randInt(0, cocktail.size() - 1)).get("name").toString();
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


    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Path("test/{shotName}")
    public Response testShot(@PathParam("shotName") String shotName, String postBody) {
        try {
            JSONObject postJson = new JSONObject(postBody);
            if (postJson.has("millis")) {
                int millis;
                try {
                    millis = postJson.getInt("millis");
                } catch (JSONException e) {
                    return buildBadRequestResponse("{\"error\":\"Millis has to be an integer value.\"}");
                }

                if (shotName.equals(RANDOM_SHOT) || (dbShots.getShot(shotName) != null)) {
                    if (shotName.equals(RANDOM_SHOT)) {
                        shotName = getRandomShotName();
                    }
                    String spirits_pump = dbSpirits.getPump(shotName);
                    boolean successful = false;
                    try {
                        successful = pumpController.makeShot(shotName, spirits_pump, millis, false);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                    if (successful) {
                        return buildAcceptedResponse(
                                "{\"message\":\"Makes shot " + shotName + " with pump " + spirits_pump + ".\"}");
                    } else {
                        return buildConflictResponse("{\"message\":\"The system is making a other drink.\"}");
                    }
                } else {
                    return buildNotFoundResponse(
                            "{\"error\":\"There is no spirit with the Name " + shotName + ".\"}");

                }
            } else {
                return buildBadRequestResponse("{\"error\":\"Centiliter has to be 1, 2 or 4.\"}");
            }

        } catch (JSONException e) {
            return buildBadRequestResponse("{\"error\":\"Centiliter has to be specified e.g. {\"centiliter\": 2}\"}");
        }
    }

}
