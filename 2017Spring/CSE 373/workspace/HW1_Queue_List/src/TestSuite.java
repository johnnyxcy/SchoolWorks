import java.util.LinkedList;
import java.util.Queue;

import java.io.InputStreamReader;
import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

public class TestSuite {
	
	private static boolean test(TestQueue toTest,Queue<String> toCompare, String filename){
		
		FileInputStream fstream = null;
		try {
			fstream = new FileInputStream(filename);
		} catch (FileNotFoundException e) {
			System.err.println("File "+filename+" not found");
			return false;
		}
		BufferedReader br = new BufferedReader(new InputStreamReader(fstream));
		
		String line;
		try {
			line = br.readLine();
			do{
				if(line.equals("")){
					line = br.readLine();
					continue;
				}
				String[] commands = line.split("\\s");
				if(commands[0].equalsIgnoreCase("enqueue") && commands.length==2 && !commands[1].equals("#")){
					toTest.enqueue(commands[1]);
					toCompare.add(commands[1]);
				} else if(commands[0].equalsIgnoreCase("dequeue") && commands.length==2){
					String comp = toCompare.poll();
					String tested = toTest.dequeue();
					if(!commands[1].equals(comp) && !(comp == null && commands[1].equals("#"))){
						br.close();
						return false;
					}
					if((tested==null ^ comp==null) || (tested != null && comp != null && !tested.equals(comp))){
							br.close();
							return true;
					}
				} else {
					System.err.println("Unrecognized command in "+filename);
					System.err.println(line);
					br.close();
					return false;
				}
				line = br.readLine();
			}while(line!=null);	
			br.close();					
		} catch (IOException e) {
			e.printStackTrace();
			return false;
		}
		
		return false;				
		
	}
	public static boolean test1() {
		TestQueue toTest = new TestQueue1();
		Queue<String> toCompare;
		toCompare = new LinkedList<String>();
		
		return test(toTest,toCompare,"test1.txt");

				
	}
	
	public static boolean test2(){
		TestQueue toTest = new TestQueue2();
		Queue<String> toCompare;
		toCompare = new LinkedList<String>();
		
		return test(toTest,toCompare,"test2.txt");
	}
	
	public static boolean test3(){
		TestQueue toTest = new TestQueue3();
		Queue<String> toCompare;
		toCompare = new LinkedList<String>();
		
		return test(toTest,toCompare,"test3.txt");
	}
	
	public static boolean test4(){
		TestQueue toTest = new TestQueue4();
		Queue<String> toCompare;
		toCompare = new LinkedList<String>();
		
		return test(toTest,toCompare,"test4.txt");
	}
	
	public static boolean test5(){
		TestQueue toTest = new TestQueue5();
		Queue<String> toCompare;
		toCompare = new LinkedList<String>();
		
		return test(toTest,toCompare,"test5.txt");
	}
	
	public static void main(String[] args){
		String print = test1()?"Passed":"Failed";
		System.out.println("Test 1: "+print); 

		print = test2()?"Passed":"Failed";
		System.out.println("Test 2: "+print);

		print = test3()?"Passed":"Failed";
		System.out.println("Test 3: "+print);

		print = test4()?"Passed":"Failed";
		System.out.println("Test 4: "+print);

		print = test5()?"Passed":"Failed";
		System.out.println("Test 5: "+print);
		
	}
	
	
}
