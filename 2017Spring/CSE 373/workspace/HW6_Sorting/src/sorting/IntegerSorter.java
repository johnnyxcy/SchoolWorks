package sorting;

import java.util.Comparator;

/**
 * Class full of static sorting methods. Used to sort Integers.
 * 
 * TODO: Implement mergeSort() and selectionSort().
 * 
 * insertionSort is implemented for you as an example.
 * 
 * @author pattersp
 *
 */

public class IntegerSorter {
    /**
     * Sorts the given array of integers in ascending order according to the
     * comparator using mergesort. You may create as many private helper
     * functions as you wish to implement this method.
     * 
     * A note about ascending order:
     * 
     * When the method is finished, it should be true that:
     * comparator.compare(array[i - 1], array[i]) <= 0 for all i from 1 through
     * array.length.
     * 
     * @param array
     *            the integers to sort
     * @param comparator
     *            The comparator the will be used to compare two integers.
     */
    public static void mergeSort(Integer[] array, Comparator<Integer> comparator) {
        // TODO: Add your merge sort algorithm here.
    	int n = array.length;
    	if (n >= 2) { // Only split and merge when there are at least 2 elements
	    	Integer[] firstHalf = new Integer[n / 2];
	    	Integer[] secondHalf = new Integer[n - n / 2];
	    	for (int index = 0; index < n / 2; index++) {
	    		firstHalf[index] = array[index];
	    	}
	    	for (int index = n / 2; index < n; index++) {
	    		secondHalf[index - n / 2] = array[index];
	    	}
	    	mergeSort(firstHalf, comparator); // split
	    	mergeSort(secondHalf, comparator); // split
	    	merge(array, firstHalf, secondHalf, comparator); // sort and merge
    	}
    }
    
    private static void merge(Integer[] array, Integer[] first, Integer[] second, 
    		Comparator<Integer> comparator) {
    	int firstIndex = 0;
    	int secondIndex = 0;
    	int resultIndex = 0;
    	while (resultIndex < array.length) {
	    	if (firstIndex < first.length && (secondIndex >= second.length ||
	    			comparator.compare(first[firstIndex], second[secondIndex]) < 0)) {
	    		array[resultIndex] = first[firstIndex]; 
	    		firstIndex++;
	    	} else {
	    		array[resultIndex] = second[secondIndex];
	    		secondIndex++;
	    	}
	    	resultIndex++;
    	}
    }

    /**
     * Sort the array of integers in ascending order according to the comparator
     * using selection sort.
     * 
     * A note about ascending order:
     * 
     * When the method is finished, it should be true that:
     * comparator.compare(array[i - 1], array[i]) <= 0 for all i from 1 through
     * array.length.
     * 
     * @param array
     *            the array of integer that will be sorted.
     * @param comparator
     *            The comparator the will be used to compare two integers.
     */
    public static void selectionSort(Integer[] array,
            Comparator<Integer> comparator) {
        // TODO: Add your selection sort algorithm here.
        for (int cur = 0; cur < array.length; cur++) {
        	int smallestIndex = cur;
        	for (int next = cur + 1; next < array.length; next++) {
        		if (comparator.compare(array[next], array[smallestIndex]) < 0) {
        			smallestIndex = next;
        		}
        	}
        	int temp = array[cur];
        	array[cur] = array[smallestIndex];
        	array[smallestIndex] = temp;
        }
    }
    

    /**
     * Sort the array of integers in ascending order according to the comparator
     * using insertion sort.
     * 
     * A note about ascending order:
     * 
     * When the method is finished, it should be true that:
     * comparator.compare(array[i - 1], array[i]) <= 0 for all i from 1 through
     * array.length.
     * 
     * @param array
     *            the array of integers that will be sorted.
     * @param comparator
     *            The comparator the will be used to compare two integer.
     */
    public static void insertionSort(Integer[] array,
            Comparator<Integer> comparator) {
        for (int outerIndex = 1; outerIndex < array.length; outerIndex++) {
            Integer currentInt = array[outerIndex];
            int innerIndex = outerIndex - 1;
            while (innerIndex >= 0
                    && comparator.compare(currentInt, array[innerIndex]) < 0) {
                array[innerIndex + 1] = array[innerIndex];
                innerIndex--;
            }
            array[innerIndex + 1] = currentInt;
        }
    }
}
