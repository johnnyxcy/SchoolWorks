import java.util.Iterator;
import java.util.Random;

public abstract class AVLTester {
	private final static String TEST_VALUE = "";
	public static boolean verifyAVL(StringTree toTest){
		// All StringTree interface methods must behave correctly
		// You may assume that size() and isEmpty() return the correct values
		if (toTest.size() <= 1) {
			return true;
		}
		// Check if the given tree is binary and balanced
		return isBinary(toTest) && isBalanced(toTest);
	}
	private static boolean isBinary(StringTree toTest) {
		Random r = new Random();
		boolean binary = true;
		// Make 100 random test cases to test if the given tree is binary
		// Terminate if one single test found it is not binary
		int testCase = 1;
		while (binary && testCase < 100) {
			// Generate 3 random disjoint numbers 
			int x = 1 + r.nextInt(9);
			int y = 1 + r.nextInt(9);
			while (y == x) {
				y = 1 + r.nextInt(9);
			}
			int z = 1 + r.nextInt(9);
			while(z == x || z == y) {
				z = 1 + r.nextInt(9);
			}
			toTest.makeEmpty();
			toTest.insert(x + TEST_VALUE, TEST_VALUE);
			toTest.insert(y + TEST_VALUE, TEST_VALUE);
			toTest.insert(z + TEST_VALUE, TEST_VALUE);
			binary = binaryTest(toTest, x, y, z);
			testCase++;
 		}
		return binary;
	}
	
	private static boolean binaryTest(StringTree toTest, int x, int y, int z) {
		Iterator<String> it = toTest.getBFSIterator();
		String cur = "";
		while (it.hasNext()) {
			cur  = cur + it.next();
		}
		if (x < y && y < z) {
			return cur.equals("" + y + x + z);
		} else if (x < z && z < y) {
			return cur.equals("" + z + x + y);
		} else if (z < x && x < y) {
			return cur.equals("" + x + z + y);
		} else if (z < y && y < x) {
			return cur.equals("" + y + z + x);
		} else if (y < x && x < z) {
			return cur.equals("" + x + y + z);
		} else { // (y < z && z < x)
			return cur.equals("" + z + y + x);
		}	
	}
	// Check if the tree is balanced
	private static boolean isBalanced(StringTree toTest) {
		Iterator<String> it = toTest.getBFSIterator();
		BST dict = new BST();
		while (it.hasNext()) {
			dict.insert(it.next());
		}
		return dict.isBalanced();
	}
}