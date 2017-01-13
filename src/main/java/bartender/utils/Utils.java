package bartender.utils;

import java.util.Random;

/**
 * Created by Jaspar Mang on 13.01.17.
 */
public class Utils {
    /**
     * Calculates a random integer between min and max.
     *
     * @param min the min integer.
     * @param max the max integer
     *
     * @return the calculated integer.
     */
    public static int randInt(int min, int max) {
        Random rand = new Random();
        return rand.nextInt((max - min) + 1) + min;
    }
}
