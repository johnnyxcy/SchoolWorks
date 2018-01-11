import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.Random;
import java.io.PrintStream;
import java.io.File;
import java.io.FileNotFoundException;

public class DicTestSuite {
	static Random r = new Random();
	public final static int TEST_SIZE = 10000;

	public static void main(String[] args) throws FileNotFoundException {
		System.out.println("Start");
		SADict SA = new SADict();
		SLLDict SLL = new SLLDict();
		UADict UA = new UADict();
		ULLDict UL = new ULLDict();
		BSTDict BST = new BSTDict();
		insertTester(SA, SLL, UA, UL, BST);
		System.out.println("Insert Test Finished");
		findTester(SA, SLL, UA, UL, BST);
		System.out.println("Find Test Finished");
		deleteTester(SA, SLL, UA, UL, BST);
		System.out.println("Delete Test Finished");

	}
	public static void insertTester(SADict SA, SLLDict SLL, UADict UA, ULLDict ULL, BSTDict BST) 
			throws FileNotFoundException {
		PrintStream output = new PrintStream(new File("insert.txt"));
		output.println("#Insertions" + "  " + "Time(ms)");
		testInsert(SA, output);
		testInsert(SLL, output);
		testInsert(UA, output);
		testInsert(ULL, output);
		testInsert(BST, output);
		output.println();
	}

	public static void findTester(SADict SA, SLLDict SLL, UADict UA, ULLDict ULL, BSTDict BST) 
			throws FileNotFoundException {
		PrintStream output = new PrintStream(new File("find.txt"));
		output.println("#TEST_SIZE" + "  " + "Time(ms)");
		testFind(SA, output);
		testFind(SLL, output);
		testFind(UA, output);
		testFind(ULL, output);
		testFind(BST, output);
		output.println();
	}

	public static void deleteTester(SADict SA, SLLDict SLL, UADict UA, ULLDict ULL, BSTDict BST) 
			throws FileNotFoundException {
		PrintStream output = new PrintStream(new File("delete.txt"));
		output.println("Elements Deleted" + "  " + "Time(ms)");
		testDelete(SA, output);
		testDelete(SLL, output);
		testDelete(UA, output);
		testDelete(ULL, output);
		testDelete(BST, output);
		output.println();
	}

	private static void testDelete(Dictionary dict, PrintStream output) {
		HashSet<Integer> keys = new HashSet<Integer>();
		ArrayList<Integer> keys1 = new ArrayList<Integer>();
		for (int i = 0; i < TEST_SIZE; i ++) {
			int testKey = r.nextInt(TEST_SIZE);
			while (keys.contains(testKey)) {
				testKey = r.nextInt(TEST_SIZE);
			}
			keys.add(testKey);
			keys1.add(testKey);
			dict.insert(testKey, "dummy");
		}
		Collections.shuffle(keys1);
		long startTime = System.nanoTime();
		while (!keys1.isEmpty()) {
			if (!dict.delete(keys1.remove(0))) {
				System.out.println("fail to delete");
			}
		}
		long endTime = System.nanoTime();
		output.print(TEST_SIZE + "  ");
		output.print((double)(endTime - startTime) / 1000000);
		output.println();
	}

	private static void testInsert(Dictionary dict, PrintStream output) {
		HashSet<Integer> keys = new HashSet<Integer>();
		long startTime = System.nanoTime();
		for (int i = 0; i < TEST_SIZE; i++) {
			int key = r.nextInt();
			while (keys.contains(key)) {
				key = r.nextInt();
			}
			keys.add(key);
			dict.insert(key, "dummy");
		}
		long endTime = System.nanoTime();
		output.print(TEST_SIZE + "  ");
		output.print((double)(endTime - startTime) / 1000000);
		output.println();
	}

	private static void testFind(Dictionary dict, PrintStream output) {
		for (int i = 0; i < TEST_SIZE; i ++) {
			dict.insert(r.nextInt(), "dummy");
		}
		long startTime = System.nanoTime();
		int operations = 0;
		while(operations < 100) {
			dict.find(r.nextInt());
			operations++;
		}
		long endTime = System.nanoTime();
		output.print(TEST_SIZE + "  ");
		output.print((double)(endTime - startTime) / 1000000);
		output.println();
	}
}
