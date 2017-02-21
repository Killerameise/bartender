package bartender.gpio;

import bartender.database.DbIngredients;
import bartender.database.DbPump;
import bartender.database.DbSpirits;
import bartender.hue.Bridge;
import bartender.utils.Properties;
import com.pi4j.io.gpio.*;

import java.util.List;
import java.util.Map;

/**
 * Created by Jaspar Mang on 14.01.17.
 */
public class PumpController {
    DbPump        dbPump        = new DbPump();
    DbIngredients dbIngredients = new DbIngredients();
    DbSpirits     dbSpirits     = new DbSpirits();
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
            int one_centtiliter = dbPump.getMillisForCentiliterForPump(pump);

            final GpioPinDigitalOutput pin = gpio.provisionDigitalOutputPin(
                    RaspiPin.getPinByAddress(dbPump.getPinForPump(pump)), "MyLED", PinState.HIGH);

            // set shutdown state for this pin
            pin.setShutdownOptions(true, PinState.LOW);
            System.out.println("--> GPIO state should be: ON");
            if (useCentiliter) {
                Thread.sleep(one_centtiliter * centiliter);
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
            System.out.println("Spritit: " + shotName + " Selected Pump: " + pump + " centiliter: " + centiliter);
            //Thread.sleep(2500);
            return true;
        }
    }

    public boolean makeCocktail(final String cocktail) throws InterruptedException {
        List<Map<String, Object>> ingredients = dbIngredients.getIngredientsForCocktail(cocktail);
        for (Map<String, Object> ingredient : ingredients) {
            String spirit = ingredient.get("spirit_name").toString();
            String pump = dbSpirits.getPump(spirit);
            int centiliter = (Integer) ingredient.get("quantity");
            makeShot(spirit, pump, centiliter, true);
        }
        return true;
    }
}
