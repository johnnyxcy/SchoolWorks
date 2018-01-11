package test;

import static org.junit.Assert.assertArrayEquals;

import java.util.Arrays;
import java.util.Comparator;

import org.junit.Test;

import sorting.IntegerComparator;
import sorting.IntegerSorter;
import test.TestUtils.ReverseIntegerComparator;

public abstract class TestIntegerSortBase {
    public static final int TIME_OUT = 2000;

    /**
     * Testing General Sorting sort_type
     * =============================================
     */

    @Test(timeout = TIME_OUT)
    public void test_sorting_no_element() {
        Integer[] nums = {};
        testIntegerSortType(nums);
    }

    @Test(timeout = TIME_OUT)
    public void test_sorting_single_element() {
        Integer[] nums = { 1 };
        testIntegerSortType(nums);
    }
    
    @Test(timeout = TIME_OUT)
    public void test_sorting_even_size_array() {
        Integer[] nums = { 3, 1, 5, 7, 8, 2 };
        testIntegerSortType(nums);
    }
    
    @Test(timeout = TIME_OUT)
    public void test_sorting_odd_size_array() {
        Integer[] nums = { 3, 1, 12, 5, 7, 8, 2 };
        testIntegerSortType(nums);
    }
    
    @Test(timeout = TIME_OUT)
    public void test_sorting_array_with_sorted_subsequence() {
        Integer[] nums = { 13, 11, 3, 4, 5, 6, 7, 8, 1, 2 };
        testIntegerSortType(nums);
    }

    @Test(timeout = TIME_OUT)
    public void test_sorting_many_element_no_duplicates_no_negatives() {
        Integer[] nums = { 1, 10, 3, 5, 200, 90, 39, 409, 2, 0, 23, 542, 35,
                13, 5, 20 };
        testIntegerSortType(nums);
    }

    @Test(timeout = TIME_OUT)
    public void test_sorting_many_element_no_duplicates() {
        Integer[] nums = { 43, 10, 3, 5, -1, 90, 39, 409, 2, 0, 23, 542, 35, 13,
                5, 20 };
        testIntegerSortType(nums);
    }
    
    @Test(timeout = TIME_OUT)
    public void test_many_elements_already_sorted() {
        Integer[] nums = { 1, 2, 3, 4, 5, 6, 7, 8, 9 };
        testIntegerSortType(nums);
    }

    @Test(timeout = TIME_OUT)
    public void test_many_elements_no_gaps() {
        Integer[] nums = { 8, 9, 3, 5, 2, 6, 1, 7, 4 };
        testIntegerSortType(nums);
    }
    
    @Test(timeout = TIME_OUT)
    public void test_many_elements_with_duplicates() {
        Integer[] nums = { 1, 9, 10, 15, 17, 4, 0, 16, 16, 4, 9, 5, 4, 2, 0, 0, 3, 10, -1, 9, 1, 2, 5, 15,
                13, 16, 17, 3, 4, 5 };
        testIntegerSortType(nums);
    }

    @Test(timeout = TIME_OUT)
    public void test_sorting_many_elements_reverse_order() {
        Integer[] nums = { 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1 };
        testIntegerSortType(nums);
    }

    /**
     * Testing large case for sorting
     * =============================================
     */

    @Test
    public void test_sorting_huge_amount_of_num_insertion() {
        Integer[] copy = TestUtils.getArrayOfManyNums();
        testIntegerSortType(copy);
    }

    /** Testing with a Different Comparator **/
    @Test(timeout = TIME_OUT)
    public void test_many_elements_with_duplicates_expects_reverse_order() {
        Integer[] nums = { 1, 9, 9, 5, 4, 2, 0, 0, 3, 10, -1, 9, 1, 2, 5, 15,
                13, 16, 17, 3, 4, 5 };
        ReverseIntegerComparator rIntComp = new ReverseIntegerComparator();
        Integer[] expected = Arrays.copyOf(nums, nums.length);
        Arrays.sort(expected, rIntComp);
        specificSort(nums, rIntComp);
        assertArrayEquals("Both arrays should be in reverseOrder", expected,
                nums);
    }

    private void testIntegerSortType(Integer[] testArray) {
        Integer[] expected = Arrays.copyOf(testArray, testArray.length);
        Arrays.sort(expected);
        specificSort(testArray, new IntegerComparator());
        assertArrayEquals("Arrays should be equal", expected, testArray);
    }
    
    protected abstract void specificSort(Integer[] testArray, Comparator<Integer> comparator);
}
