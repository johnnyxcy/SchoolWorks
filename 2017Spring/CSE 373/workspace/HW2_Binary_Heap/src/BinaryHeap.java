
public class BinaryHeap implements PriorityQueue{
	private class HeapData{
		private String data;
		private int priority;
		
		protected HeapData(String dat,int pri){
			data = dat;
			priority = pri;
		}
		
		protected void changePriority(int newPri){
			priority = newPri;
		}
		// Add additional functions here as necessary
		
	}
	
	private HeapData[] heap; // This should be the array where you store your data, priority pairs.
	// We recommend that you use an array that starts at index 1 to make the math easier
	
	private int size;
	
	public BinaryHeap(){
		//TODO BinaryHeap constructor
		this(0);
	}
	
	public BinaryHeap(int startArray){
		//TODO this constructor should set the start size of your heap array to startArray
		if (startArray >= 0) {
			this.size = 0;
			// Let the first element be empty.
			startArray++;
			this.heap = new HeapData[startArray];
		}
	}
	
	public boolean isEmpty(){
		//TODO implement isEmpty
		return size == 0;
	}
	
	public int size(){
		//TODO implement size
		return size;
	}
	
	public String findMin(){
		//TODO implement findMin
		if (!isEmpty()) {
			return heap[1].data;
		}
		return null;
	}
	
	public void insert(String data, int priority){
		//TODO implement insert
		HeapData val = new HeapData(data, priority);
		if (heap.length == 1) {
			heap = new HeapData[2];
		}
		if (size + 1 >= heap.length) {
			HeapData[] newHeap = new HeapData[heap.length * 2];
			for (int i = 0; i < heap.length; i++) {
				newHeap[i] = this.heap[i];
			}
			this.heap = newHeap;
		}
		size++;
		heap[size] = val;
		percolateUp(size);
	}

	private void percolateUp(int position) {
		HeapData val = new HeapData(heap[position].data, heap[position].priority);
		if (position > 1 && val.priority <= heap[position / 2].priority) {
			heap[position] = heap[position / 2];
			heap[position / 2] = val;
			percolateUp(position / 2);
		}
	}
	
	public String deleteMin(){
		//TODO implement deleteMin
		if (!isEmpty()) {
			HeapData output = new HeapData(heap[1].data, heap[1].priority);
			if (size == 1) {
				this.makeEmpty();
			} else {
				heap[1] = heap[size];
				size--;
				percolateDown(1);
			}
			return output.data;
		}
		return null;
	}

	private void percolateDown(int position) {
		int child1 = 2 * position;
		int child2 = 2 * position + 1;
		HeapData val = new HeapData(heap[position].data, heap[position].priority);
		if (child1 > size) {
			// Do Nothing. We are done
		} else if (child2 > size) {
			// Compare root with child1
			if (heap[child1].priority < heap[position].priority) {
				heap[position] = heap[child1];
				heap[child1] = val;
				percolateDown(child1);
			}
		} else if (heap[position].priority > Math.min(heap[child1].priority, heap[child2].priority)){ // child1 and child2 exist
			// Compare child1 and child2 and switch if needed
			if (heap[child1].priority < heap[child2].priority) {
				heap[position] = heap[child1];
				heap[child1] = val;
				percolateDown(child1);					
			} else {
				heap[position] = heap[child2];
				heap[child2] = val;
				percolateDown(child2);
			}
		}
	}
	
	public void makeEmpty(){
		//TODO implement makeEmpty
		heap = new HeapData[0]; 
		size = 0;
	}
	
	public boolean changePriority(String data, int newPri){
		//TODO implement changePriority
		for (int i = 1; i <= size; i++) {
			if (heap[i].data.equals(data)) {
				if (newPri > heap[i].priority) {
					heap[i].changePriority(newPri);
					percolateDown(i);
				} else {
					heap[i].changePriority(newPri);
					percolateUp(i);
				}
				return true;
			}
		}
		return false;
	}

}
