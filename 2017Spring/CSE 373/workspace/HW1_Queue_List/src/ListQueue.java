
public class ListQueue {
	private class Node{
		//TODO Implement Linked List Node
		public String data;
		public Node next;
		
		public Node(String dat, Node next) {
			this.data = dat;
			this.next = next;
		}
		
		public Node(String dat) {
			this (dat, null);
		}
	}
	
	//Class variables here, if necessary
	private Node front;
	
	public ListQueue(){
		front = null;
	}
	
	public void enqueue(String toInput) {
		// TODO Implement enqueue
		if (front == null) {
			front = new Node(toInput);
		} else {
			Node cur = front;
			while (cur.next != null) {
				cur = cur.next;
			}
			cur.next = new Node(toInput);
		}
	}
	
	public String dequeue(){
		// TODO Implement dequeue
		if (front != null) {
			String toOutput = front.data;
			front = front.next;
			return toOutput;
		}
		return null;
	}
	
	public String front(){
		// TODO Implement front
		if (front != null) {
			return front.data;
		}
		return null;
	}

}
