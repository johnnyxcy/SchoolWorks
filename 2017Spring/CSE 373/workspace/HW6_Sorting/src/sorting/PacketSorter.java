package sorting;

import java.util.Comparator;

/**
 * Class full of static sorting methods. Used to sort packets received from a
 * server containing image metadata.
 * 
 * TODO: Implement mergeSort() and selectionSort().
 * 
 * insertionSort is implemented for you as an example.
 * 
 * @author pattersp
 *
 */

public class PacketSorter {
    /**
     * Sorts the given array of packets in ascending order according to the
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
     *            the packets to sort
     * @param comparator
     *            The comparator the will be used to compare two packets.
     */
    public static void mergeSort(Packet[] array, Comparator<Packet> comparator) {
        // TODO: Add your merge sort algorithm here.
    	int n = array.length;
    	if (n >= 2) { // Only split and merge when there are at least 2 elements
	    	Packet[] firstHalf = new Packet[n / 2];
	    	Packet[] secondHalf = new Packet[n - n / 2];
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
    
    private static void merge(Packet[] array, Packet[] first, Packet[] second, 
    		Comparator<Packet> comparator) {
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
     * Sort the array of packets in ascending order using selection sort.
     * 
     * A note about ascending order:
     * 
     * When the method is finished, it should be true that:
     * comparator.compare(array[i - 1], array[i]) <= 0 for all i from 1 through
     * array.length.
     * 
     * @param array
     *            the array of packets that will be sorted.
     * @param comparator
     *            The comparator the will be used to compare two packets.
     */
    public static void selectionSort(Packet[] array,
            Comparator<Packet> comparator) {
    	for (int cur = 0; cur < array.length; cur++) {
        	int smallestIndex = cur;
        	for (int next = cur + 1; next < array.length; next++) {
        		if (comparator.compare(array[next], array[smallestIndex]) < 0) {
        			smallestIndex = next;
        		}
        	}
        	Packet temp = array[cur];
        	array[cur] = array[smallestIndex];
        	array[smallestIndex] = temp;
        }
    }

    /**
     * Sort the array of packets in ascending order using insertion sort.
     * 
     * A note about ascending order:
     * 
     * When the method is finished, it should be true that:
     * comparator.compare(array[i - 1], array[i]) <= 0 for all i from 1 through
     * array.length.
     * 
     * @param array
     *            the array of packets that will be sorted.
     * @param comparator
     *            The comparator the will be used to compare two packets.
     */
    public static void insertionSort(Packet[] array,
            Comparator<Packet> comparator) {
        for (int outerIndex = 1; outerIndex < array.length; outerIndex++) {
            Packet currentPacket = array[outerIndex];
            int innerIndex = outerIndex - 1;
            while (innerIndex >= 0
                    && comparator.compare(currentPacket, array[innerIndex]) < 0) {
                array[innerIndex + 1] = array[innerIndex];
                innerIndex--;
            }
            array[innerIndex + 1] = currentPacket;
        }
    }
}
