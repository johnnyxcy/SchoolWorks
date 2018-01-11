public class SADict implements Dictionary {
	private class Node {
		public int key;
		public String value;

		public Node(int key, String value) {
			this.key = key;
			this.value = value;
		}
	}

	private Node[] nodes;
	private int size;
	
	public SADict() {
		nodes = new Node[2];
		size = 0;
	}
	
	public void insert(int key, String value) {
		// TODO implement insert
		if (nodes.length <= size + 1) {
			resize();
		}
		if (nodes[0] == null) {
			nodes[0] = new Node(key,value);
		}else if (key < nodes[0].key) {
			for (int i = size - 1; i >= 0; i--) {
				nodes[i + 1] = nodes[i];
			}
			nodes[0] = new Node(key, value);
		} else if (nodes[size - 1] !=null && key > nodes[size - 1].key) {
			nodes[size] = new Node(key, value);
		} else {
			int low = 0;
			int high = size - 1;
			while (high - low != 1) {
				int mid = low + (high - low) / 2;
				if (nodes[mid] != null && key < nodes[mid].key) {
					high = mid;
				} else if (nodes[mid] != null && key > nodes[mid].key) {
					low = mid;
				}
			}
			for (int i = size - 1; i >= high; i--) {
				nodes[i + 1] = nodes[i];
			}
			nodes[high] = new Node(key, value);
		}
		size++;
	}

	private void resize() {
		Node[] newNodes = new Node[nodes.length * 2];
		for(int i = 0; i < nodes.length; i++) {
			newNodes[i] = nodes[i];
		}
		nodes = newNodes;
	}

	public String find(int key) {
		// TODO implement find
		int low = 0; 
		int high = size - 1;
		while (low <= high) {
			int mid = low + (high - low) / 2;
			if (key < nodes[mid].key) {
				high = mid - 1;
			} else if (key > nodes[mid].key) {
				low = mid + 1;				
			} else {
				return nodes[mid].value;
			}
		}
		return null;
	}
	
	public boolean delete(int key) {
		// TODO implement delete
		int low = 0;
		int high = size - 1;
		while (low <= high) {
			int mid = low + (high - low) / 2;
			if (nodes[mid] != null && key < nodes[mid].key) {
				high = mid - 1;
			} else if (nodes[mid] != null && key > nodes[mid].key) {
				low = mid + 1;				
			} else {
				for (int i = mid; i < size; i++) {
					nodes[i] = nodes[i + 1];
				}
				size--;
				return true;
			}
		}
		return false;
	}

}
