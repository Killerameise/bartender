package bartender.hue;


import com.philips.lighting.hue.sdk.*;
import com.philips.lighting.model.PHBridge;
import com.philips.lighting.model.PHBridgeResourcesCache;
import com.philips.lighting.model.PHLight;
import com.philips.lighting.model.PHLightState;

import java.util.List;

/**
 * Created by Jaspar Mang on 19.01.17.
 */
public class Bridge {
    private PHHueSDK phHueSDK;

    public static void main(String args[]) {
        Bridge bridge = new Bridge();
    }

    public Bridge() {

        phHueSDK = PHHueSDK.create();
        phHueSDK.setAppName("test");


        phHueSDK.getNotificationManager().registerSDKListener(listener);
        PHBridgeSearchManager sm = (PHBridgeSearchManager) phHueSDK.getSDKService(PHHueSDK.SEARCH_BRIDGE);
        sm.search(true, true);
        PHAccessPoint accessPoint = new PHAccessPoint();
        accessPoint.setIpAddress("192.168.1.243");
        accessPoint.setUsername("8jo1xOi22axE9nAr1ExnmYlrkzdFpaHupaF2Te7m");
        phHueSDK.connect(accessPoint);

        System.out.println("lets have fun");
        PHBridge phBridge = phHueSDK.getSelectedBridge();
        PHBridgeResourcesCache cache = phBridge.getResourceCache();
        List<PHLight> lights = cache.getAllLights();
        PHLightState lightState = new PHLightState();
        lightState.setHue(145);
        lights.stream().forEach(l -> {
            phBridge.updateLightState(l, lightState);
            System.out.println("changed");
        });

    }

    private PHSDKListener listener = new PHSDKListener() {

        @Override
        public void onAccessPointsFound(List<PHAccessPoint> accessPoint) {
            accessPoint.stream().forEach(System.out::println);
            if (!accessPoint.isEmpty() && !phHueSDK.isAccessPointConnected(accessPoint.get(0))) {
                phHueSDK.connect(accessPoint.get(0));
            }
            // Handle your bridge search results here.  Typically if multiple results are returned you will want to display them in a list
            // and let the user select their bridge.   If one is found you may opt to connect automatically to that bridge.
        }

        @Override
        public void onCacheUpdated(List cacheNotificationsList, PHBridge bridge) {
            // Here you receive notifications that the BridgeResource Cache was updated. Use the PHMessageType to
            // check which cache was updated, e.g.
            if (cacheNotificationsList.contains(PHMessageType.LIGHTS_CACHE_UPDATED)) {
                System.out.println("Lights Cache Updated ");
            }
        }

        @Override
        public void onBridgeConnected(PHBridge b, String username) {
            phHueSDK.setSelectedBridge(b);
            phHueSDK.enableHeartbeat(b, PHHueSDK.HB_INTERVAL);
            System.out.println("Username: " + username);
            System.out.println("connected via search");
            // Here it is recommended to set your connected bridge in your sdk object (as above) and start the heartbeat.
            // At this point you are connected to a bridge so you should pass control to your main program/activity.
            // The username is generated randomly by the bridge.
            // Also it is recommended you store the connected IP Address/ Username in your app here.  This will allow easy automatic connection on subsequent use.
        }

        @Override
        public void onAuthenticationRequired(PHAccessPoint accessPoint) {
            System.out.println("authentication required");
            phHueSDK.startPushlinkAuthentication(accessPoint);
            // Arriving here indicates that Pushlinking is required (to prove the User has physical access to the bridge).  Typically here
            // you will display a pushlink image (with a timer) indicating to to the user they need to push the button on their bridge within 30 seconds.
        }

        @Override
        public void onConnectionResumed(PHBridge bridge) {

        }

        @Override
        public void onConnectionLost(PHAccessPoint accessPoint) {
            // Here you would handle the loss of connection to your bridge.
        }

        @Override
        public void onError(int code, final String message) {
            // Here you can handle events such as Bridge Not Responding, Authentication Failed and Bridge Not Found
        }

        @Override
        public void onParsingErrors(List parsingErrorsList) {
            // Any JSON parsing errors are returned here.  Typically your program should never return these.
        }
    };
}
