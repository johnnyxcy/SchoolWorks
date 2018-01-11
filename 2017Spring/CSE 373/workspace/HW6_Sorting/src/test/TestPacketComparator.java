package test;

import static org.junit.Assert.assertTrue;

import org.junit.Test;

import sorting.Packet;
import sorting.PacketComparator;

/**
 * Tests for the PacketComparator's compare() method.
 * @author pattersp
 *
 */
public class TestPacketComparator {

    @Test
    public void testEqualsCase() {
        Packet p1 = new Packet(0, 0);
        Packet p2 = new Packet(0, 0);
        PacketComparator pc = new PacketComparator();
        assertTrue(pc.compare(p1, p2) == 0);
    }
    
    @Test
    public void testLessThanCase1() {
        Packet p1 = new Packet(0, 0);
        Packet p2 = new Packet(1, 0);
        PacketComparator pc = new PacketComparator();
        assertTrue(pc.compare(p1, p2) < 0);
    }
    
    @Test
    public void testLessThanCase2() {
        Packet p1 = new Packet(0, 0);
        Packet p2 = new Packet(1, 1);
        PacketComparator pc = new PacketComparator();
        assertTrue(pc.compare(p1, p2) < 0);
    }
    
    @Test
    public void testLessThanCase3() {
        Packet p1 = new Packet(0, 1);
        Packet p2 = new Packet(1, 0);
        PacketComparator pc = new PacketComparator();
        assertTrue(pc.compare(p1, p2) < 0);
    }
    
    @Test
    public void testLessThanCase4() {
        Packet p1 = new Packet(1, 1);
        Packet p2 = new Packet(1, 2);
        PacketComparator pc = new PacketComparator();
        assertTrue(pc.compare(p1, p2) < 0);
    }
    
    @Test
    public void testGreaterThanCase1() {
        Packet p1 = new Packet(0, 0);
        Packet p2 = new Packet(1, 0);
        PacketComparator pc = new PacketComparator();
        assertTrue(pc.compare(p2, p1) > 0);
    }
    
    @Test
    public void testGreaterThanCase2() {
        Packet p1 = new Packet(0, 0);
        Packet p2 = new Packet(1, 1);
        PacketComparator pc = new PacketComparator();
        assertTrue(pc.compare(p2, p1) > 0);
    }
    
    @Test
    public void testGreaterThanCase3() {
        Packet p1 = new Packet(0, 1);
        Packet p2 = new Packet(1, 0);
        PacketComparator pc = new PacketComparator();
        assertTrue(pc.compare(p2, p1) > 0);
    }
    
    @Test
    public void testGreaterThanCase4() {
        Packet p1 = new Packet(1, 1);
        Packet p2 = new Packet(1, 2);
        PacketComparator pc = new PacketComparator();
        assertTrue(pc.compare(p2, p1) > 0);
    }

}
