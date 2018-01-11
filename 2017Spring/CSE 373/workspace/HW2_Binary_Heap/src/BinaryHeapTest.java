
public abstract class BinaryHeapTest {

	public static void main(String[] args) {
		// Use your tests here to make sure your implementation is working, this is for your help
		// Call your tests here to make sure that your implementation works.
		// This section will not be graded
		if (testEmpty(new BinaryHeap())) {
			System.out.println("true for empty");
		}
		if (testOne(new BinaryHeap())) {
			System.out.println("true for one");	
		}
		if (testMany(new BinaryHeap())) {
			System.out.println("true for many");
		}
	}
	
	//Make the below tests as thorough as possible.
	//Assume toTest is empty when the function is called
	//These will be tested against other implementations, both correct and incorrect, so be as thorough as you can
	//Only applicable functions need to be tested at each level.
	//Helper tests are strongly recommended
	
	public static boolean testEmpty(BinaryHeap toTest){
		//TODO write a test case that tests functionality for all of the functions applicable to a BinaryHeap when it is empty
		//toTest should be empty when it is called
		//You may find writing helper tests to be useful
		//This should return true if it passes your tests, false otherwise
		toTest = new BinaryHeap();
		if (toTest.isEmpty() && toTest.findMin() == null && toTest.deleteMin() == null && toTest.size() == 0) {
			return true;
		}
		return false;
	}
	
	public static boolean testOne(BinaryHeap toTest){
		//TODO write a test case that tests functionality for all of the functions applicable to a BinaryHeap when it has one element
		//Add the element in this function, toTest should be empty when it is called.
		//You may find writing helper tests to be useful
		//This should return true if it passes your tests, false otherwise
		toTest = new BinaryHeap();
		toTest.insert("testOne", 1);
		if (!toTest.isEmpty() && toTest.size() == 1 && toTest.findMin().equals("testOne") 
			&& toTest.changePriority("testOne", 2) && toTest.deleteMin().equals("testOne")) {
				// After delete the element, it should be empty
				return toTest.isEmpty();
		}
		return false;
	}
	
	public static boolean testMany(BinaryHeap toTest){
		//TODO write a test case that tests functionality for all of the functions applicable to a BinaryHeap when it has many elements
		//Add the elements to the BinaryHeap in this function, toTest should be empty when it is called.
		//You may find writing helper tests to be useful
		//This should return true if it passes your tests, false otherwise
		toTest = new BinaryHeap();
		String[] cases = new String[]{"one", "two", "three", "four", "five", "six"};
		for(int i = 1; i <= cases.length; i++) {
			toTest.insert(cases[i - 1], i);
		}
		if (!toTest.isEmpty() && toTest.size() == 6 && toTest.findMin().equals("one")
			// If "one" changes its priority to 7, then "two" will be the min element
			&& toTest.changePriority("one", 7) && toTest.deleteMin().equals("two")) {
			toTest.makeEmpty();
			// The array should be empty after removing all elements from the heap.			
			return toTest.isEmpty();
		}
		return false;
	}

}
