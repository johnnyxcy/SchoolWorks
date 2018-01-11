import java.util.*;
import java.io.*;

/**
 * Driver program that reads in a graph and prompts user for shortest paths in the graph.
 * (Intentionally without comments.  Read through the code to understand what it does.)
 */

public class FindPaths {
	public static void main(String[] args) {
		MyGraph g = readGraph("vertex.txt", "edge.txt");

		Scanner console = new Scanner(System.in);
		Collection<Vertex> v = g.vertices();
        Collection<Edge> e = g.edges();
		System.out.println("Vertices are "+v);
		System.out.println("Edges are "+e);
		while(true) {
			System.out.print("Start vertex? ");
			Vertex a = new Vertex(console.nextLine());
			if(!v.contains(a)) {
				System.out.println("no such vertex");
				System.exit(0);
			}
			
			System.out.print("Destination vertex? ");
			Vertex b = new Vertex(console.nextLine());
			if(!v.contains(b)) {
				System.out.println("no such vertex");
				System.exit(1);
			}
			
			// YOUR CODE HERE: call shortestPath and print
			// out the result
			Path shortest = g.shortestPath(a, b);
			if (shortest == null) {
				System.out.println(a.toString() + " is not reachable from " + b.toString());
			} else {
				System.out.println("The least cost will be " + shortest.cost);
				System.out.println("The shortest path will be " + shortest.vertices.toString());
			}
		}
	}

	public static MyGraph readGraph(String f1, String f2) {
		Scanner s = null;
		try {
			s = new Scanner(new File(f1));
		} catch(FileNotFoundException e1) {
			System.err.println("FILE NOT FOUND: "+f1);
			System.exit(2);
		}

		Collection<Vertex> v = new ArrayList<Vertex>();
		while(s.hasNext())
			v.add(new Vertex(s.next()));

		try {
			s = new Scanner(new File(f2));
		} catch(FileNotFoundException e1) {
			System.err.println("FILE NOT FOUND: "+f2);
			System.exit(2);
		}

		Collection<Edge> e = new ArrayList<Edge>();
		while(s.hasNext()) {
			try {
				Vertex a = new Vertex(s.next());
				Vertex b = new Vertex(s.next());
				int w = s.nextInt();
				e.add(new Edge(a,b,w));
			} catch (NoSuchElementException e2) {
				System.err.println("EDGE FILE FORMAT INCORRECT");
				System.exit(3);
			}
		}

		return new MyGraph(v,e);
	}
}
