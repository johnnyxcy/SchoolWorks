package sorting;

import java.nio.ByteBuffer;
import java.util.Arrays;

/**
 * An object that represents a packet of data received from the server. Each
 * packet contains two indexes and an array of bytes. The first index is the
 * major index and the second index is the minor index. The two indexes
 * determine where the packet should be placed when it is reassembled with the
 * other packets. The major index specifies where the packet sits in the whole
 * series of packets, and the minor index specifies where the packet should be
 * relative to other packets in the same major index. In order words, the
 * packets are ordered first by major index and then packets with the same major
 * index are ordered by major index.
 * 
 * @author pattersp
 *
 */
public class Packet {
    private int majorPacketIndex;
    private int minorPacketIndex;
    private byte[] pixelBytes;

    /**
     * Constructs a new Packet from the specified bytes. The byte array
     * specifies the major and minor index in addition to the raw bytes. The
     * first 4 bytes are the major index, the next 4 are the minor index, and
     * then the rest of the bytes are the data.
     * 
     * @param bytes
     *            The byte array received from the server.
     */
    public Packet(byte[] bytes) {
        ByteBuffer buffer = ByteBuffer.allocate(bytes.length);

        buffer.put(bytes);
        this.majorPacketIndex = buffer.getInt(0);
        this.minorPacketIndex = buffer.getInt(4);
        this.pixelBytes = Arrays.copyOfRange(bytes, 8, bytes.length);

    }

    /**
     * FOR TESTING PURPOSES ONLY. DO NOT USE.
     * 
     * @param majorPacketIndex
     *            The major index assigned to this packet.
     * @param minorPacketIndex
     *            The minor index assigned to this packet.
     */
    public Packet(int majorPacketIndex, int minorPacketIndex) {
        this.majorPacketIndex = majorPacketIndex;
        this.minorPacketIndex = minorPacketIndex;
    }

    /**
     * Returns a copy of the pixel bytes
     * 
     * @return The copy of payload data held within the packet.
     */
    public byte[] getDataBytes() {
        return pixelBytes.clone();
    }

    /**
     * Returns a string representation of the packet.
     */
    @Override
    public String toString() {
        return "<Major: " + majorPacketIndex + ", Minor: " + minorPacketIndex
                + ">";
    }

    /**
     * @return the major packet index
     */
    public int getMajorPacketIndex() {
        return majorPacketIndex;
    }

    /**
     * @return the minor packet index
     */
    public int getMinorPacketIndex() {
        return minorPacketIndex;
    }

    /**
     * Compares this Packet for equality with another packet. Equality is based
     * on the major index and the minor index. The bytes are not considered.
     * 
     * NOTE: You should not need to use this method except for testing purposes.
     * 
     * @returns whether the packet is equal to the parameter
     */
    @Override
    public boolean equals(Object o) {
        if (!(o instanceof Packet)) {
            return false;
        }
        Packet td = (Packet) o;
        return (td.majorPacketIndex == this.majorPacketIndex && td.minorPacketIndex == this.minorPacketIndex);
    }
}
