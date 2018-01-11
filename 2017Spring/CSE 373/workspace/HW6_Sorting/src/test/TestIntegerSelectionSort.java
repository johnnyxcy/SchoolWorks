package test;

import java.util.Comparator;

import sorting.IntegerSorter;

/**
 * Testing for SelectionSort with integers.
 * See base class for test details.
 * @author pattersp
 *
 */
public class TestIntegerSelectionSort extends TestIntegerSortBase {

    @Override
    protected void specificSort(Integer[] testArray,
            Comparator<Integer> comparator) {
        IntegerSorter.selectionSort(testArray, comparator);
        
    }
}