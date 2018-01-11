package sorting;
import java.util.Comparator;

/**
 * This class is for you to use
 * This class implements a Comparator for Integers. Two Integers are compared by
 * their numerical values, which follows classic intuition about integer
 * comparison. The first integer is considered less than the second integer if
 * its numerical value is less than the second integer's numerical value. The
 * first integer is considered greater than the second integer if its numerical
 * value is greater. Otherwise, the two are considered to be equal.
 * 
 * 
 * @author pattersp
 *
 */
public class IntegerComparator implements Comparator<Integer> {

    /**
     * Compares two Integers using their numerical values.
     * 
     * @param num1
     *            first packet to compare
     * @param num2
     *            second packet to compare
     * @return the value 0 if num1 is equal to num2; a value less than zero if num1 <
     *         num2; or a value > 0 if num1 > num2
     */
    @Override
    public int compare(Integer num1, Integer num2) {
        return num1 - num2;
    }

}
