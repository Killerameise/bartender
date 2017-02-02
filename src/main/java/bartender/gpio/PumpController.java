package bartender.gpio;

import bartender.database.DbPump;
import bartender.database.DbSpirits;
import bartender.hue.Bridge;
import bartender.utils.Properties;
import com.pi4j.io.gpio.*;

import java.util.List;

/**
 * Created by Jaspar Mang on 14.01.17.
 */
public class PumpController {
    DbPump dbPump = new DbPump();
    final int ONE_CENTILITER = 338;

    public boolean makeShot(String shotName, String pump, int centiliter, boolean useCentiliter)
            throws InterruptedException {
        Properties properties = Properties.getInstance();
        if (properties.getOnRaspberryPi()) {
            DbSpirits dbSpirits = new DbSpirits();
            int hue = dbSpirits.getHue(shotName);
            int saturation = dbSpirits.getSaturation(shotName);
            Bridge bridge = Bridge.getInstance();
            bridge.saveLastKnownLightConfiguration();
            bridge.changeColor(hue, saturation);

            System.out.println("<--Pi4J--> Pump Control ... started.");

            // create gpio controller
            final GpioController gpio = GpioFactory.getInstance();


            // provision gpio pin #01 as an output pin and turn on

            final GpioPinDigitalOutput pin = gpio.provisionDigitalOutputPin(
                    RaspiPin.getPinByAddress(dbPump.getPin1ForPump(pump)), "MyLED", PinState.HIGH);

            // set shutdown state for this pin
            pin.setShutdownOptions(true, PinState.LOW);
            System.out.println("--> GPIO state should be: ON");
            if (useCentiliter) {
                Thread.sleep(ONE_CENTILITER * centiliter);
            } else {
                Thread.sleep(centiliter);
            }

            // turn off gpio pin #01
            pin.low();
            Thread.sleep(1500);
            gpio.shutdown();
            gpio.unprovisionPin(pin);
            bridge.recoverKnownLightConfiguration();

            System.out.println("--> GPIO state should be: OFF");
            return true;
        } else {
            System.err.println("Running not on raspberry pi");
            System.out.println("Selected Pump: " + pump);
            //Thread.sleep(2500);
            return true;
        }
    }

}
