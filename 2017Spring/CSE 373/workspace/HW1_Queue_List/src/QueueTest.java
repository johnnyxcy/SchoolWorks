import java.util.LinkedList;
import java.util.Queue;
import java.util.Stack;

public class QueueTest {
	/*Your functions (on the left) correspond to the following java Queue functions (on the right)
	 * toTest.enqueue(String a) = toCompare.add(String a)
	 * toTest.dequeue() = toCompare.poll()
	 * toTest.front() = toCompare.peek()
	 * 
	 * This private class performs this interface for you.
	 */
    private static class JavaQueue{
    	//DO NOT EDIT THIS CLASS
    	Queue<String> queue;
    	protected JavaQueue(){
    		queue = new LinkedList<String>();
    	}
    	protected void enqueue(String a){
    		queue.add(a);
    	}
    	protected String dequeue(){
    		return queue.poll();
    	}
    	protected String front(){
    		return queue.peek();
    	}
    }

	public static void main(String[] args){

		testEmpty(new ListQueue(),new JavaQueue());
		testOne(new ListQueue(),new JavaQueue());
		testMany(new ListQueue(),new JavaQueue());
		System.out.println(testEmpty(new ListQueue(),new JavaQueue()));
		System.out.println(testOne(new ListQueue(),new JavaQueue()));
		System.out.println(testMany(new ListQueue(),new JavaQueue()));
	}
	
	public static boolean testEmpty(ListQueue yourQueue, JavaQueue correctQueue){
		//TODO implement a test of the three functions when the queues are empty
		//Compare the result of your queue  against the java implementation
		if (yourQueue.front() == null &&
			yourQueue.dequeue() == null) {
			return testOne(yourQueue, correctQueue);
		}
		return false;
	}
	
	public static boolean testOne(ListQueue a, JavaQueue b){
		//TODO implement a test of the three functions when the queues have one element
		//Compare the result of your queue  against the java implementation
		a.enqueue("a");
		b.enqueue("a");
		if (a.front().equals(b.front())) {
			a.enqueue("b");
			b.enqueue("b");
			if (a.dequeue().equals(b.dequeue())) {
				return true;
			}
		}	
		return false;
	}
	
	public static boolean testMany(ListQueue a, JavaQueue b){
		//TODO implement a test of the three functions when the queues have many elements
		//Compare the result of your queue  against the java implementation
		//More than one test may be necessary
		Stack<String> s1 = new Stack<String>();
		Stack<String> s2 = new Stack<String>();
		String str = "abcdefghijk";
		for (int i = 0; i < str.length(); i++) {
			s1.push(str.substring(i, i + 1));
		}
		for (int i = 0; i < str.length(); i++) {
			s2.push(str.substring(i));
		}
		if (testMany(a, b, s1) && testMany(a, b, s2)) {
			return true;
		}
		return false;
	}
	
	private static boolean testMany(ListQueue a, JavaQueue b, Stack<String> s) {
		while(!s.isEmpty()) {
			String str = s.pop();
			a.enqueue(str);
			b.enqueue(str);
			if (!a.front().equals(b.front())) {
				return false;
			}
		}
		while(a.front() != null && b.front() != null) {
			if (!a.dequeue().equals(b.dequeue())) {
				return false;
			}
		}
		return a.front() == null;
	}
}
