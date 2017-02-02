package bartender.hue;


import bartender.database.Connection;
import com.philips.lighting.hue.sdk.*;
import com.philips.lighting.model.*;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Jaspar Mang on 19.01.17.
 */
public class Bridge {
    private static final String LIVING_ROOM_KEY = "Wohnzimmer";
    private static Bridge instance = null;
    private final PHHueSDK phHueSDK;
    private List<PHLight> lights;
    private List<PHLightState> lightStates;

    public static void main(String args[]) throws InterruptedException {
        Bridge bridge = Bridge.getInstance();
        //bridge.sayHello();
        //bridge.sayHello();
        Thread.sleep(1000);
        bridge.changeColor(25500, 254);
        //bridge.sayHello();
    }

    public static synchronized Bridge getInstance() {
        if (instance == null) {
            instance = new Bridge();
        }
        return instance;
    }

    private Bridge() {

        phHueSDK = PHHueSDK.create();
        phHueSDK.setAppName("test");


        phHueSDK.getNotificationManager().registerSDKListener(listener);
        PHBridgeSearchManager sm = (PHBridgeSearchManager) phHueSDK.getSDKService(PHHueSDK.SEARCH_BRIDGE);
        sm.search(true, true);
        connectToKnownBridge();
        try {
            sayHello();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

    }

    public void changeColor(int hue, int saturation) throws InterruptedException {
        PHBridge phBridge = phHueSDK.getSelectedBridge();
        if (phBridge != null) {
            PHLightState lightState = new PHLightState();
            lightState.setBrightness(254);
            lightState.setOn(true);
            lightState.setHue(hue);
            lightState.setSaturation(saturation);
            System.out.println("Change color.");
            phHueSDK.getSelectedBridge().setLightStateForGroup(LIVING_ROOM_KEY, lightState);
        }
    }

    public void sayHello() throws InterruptedException {
        PHBridge phBridge = phHueSDK.getSelectedBridge();
        int i = 0;
        while (phBridge == null && i < 21) {
            try {
                Thread.sleep(2000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            phBridge = phHueSDK.getSelectedBridge();
            i++;
        }
        if (phBridge != null) {
            saveLastKnownLightConfiguration();

            PHLightState lightState = new PHLightState();
            lightState.setBrightness(254);
            lightState.setOn(true);
            lightState.setHue(46920);
            lightState.setSaturation(200);

            lightState.setAlertMode(PHLight.PHLightAlertMode.ALERT_LSELECT);
            phHueSDK.getSelectedBridge().setLightStateForGroup(LIVING_ROOM_KEY, lightState);
            Thread.sleep(2500);
            //lightState.setAlertMode(PHLight.PHLightAlertMode.ALERT_NONE);
            lightState.setHue(25500);
            phHueSDK.getSelectedBridge().setLightStateForGroup(LIVING_ROOM_KEY, lightState);
            //Thread.sleep(500);
            //lightState.setAlertMode(PHLight.PHLightAlertMode.ALERT_LSELECT);
            phHueSDK.getSelectedBridge().setLightStateForGroup(LIVING_ROOM_KEY, lightState);
            Thread.sleep(2500);
            lightState.setAlertMode(PHLight.PHLightAlertMode.ALERT_NONE);
            phHueSDK.getSelectedBridge().setLightStateForGroup(LIVING_ROOM_KEY, lightState);

            recoverKnownLightConfiguration();
        }
    }

    public void saveLastKnownLightConfiguration(){
        PHBridgeResourcesCache cache = phHueSDK.getSelectedBridge().getResourceCache();
        lights = cache.getAllLights();
        lightStates = new ArrayList<>();
        lights.stream().forEach(l -> lightStates.add(l.getLastKnownLightState()));
    }

    public void recoverKnownLightConfiguration(){
        if(lights!=null && lightStates!=null && lights.size()==lightStates.size()) {
            for (int j = 0; j < lights.size(); j++) {
                lightStates.get(j).setAlertMode(PHLight.PHLightAlertMode.ALERT_NONE);
                phHueSDK.getSelectedBridge().updateLightState(lights.get(j), lightStates.get(j));
            }
        }
    }

    private void connectToKnownBridge() {
        PHAccessPoint accessPoint = new PHAccessPoint();
        accessPoint.setIpAddress("192.168.5.115");
        accessPoint.setUsername("8jo1xOi22axE9nAr1ExnmYlrkzdFpaHupaF2Te7m");
        phHueSDK.connect(accessPoint);
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
