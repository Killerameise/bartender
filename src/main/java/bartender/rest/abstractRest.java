package bartender.rest;

import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

/**
 * Created by Jaspar Mang on 12.01.17.
 */
public class AbstractRest {
    public Response buildNotFoundResponse(String errorMsg) {
        return Response.status(Response.Status.NOT_FOUND)
                .type(MediaType.APPLICATION_JSON)
                .entity(errorMsg)
                .build();
    }

    public Response buildBadRequestResponse(String errorMsg) {
        return Response.status(Response.Status.BAD_REQUEST)
                .type(MediaType.APPLICATION_JSON)
                .entity(errorMsg)
                .build();
    }

    public Response buildAcceptedResponse(String errorMsg) {
        return Response.status(Response.Status.ACCEPTED)
                .type(MediaType.APPLICATION_JSON)
                .entity(errorMsg)
                .build();
    }

    public Response buildOkResponse(String Msg){
        return Response.status(Response.Status.OK)
                .type(MediaType.APPLICATION_JSON)
                .entity(Msg)
                .build();
    }
}
