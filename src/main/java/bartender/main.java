package bartender;

import org.json.JSONObject;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

/**
 * Created by Jaspar Mang on 10.01.17.
 */

@Path("hello")
public class main {

    @GET
    @Path("test")
    @Produces(MediaType.APPLICATION_JSON)
    public Response helloWorld() {
        JSONObject obj = new JSONObject();
        obj.put("name", "foo");

        return Response.ok(obj.toString(), MediaType.APPLICATION_JSON).build();
    }
}