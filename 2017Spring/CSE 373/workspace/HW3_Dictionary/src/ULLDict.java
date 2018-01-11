public class ULLDict implements Dictionary {
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
	Node last;

	public void insert(int key, String value) {
		// TODO implement insert
		if (last == null) {
			last = new Node(key, value);
			first = last;
		} else {
			Node input = new Node(key, value);
			last.next = input;
			last = input;
		}
	}
	
	public String find(int key) {
		// TODO implement find
		Node cur = first;
		while (cur != null) {
			if (cur.key == key) {
				return cur.data;
			}
			cur = cur.next;
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
			while (cur != null && cur.next != null) {
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
