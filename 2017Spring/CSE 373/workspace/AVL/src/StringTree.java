import java.util.Iterator;

public interface StringTree {
	
	public void makeEmpty();
	public int size();
	public void insert(String key, String value);
	public String find(String key);
	public Iterator<String> getBFSIterator();
}
