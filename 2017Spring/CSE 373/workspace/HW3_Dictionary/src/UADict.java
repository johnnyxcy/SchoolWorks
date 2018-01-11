public class UADict implements Dictionary {

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
	
	public UADict() {
		nodes = new Node[2];
		size = 0;
	}
	public void insert(int key, String value) {
		// TODO implement insert
		if (nodes.length <= size + 1) {
			resize();
		}
		size++;
		nodes[size] = new Node(key, value);
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
		for (int i = 0; i < size; i++) {
			if (nodes[i] != null && nodes[i].key == key) {
				return nodes[i].value;
			}
		}
		return null;
	}

	public boolean delete(int key) {
		// TODO implement delete
		for (int i = 0; i < nodes.length; i++) {
			if (nodes[i] != null && nodes[i].key == key) {
				for (int j = i; j < size; j++) {
					nodes[j] = nodes[j + 1];
				}
				size--;
				return true;
			}
		}
		return false;
	}

}
