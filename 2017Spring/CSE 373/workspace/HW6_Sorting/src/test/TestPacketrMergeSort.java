package test;

import java.util.Comparator;

import sorting.Packet;
import sorting.PacketSorter;

/**
 * Testing for MergeSort with packets.
 * See base class for test details.
 * @author pattersp
 *
 */
public class TestPacketrMergeSort extends TestPacketSortBase {

    @Override
    protected void specificSort(Packet[] testArray,
            Comparator<Packet> comparator) {
        PacketSorter.mergeSort(testArray, comparator);
        
    }
}