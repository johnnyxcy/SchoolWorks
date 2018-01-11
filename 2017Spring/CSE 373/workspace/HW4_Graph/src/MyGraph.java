import java.util.*;

/**
 * A representation of a graph.
 * Assumes that we do not have negative cost edges in the graph.
 */
public class MyGraph implements Graph {
    // you will need some private fields to represent the graph
    // you are also likely to want some private helper methods
	private HashMap<Vertex, HashSet<Edge>> map = 
			new HashMap<Vertex, HashSet<Edge>>();

	
    /**
     * Creates a MyGraph object with the given collection of vertices
     * and the given collection of edges.
     * @param v a collection of the vertices in this graph
     * @param e a collection of the edges in this graph
     */
    public MyGraph(Collection<Vertex> v, Collection<Edge> e) {

	// YOUR CODE HERE
    	for (Vertex ver:v) {
    		for(Edge edge:e) {
    			if (!map.containsKey(ver)) {
    				map.put(ver, new HashSet<Edge>());
    			}
    			if (edge.getSource().equals(ver)) {
    				HashSet<Edge> newEdges = map.get(ver);
    				newEdges.add(edge);
    				map.put(ver, newEdges);
    			}
    		}
    	}
    }

    /** 
     * Return the collection of vertices of this graph
     * @return the vertices as a collection (which is anything iterable)
     */
    public Collection<Vertex> vertices() {

	// YOUR CODE HERE
    	return map.keySet();
    }

    /** 
     * Return the collection of edges of this graph
     * @return the edges as a collection (which is anything iterable)
     */
    public Collection<Edge> edges() {

	// YOUR CODE HERE
    	HashSet<Edge> allEdges = new HashSet<Edge>();
    	for(Vertex cur:map.keySet()) {
    		for(Edge e:map.get(cur)) {
    			if (!allEdges.contains(e)) {
    				allEdges.add(e);
    			}
    		}
    	}
    	return allEdges;
    }

    /**
     * Return a collection of vertices adjacent to a given vertex v.
     *   i.e., the set of all vertices w where edges v -> w exist in the graph.
     * Return an empty collection if there are no adjacent vertices.
     * @param v one of the vertices in the graph
     * @return an iterable collection of vertices adjacent to v in the graph
     * @throws IllegalArgumentException if v does not exist.
     */
    public Collection<Vertex> adjacentVertices(Vertex v) {

	// YOUR CODE HERE
    	if (!map.containsKey(v)) {
    		throw new IllegalArgumentException();
    	}
    	Collection<Edge> edges = map.get(v);
    	HashSet<Vertex> adj = new HashSet<Vertex>();
    	for (Edge e:edges) {
    		adj.add(e.getDestination());
    	}
    	return adj;
    }

    /**
     * Test whether vertex b is adjacent to vertex a (i.e. a -> b) in a directed graph.
     * Assumes that we do not have negative cost edges in the graph.
     * @param a one vertex
     * @param b another vertex
     * @return cost of edge if there is a directed edge from a to b in the graph, 
     * return -1 otherwise.
     * @throws IllegalArgumentException if a or b do not exist.
     */
    public int edgeCost(Vertex a, Vertex b) {

	// YOUR CODE HERE
    	if (!map.containsKey(a) || !map.containsKey(b)) {
    		throw new IllegalArgumentException();
    	}
    	HashSet<Edge> edges = map.get(a);
    	for(Edge e:edges) {
    		if (e.getDestination().equals(b)) {
    			return e.getWeight();
    		}
    	}
    	return -1;
    }
    
}
