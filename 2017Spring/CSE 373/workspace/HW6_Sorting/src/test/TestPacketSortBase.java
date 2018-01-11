package test;

import static org.junit.Assert.assertArrayEquals;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.Random;

import javax.imageio.ImageIO;

import org.junit.Test;

import sorting.Packet;
import sorting.PacketComparator;

public abstract class TestPacketSortBase {
    public static final int TIME_OUT = 2000;
    public static final int MIN_ROWS = 8;
    public static final int ROW_RANGE = 3;
    public static final int MIN_CHUNK_WIDTH = 40;
    public static final int CHUNK_WIDTH_RANGE = 20;

    /**
     * Testing General Sorting sort_type
     * =============================================
     */

    @Test(timeout = TIME_OUT)
    public void test_sorting_no_element() {
        Integer[] nums = {};
        testPacketSortType(nums, nums);
    }

    @Test(timeout = TIME_OUT)
    public void test_sorting_single_element() {
        testPacketSortType(new Integer[] { 0 }, new Integer[] { 0 });
    }
    
    @Test(timeout = TIME_OUT)
    public void test_sorting_many_element_even_size() {
        Integer[] majorIndexes = { 9, 10, 3, 5, 200, 90 };
        Integer[] minorIndexes = { 13, 0, 29, 39, 239, 38 };
        testPacketSortType(majorIndexes, minorIndexes);
    }
    
    @Test(timeout = TIME_OUT)
    public void test_sorting_many_element_odd_size() {
        Integer[] majorIndexes = { 9, 10, 3, 5, 200, 90, 7 };
        Integer[] minorIndexes = { 13, 0, 29, 39, 239, 38, 32 };
        testPacketSortType(majorIndexes, minorIndexes);
    }

    @Test(timeout = TIME_OUT)
    public void test_sorting_many_element_no_duplicates() {
        Integer[] majorIndexes = { 9, 10, 3, 5, 200, 90, 39, 409, 2, 0, 23,
                542, 35, 13, 5, 20 };
        Integer[] minorIndexes = { 13, 0, 29, 39, 239, 38, 3, 92, 12, 88, 31,
                54, 53, 4, 1, 28 };
        testPacketSortType(majorIndexes, minorIndexes);
    }

    @Test(timeout = TIME_OUT)
    public void test_many_elements_medium_size_test() {
        Integer[] majorIndexes = { 19, 13, 11, 12, 17, 14, 18, 15, 10, 16 };
        Integer[] minorIndexes = { 12, 88, 31, 54, 53, 4, 1, 28, 2, 11 };
        testPacketSortType(majorIndexes, minorIndexes);
    }

    @Test(timeout = TIME_OUT)
    public void test_many_elements_both_medium_test2() {
        Integer[] majorIndexes = { 18, 29, 480, 28, 1, 3, 2, 2, 0, 228 };
        Integer[] minorIndexes = { 10, 20, 30, 40, 50, 60, 70, 80, 90, 338 };
        testPacketSortType(majorIndexes, minorIndexes);
    }

    @Test(timeout = TIME_OUT)
    public void test_many_elements_medium_test3() {
        Integer[] minorIndexes = { 2, 78, 23, 45, 89, 2, 43, 12, 8 };
        Integer[] majorIndexes = { 8, 9, 3, 5, 2, 6, 1, 4, 7 };
        testPacketSortType(majorIndexes, minorIndexes);
    }

    @Test(timeout = TIME_OUT)
    public void test_many_elements_no_gaps() {
        Integer[] majorIndexes = { 8, 9, 3, 5, 2, 6, 1, 4, 7, 10 };
        Integer[] minorIndexes = { 9, 13, 11, 12, 17, 14, 18, 15, 10, 16 };
        testPacketSortType(majorIndexes, minorIndexes);
    }

    @Test(timeout = TIME_OUT)
    public void test_many_elements_with_duplicates_major_minor_same() {
        Integer[] majorIndexes = { 11, 9, 10, 15, 17, 4, 0, 16, 16, 4, 9, 5, 4,
                2, 0, 0, 3, 10, 91, 9, 1, 2, 5, 15, 13, 16, 17, 3, 4, 5 };
        Integer[] minorIndexes = { 1, 9, 10, 15, 17, 4, 0, 16, 16, 4, 9, 5, 4,
                2, 0, 0, 3, 10, 91, 9, 1, 2, 5, 15, 13, 16, 17, 3, 4, 5 };
        testPacketSortType(majorIndexes, minorIndexes);
    }

    @Test(timeout = TIME_OUT)
    public void test_many_elements_with_duplicates_major_minor_different() {
        Integer[] majorIndexes = { 1, 9, 10, 15, 17, 4, 0, 16, 16, 4, 9, 5, 4,
                2, 0, 0, 3, 10, 91, 9, 1, 2, 5, 15, 13, 16, 17, 3, 4, 5 };
        Integer[] minorIndexes = { 13, 12, 12, 1, 9, 12, 12, 6, 6, 12, 12, 17,
                12, 5, 12, 12, 4, 12, 9, 12, 13, 5, 17, 1, 0, 6, 9, 4, 12, 17 };
        testPacketSortType(majorIndexes, minorIndexes);
    }

    @Test(timeout = TIME_OUT)
    public void test_many_elements_with_all_same() {
        Integer[] nums = { 1, 1, 1, 1, 1, 1 };
        testPacketSortType(nums, nums);
    }

    @Test(timeout = TIME_OUT)
    public void test_sorting_many_elements_reverse_order() {
        Integer[] majorIndexes = { 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1 };
        Integer[] minorIndexes = { 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1 };
        testPacketSortType(majorIndexes, minorIndexes);
    }

    /**
     * Testing large case for sorting
     * =============================================
     * 
     * @throws IOException
     */

    @Test
    public void test_image_unscramble() throws IOException {
        BufferedImage image = ImageIO.read(new File("expectedImage.jpg"));
        Random r = new Random();
        int rows = r.nextInt(ROW_RANGE) + MIN_ROWS;

        ArrayList<Packet> packetList = new ArrayList<Packet>();
        for (int row = 0; row < rows; row++) {
            int pixelsLeft = image.getWidth();
            // We will randomly split up each row into chunks.
            while (pixelsLeft > 0) {
                int nextChunkWidth = Math.min(r.nextInt(CHUNK_WIDTH_RANGE)
                        + MIN_CHUNK_WIDTH, pixelsLeft);
                pixelsLeft -= nextChunkWidth;
                packetList.add(new Packet(row, image.getWidth() - pixelsLeft));
            }
        }
        Collections.shuffle(packetList);
        Packet[] result = new Packet[packetList.size()];
        for (int i = 0; i < result.length; i++) {
            result[i] = packetList.get(i);
        }
        checkPackets(result);
    }

    private void testPacketSortType(Integer[] majorIndexes,
            Integer[] minorIndexes) {
        Packet[] testArray = new Packet[majorIndexes.length];
        for (int i = 0; i < majorIndexes.length; i++) {
            testArray[i] = new Packet(majorIndexes[i], minorIndexes[i]);
        }
        checkPackets(testArray);
    }

    private void checkPackets(Packet[] testArray) {
        Packet[] expected = Arrays.copyOf(testArray, testArray.length);
        Arrays.sort(expected, new PacketComparator());
        specificSort(testArray, new PacketComparator());
        assertArrayEquals("Arrays should be equal", expected,
                testArray);
    }

    protected abstract void specificSort(Packet[] testArray,
            Comparator<Packet> comparator);
}
