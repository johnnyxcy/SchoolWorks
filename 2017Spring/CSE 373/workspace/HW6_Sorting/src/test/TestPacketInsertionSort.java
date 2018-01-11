package test;

import java.util.Comparator;

import sorting.IntegerSorter;
import sorting.Packet;
import sorting.PacketSorter;


/**
 * Testing for InsertionSort with integers.
 * See base class for test details.
 * @author pattersp
 *
 */
public class TestPacketInsertionSort extends TestPacketSortBase {
    
    @Override
    protected void specificSort(Packet[] testArray,
            Comparator<Packet> comparator) {
        PacketSorter.insertionSort(testArray, comparator);
        
    }
}
