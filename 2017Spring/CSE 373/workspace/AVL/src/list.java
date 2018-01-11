// My own ArrayList
public class list<E> {
		private class listNode {
			E dat;
			listNode next;
			
			public listNode(E dat, listNode next) {
				this.dat = dat;
				this.next = next;
			}
		}
		
		listNode front;
		listNode last;
		public list() {
			this.front = null;
			this.last = null;
		}
		public void add(E input) {
			if (front == null) {
				front = new listNode(input, null);
				last = front;
			} else {
				last.next = new listNode(input, null);
				last = last.next;
			}
		}
		public int find(E target) {
			int result = 0;
			listNode cur = front;
			while (cur != null) {
				if (cur.dat.equals(target)) {
					return result;
				}
				result++;
				cur = cur.next;
			}
			return -1;
		}
		public boolean isEmpty() {
			return front == null;
		}
		public E remove() {
			E result = front.dat;
			front = front.next;
			return result;
		}
	}