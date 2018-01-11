package test;

import java.util.Comparator;

import sorting.IntegerSorter;


/**
 * Testing for InsertionSort with integers.
 * See base class for test details.
 * @author pattersp
 *
 */
public class TestIntegerInsertionSort extends TestIntegerSortBase {
    
    @Override
    protected void specificSort(Integer[] testArray,
            Comparator<Integer> comparator) {
        IntegerSorter.insertionSort(testArray, comparator);
        
    }
}
