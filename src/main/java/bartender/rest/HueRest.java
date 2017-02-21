package bartender.rest;

import bartender.hue.Bridge;
import org.json.JSONException;
import org.json.JSONObject;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

/**
 * Created by Jaspar Mang on 19.01.17.
 */
@Path("interface/v1/hue")
public class HueRest extends AbstractRest {
    public static final Bridge bridge = Bridge.getInstance();

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Path("changecolor")
    public Response changeColor(String postBody) {
        try {
            JSONObject postJson = new JSONObject(postBody);
            if (postJson.has("hue")) {
                int hue;
                int duration;
                try {
                    hue = postJson.getInt("hue");
                    duration = postJson.getInt("duration");
                    try {
                        bridge.saveLastKnownLightConfiguration();
                        bridge.changeColor(hue, 255);
                        Thread.sleep(duration);
                        bridge.recoverKnownLightConfiguration();
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                    return buildOkResponse("{\"message\": \"colors changed.\"}");
                } catch (JSONException e) {
                    return buildBadRequestResponse("{\"error\":\"hue has to be an integer value.\"}");
                }
            }
        } catch (JSONException e) {
        }
        return buildBadRequestResponse("{\"error\":\"hue and duration has to be specified e.g. {\"hue\": 12345, \"duration\": 1000}\"}");
    }

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Path("hello")
    public Response sayHello() {
        try {
            bridge.sayHello();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        return buildOkResponse("");
    }
}
