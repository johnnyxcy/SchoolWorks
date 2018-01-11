public class testBSTDict {
	private static final int N = 13;
	private static final int TEST_SIZE = (int)Math.pow(2, N) - 1;

	public static void main(String[] args) {
		BSTDict test1 = new BSTDict();
		BSTDict test2 = new BSTDict();
		bestCaseTest(test1);
		worstCaseTest(test2);
	}
	
	public static void bestCaseTest(BSTDict dict) {
		int n = (TEST_SIZE + 1) / 2;
		dict.insert(n, "dummy");
		add(dict, (int)Math.pow(2, N - 2), n);
		System.out.println("Best Case");
		System.out.println("Size" + "  " + "Time(ms)");
		findTester(dict);
	}
	
	private static void add(BSTDict dict, int diff, int n) {
		if (diff > 0) {
			dict.insert(n - diff, "dummy");
			dict.insert(n + diff, "dummy");
			add(dict, diff / 2, n - diff);
			add(dict, diff / 2, n + diff);
		}
	}
	
	public static void worstCaseTest(BSTDict dict1) {
		for (int i = 0; i < TEST_SIZE; i++) {
			dict1.insert(i, "");
		}
		System.out.println("Worst Case");
		System.out.println("Size" + "  " + "Time(ms)");
		findTester(dict1);
	}
	
	public static void findTester(BSTDict dict) {
		long startTime = System.nanoTime();
		int operations = 0;
		while(operations < 100) {
			dict.find(TEST_SIZE);
			operations++;
		}
		long endTime = System.nanoTime();
		System.out.print(TEST_SIZE + "  ");
		System.out.print((double)(endTime - startTime) / 1000000);
		System.out.println();
		System.out.println();
	}
}
