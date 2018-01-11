
public interface Dictionary {
	
	public void insert(int key, String value);
	//Keys should be unique and values should be non-null.
	
	public String find(int key);
	// Return null if the object is not in the dictionary
	
	public boolean delete(int key);
	// Return false if the key is not found in the dictionary
	
}
