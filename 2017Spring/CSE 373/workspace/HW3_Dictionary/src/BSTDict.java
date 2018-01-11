public class BSTDict implements Dictionary {
	private class BSTNode{
		//TODO implement Node class
		int key;
		String value;
		BSTNode left;
		BSTNode right;

		public BSTNode(int key, String value) {
			this(key, value, null, null);
		}

		public BSTNode(int key, String value, BSTNode left, BSTNode right) {
			this.key = key;
			this.value = value;
			this.left = left;
			this.right = right;
		}
	}
	
	BSTNode overallRoot;
	int size;
	
	public BSTDict() {
		overallRoot = null;
	}
	
	public void insert(int key, String value) {
		// TODO implement insert
		overallRoot = insert(overallRoot, key, value);
	}

	private BSTNode insert(BSTNode root, int key, String value) {
		if (root == null) {
			root = new BSTNode(key, value);
		} else if (key < root.key) {
			root.left = insert(root.left, key, value);
		} else if (key > root.key) {
			root.right = insert(root.right, key, value);
		}
		return root;
	}



	public String find(int key) {
		// TODO implement find
		BSTNode searchResult = explore(key, overallRoot);
		if (searchResult != null) {
			return searchResult.value;
		}
		return null;
	}

	public boolean delete(int key) {
		// TODO implement delete
		if (explore(key, overallRoot) != null) {
			overallRoot = delete(key, overallRoot);
			return true;
		}
		return false;
	}

	private BSTNode delete(int key, BSTNode root) {
		if (root != null) {
			if (key < root.key) {
				root.left = delete(key, root.left);
			} else if (key > root.key) {
				root.right = delete(key, root.right);
			} else {
				if (root.left == null && root.right == null) {
					root = null;
				} else if (root.left == null) {
					root = root.right;
				} else if (root.right == null) {
					root = root.left;
				} else { // find the min child from right and replace
					int minChild  = findMin(root.right);
					String newValue = find(minChild);
					root.right = delete(minChild, root.right);
					root.key = minChild;
					root.value = newValue;
				}
			}
		}
		return root;
	}

	private int findMin(BSTNode root) {
		if (root == null) {
			return -1;
		}else if (root.left == null) {
			return root.key;
		} else {
			return findMin(root.left);
		}
	}

	private BSTNode explore(int key, BSTNode node) {
		if (node != null) {
			if (node.key > key) {
				return explore(key, node.left);
			} else if (node.key < key) {
				return explore(key, node.right);
			} else {
				return node;
			}
		}
		return null;
	}

}
