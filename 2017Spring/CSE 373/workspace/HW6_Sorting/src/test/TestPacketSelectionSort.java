package test;

import java.util.Comparator;

import sorting.IntegerSorter;
import sorting.Packet;
import sorting.PacketSorter;

/**
 * Testing for SelectionSort with packets.
 * See base class for test details.
 * @author pattersp
 *
 */
public class TestPacketSelectionSort extends TestPacketSortBase {

    @Override
    protected void specificSort(Packet[] testArray,
            Comparator<Packet> comparator) {
        PacketSorter.selectionSort(testArray, comparator);
        
    }
}