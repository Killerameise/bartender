package bartender.gpio;

import bartender.database.DbPump;
import bartender.utils.Properties;
import com.pi4j.io.gpio.*;

/**
 * Created by Jaspar Mang on 14.01.17.
 */
public class PumpController {
    DbPump dbPump = new DbPump();

    public boolean makeShot(String pump) throws InterruptedException {
        Properties properties = Properties.getInstance();
        if (properties.getOnRaspberryPi()) {
            System.out.println("<--Pi4J--> Pump Control ... started.");

            // create gpio controller
            final GpioController gpio = GpioFactory.getInstance();


            // provision gpio pin #01 as an output pin and turn on

            final GpioPinDigitalOutput pin = gpio.provisionDigitalOutputPin(
                    RaspiPin.getPinByAddress(dbPump.getPin1ForPump(pump)), "MyLED", PinState.HIGH);

            // set shutdown state for this pin
            pin.setShutdownOptions(true, PinState.LOW);

            System.out.println("--> GPIO state should be: ON");

            Thread.sleep(5000);

            // turn off gpio pin #01
            pin.low();
            gpio.shutdown();
            gpio.unprovisionPin(pin);

            System.out.println("--> GPIO state should be: OFF");
            return true;
        } else {
            System.err.println("Running not on raspberry pi");
            System.out.println("Selected Pump: " + pump);
            Thread.sleep(2500);
            return true;
        }
    }
}
