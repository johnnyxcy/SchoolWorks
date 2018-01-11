public class SLLDict implements Dictionary {
	private class Node{
		//TODO implement Node class
		public int key;
		public String data;
		public Node next;
		
		public Node(int key, String data, Node next) {
			this.key = key;
			this.data = data;
			this.next = next;
		}
		
		public Node(int key, String data) {
			this (key, data, null);
		}
	}
	
	Node first;
	
	public void insert(int key, String value) {
		// TODO implement insert
		if (first == null) {
			first = new Node(key, value);
		} else if (first.key > key) {
			Node input = new Node(key, value, first);
			first = input;
		} else {
			Node cur = first;
			while (cur.next != null && cur.next.key < key) {
				cur = cur.next;
			}
			Node input = new Node(key, value, cur.next);
			cur.next = input;
		}
	}

	public String find(int key) {
		// TODO implement find
		if (first != null) {
			if (first.key == key) {
				return first.data;
			}
			Node cur = first;
			while(cur != null && cur.next != null && cur.next.key < key) {
				cur = cur.next;
			}
			if (cur != null && cur.next != null && cur.next.key == key) {
				return cur.next.data;
			}
		}
		return null;
	}

	public boolean delete(int key) {
		// TODO implement delete
		if (first != null) {
			if (first.key == key) {
				first = first.next;
				return true;
			} 
			Node cur = first;
			while (cur != null && cur.next != null && cur.next.key <= key) {
				if (cur.next.key == key) {
					cur.next = cur.next.next;
					return true;
				}
				cur = cur.next;
			}
		}
		return false;
	}
	
}
