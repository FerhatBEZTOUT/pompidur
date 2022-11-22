package client_project;
import java.net.*;
import java.util.Scanner;
import java.io.*;

public class Client {
	public static void main(String[] args) throws IOException {
		Socket s = new Socket("localhost",2004);  // Création d'un socket 
		
		PrintWriter pr = new PrintWriter (s.getOutputStream());  // Objet printWriter qui permet d'envoyer des msgs via des sockets
		Scanner sc= new Scanner(System.in); // Un objet Scanner pour lire les entrées de l'utilisateur
		
		InputStreamReader in = new InputStreamReader(s.getInputStream());   // Objet InputStreamReader qui permet de lire des msgs envoyé via des sockets
		BufferedReader bf = new BufferedReader(in);
		
		String str;
		//String str = sc.nextLine(); // NextLine() pour lire une ligne de l'utilisateur
		envoyer(pr,"HELLO");
		
		String msg = recevoir(bf);
		System.out.println("Reponse serveur\n"+msg);
		
		// Envoi de données
		str= sc.nextLine(); //reads string.
		envoyer(pr,str);
		
		// Réception de données
		msg = recevoir(bf);
		System.out.println("Reponse serveur\n"+msg);
		
		
		pr.println("aurevoir");
		pr.flush();
	}
	
	public static void envoyer(PrintWriter pr, String msg) {
		pr.println(msg);
		pr.flush();
	}
	
	public static String recevoir(BufferedReader bf) throws IOException {
		return bf.readLine();
	}
}
