package test;

import java.util.Comparator;

import sorting.IntegerSorter;

/**
 * Testing for MergeSort with integers.
 * See base class for test details.
 * @author pattersp
 *
 */
public class TestIntegerMergeSort extends TestIntegerSortBase {

    @Override
    protected void specificSort(Integer[] testArray,
            Comparator<Integer> comparator) {
        IntegerSorter.mergeSort(testArray, comparator);
        
    }
}