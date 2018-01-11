// LLN search
public boolean contains(Obj str) {
	return contains(str, front);
}
private boolean contains(Obj str, LLN node) {
	if (node == null) {
		return false;
	} else if (node.data == str) {
		return true;
	}
	return contains(str, node.next);
}

// BST depth first search
public boolean contains(Obj s) {
	return contains(s, root);
}
private boolean contains(Obj s, BSN node) {
	if (node == null) {
		return false;
	} else if (node.data == s) {
		return true;
	}
	return contains(s, node.left) || contains(s, node.right);
}



// Breadth first serach
public boolean contains(Obj s, Node root) {
	LinkedList q = new Queue<Obj>();
	q.enqueue(root);
	Node cur;
	while(!q.isEmpty()) {
		cur = q.dequeue();
		if (cur == s) {
			return true;
		} else {
			q.enqueue(root.left);
			q.enqueue(root.right);
		}
	}
	return false;
}