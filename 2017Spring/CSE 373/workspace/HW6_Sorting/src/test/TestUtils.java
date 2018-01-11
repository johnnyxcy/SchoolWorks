package test;

import java.util.Comparator;
import java.util.Random;

public class TestUtils {

    public static final int LARGE_TEST_SIZE = 10000;
    public static final Random RANDOM_GENERATOR = new Random();
    

    public static class ReverseIntegerComparator implements Comparator<Integer> {
        @Override
        public int compare(Integer e1, Integer e2) {
            return e2 - e1;
        }
    }

    public static Integer[] getArrayOfManyNums() {
        Integer[] hugeArray = new Integer[LARGE_TEST_SIZE];
        for (int i = 0; i < hugeArray.length; i++) {
            hugeArray[i] = RANDOM_GENERATOR.nextInt(1000) - 500;
        }
        return hugeArray;
    }
}
