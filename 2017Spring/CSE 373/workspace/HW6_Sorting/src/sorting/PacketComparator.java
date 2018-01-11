package sorting;
import java.util.Comparator;

/**
 * This class implements a Comparator for Packet objects. Two Packets are
 * compared using their majorPacketIndex and minorPacketIndex. The bytes held
 * within the packet are completely ignored during the comparison. The size of
 * the bytes within the packet are completely ignored during the comparison. You
 * should only consider the major and minor packet indexes when implementing the
 * comparison. See IntegerComparator for guidelines on how to implement this
 * class.
 * Example Usage:
 * 
    Comparator<Packet> comparator = new PacketComparator();
    if (comparator.compare(packet1, packet2) == 0) {
        System.out.println("The two packets are equal");
    } else if (comparator.compare(packet1, packet2) < 0) {
        System.out.println("The first packet is considered to be less than the second packet");
    } else {
        System.out.println("The first packet is considered to be greater than the second packet");
    }
 * 
 * 
 * A note about comparators:
 * 
 * A comparator guarantees to return an integer less
 * than 0 if the first parameter is less than the second, the integer 0 if the
 * two parameters are considered equal, and an integer greater than 1 if the
 * first parameter is larger than the second. Comparators make no guarantee
 * about the magnitude of the returned value. So, a comparator that returns -11
 * in the first case, 0 in the second case, and 120100390 in the third case is
 * valid. A comparator that returns -1 in the first case, 0 in the second case,
 * and 1 in the third case is also valid.
 * 
 * @author pattersp
 *
 */
public class PacketComparator implements Comparator<Packet> {

    /**
     * Compares two Packets. Packets should be compared first by majorPacketIndex and
     * ties should be broken using minorPacketIndex.
     * Said explicitly: The first Packet is equal to the second if they
     * have the same majorPacketIndex and minorPacketIndex. The first Packet is
     * considered less than the second Packet if its majorPacketIndex is smaller
     * OR if its majorPacketIndex is equal but its minorPacketIndex is smaller.
     * In all other cases, the second packet is considered smaller.
     * 
     * Note that the bytes contained in the packets are NOT considered during
     * comparison.
     * 
     * @param p1
     *            first packet to compare
     * @param p2
     *            second packet to compare
     * @return the value 0 if p1 is equal to p2; a value less than zero if p1 <
     *         p2; or a value > 0 if p1 > p2
     */
    @Override
    public int compare(Packet p1, Packet p2) {
        // TODO: Add some code here
        if (p1.getMajorPacketIndex() == p2.getMajorPacketIndex()) {
        	return p1.getMinorPacketIndex() - p2.getMinorPacketIndex();
        } else {
        	return p1.getMajorPacketIndex() - p2.getMajorPacketIndex();
        }
    }

}
