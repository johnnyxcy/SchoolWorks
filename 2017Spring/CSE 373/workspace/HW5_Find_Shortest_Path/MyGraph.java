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


	/**
	 * Returns the shortest path from a to b in the graph, or null if there is
	 * no such path.  Assumes all edge weights are nonnegative.
	 * Uses Dijkstra's algorithm.
	 * @param a the starting vertex
	 * @param b the destination vertex
	 * @return a Path where the vertices indicate the path from a to b in order
	 *   and contains a (first) and b (last) and the cost is the cost of 
	 *   the path. Returns null if b is not reachable from a.
	 * @throws IllegalArgumentException if a or b does not exist.
	 */

	public Path shortestPath(Vertex a, Vertex b) {

		// YOUR CODE HERE
		if (!map.containsKey(a) || !map.containsKey(b)) {
			throw new IllegalArgumentException();
		}
		ArrayList<Vertex> path = new ArrayList<Vertex>();
		if (a.equals(b)) {
			path.add(a);
			return new Path(path, 0);
		}
		Collection<Vertex> dij = Dijkstra(a);
		Vertex cur = null;
		Vertex target = null;
		for (Vertex v:dij) {
			if (v.equals(b)) {
				cur = v;
				target = v;
			}
		}
		if (cur.previous == null) {
			return null;
		}
		while(cur != null) {
			path.add(cur);
			cur = cur.previous;
		}
		Collections.reverse(path);
		return new Path(path, target.cost);

	}

	private Collection<Vertex> Dijkstra(Vertex source) {
		if (!map.containsKey(source)) {
			throw new IllegalArgumentException();
		}
		PriorityQueue<Vertex> unknown = new PriorityQueue<Vertex>();
		Collection<Vertex> known = new HashSet<Vertex>();
		unknown.addAll(map.keySet());
		unknown.remove(source);
		source.cost = 0;
		unknown.add(source);
		while(!unknown.isEmpty()) {
			Vertex shortest = unknown.poll();
			unknown.remove(shortest);
			known.add(shortest);
			for (Vertex child:adjacentVertices(shortest)) {
				if (unknown.contains(child)) {
					for (Vertex dijV:unknown) {
						if (dijV.equals(child)) {
							child = dijV;
						}
					}	
					int newCost = shortest.cost + edgeCost(shortest, child);
					if (newCost < child.cost) {
						unknown.remove(child);
						// Get a copy of the vertex and update to keep original data
						Vertex update = new Vertex(child.getLabel()); 
						update.cost = newCost;
						update.previous = shortest;
						unknown.add(update);
					}
				}
			}
		}
		return known;
	}
}
