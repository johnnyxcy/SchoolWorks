/**
 * Base interface for priority queue implementations for Strings.
 * Do not edit this interface 
 */
public interface PriorityQueue {
	
	/**
	 * Returns true if priority queue has no elements
	 *
	 * @return true if the priority queue has no elements
	 */
	public boolean isEmpty();


	/**
	 * Returns the number of elements in this priority queue.
	 *
	 * @return the number of elements in this priority queue.
	 */
	public int size();


	/**
	 * Returns the minimum element in the priority queue
	 *
	 * @return the minimum element or return null if empty
	 */
	public String findMin();


	/**
	 * Inserts a new element into the priority queue.
	 * Duplicate priorities ARE allowed.
	 * Objects of duplicate priority may dequeue in any order
	 * @param x element to be inserted into the priority queue.
	 */
	public void insert(String data, int priority);


	/**
	 * Removes and returns the minimum element from the priority queue.
	 * Objects of duplicate priority may dequeue in any order.
	 * @return the minimum element or null if empty
	 */
	public String deleteMin();
	
	/**
	 * Changes the priority of a given object in the heap.
	 * You can assume that it will be the same String object.
	 * @return true if the operation was successful, false if the string was not found.
	 */
	public boolean changePriority(String data, int newPri);



	/**
	 * Resets the priority queue to appear as not containing
	 * any elements.
	 */
	public void makeEmpty();

}
