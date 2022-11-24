
import java.net.*;
import java.util.Scanner;
import java.io.*;

public class Client {
	
	public static void main(String[] args) throws IOException, InterruptedException {
		Socket s;
		Scanner sc = new Scanner(System.in); // Un objet Scanner pour lire les entrées de l'utilisateur
		do {

			try {

				System.out.println("Lecteur carte en attente : Garder la configuration par défaut ? (o/n)");

				String rep = sc.nextLine();

				if (!rep.equals("o")) {      
					// Pour paramétrer l'adresse IP / Port du socket (si on veut)
					String ip = "0.0.0.0";
					do {
						System.out.println("adresse ip :");
						String strIp = sc.nextLine();
						if (strIp.matches("^[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}$")
								|| strIp.equalsIgnoreCase("localhost")) {
							ip = strIp;
						}
					} while (ip == "0.0.0.0");

					int port = 0;
					do {
						System.out.println("Numéro port :");
						String strPort = sc.nextLine();
						if (strPort.matches("^[0-9]{1,5}$")) {
							port = Integer.valueOf(strPort);
						}
					} while (port < 1025 || port > 65535);

					s = new Socket(ip, port);
				} else {
					s = new Socket("localhost", 2004);
				}

				s.setSoTimeout(5000);

				PrintWriter pr = new PrintWriter(s.getOutputStream());

				InputStreamReader in = new InputStreamReader(s.getInputStream());
				BufferedReader bf = new BufferedReader(in);       // Un objet BufferedReader permet de lire les flux de données envoyés par via un socket

				String str;
				
				// On suppose que le terminal envoie automatiquement un "HELLO" lorsqu'il detecte une carte
				envoyer(pr, "HELLO");

				String msg = recevoir(bf); // msg reçu devrait être "IDENTIFY"
				afficheMsg(msg);
				if (msg.equals("IDENTIFY")) {

					boolean reponseOK = false;
					int essai = 1;
					// Envoi de données (on répéte l'action jusqu'à ce que le code carte soit conforme)
					do {
						System.out.println("Num carte :");
						str = sc.nextLine(); // Lecture Num carte
						if (str.matches("^[0-9]{7}$")) {
							reponseOK = true;
							break;
						}
						if (essai > 3)
							break;
						essai++;

					} while (!reponseOK);

					if (reponseOK) {
						envoyer(pr, str);
						// Réception de données
						msg = recevoir(bf); //  msg reçu devrait être : "PRIVILIGED" , "CarteOK" ou "carteNO"
						afficheMsg(msg);

						if (msg.equals("PRIVILIGED")) {
							System.out.println("La porte est ouverte, maitre");   // Utilisateur avec "hasfullaccess==True" dans la BD
							} 
						else if (msg.equals("CarteOK")) {
							reponseOK = false;
							essai = 1;

							do {
								System.out.println("ID terminal :");
								str = sc.nextLine(); // Lecture id temrminal
								if (str.matches("^[0-9]{3}$")) {
									reponseOK = true;
									break;
								}

								if (essai > 3)
									break;
								essai++;

							} while (!reponseOK);

							if (reponseOK) {
								envoyer(pr, str);
								msg = recevoir(bf);  // msg reçu devrait être : "ReservOK" ou "ReservNO"
								afficheMsg(msg);
								if(msg.equals("ReservOK")) {
									reponseOK = false;
									essai = 1;

									do {
										System.out.println("Demander l'enregistrement de l'entrée (code: saveMe)");
										str = sc.nextLine(); // Lecture id temrminal
										if (str.matches("^saveMe$")) {
											reponseOK = true;
											break;
										}

										if (essai > 3)
											break;
										essai++;

									} while (!reponseOK);
									
									if(reponseOK) {
										envoyer(pr,str);
										msg = recevoir(bf);    // msg reçu devrait être : "EnregOK" ou "EnregNO"
										afficheMsg(msg);
										if (msg.equals("EnregOK")) {
											fermerConn(s,pr,"Porte ouverte !");  // En temps normal on envoi un signal vers le matériel qui gére l'ouverture de la porte
										}
										else if (msg.equals("EnregNO")) {
											fermerConn(s,pr,"Erreur d'enregistrement (réessayez)."); // La reservation existe mais l'entrée n'a pas pu être enregistrée
										} 
										else if (msg.equals("BYE")) {         
											fermerConn(s,pr,"Le serveur ne veut plus communiquer.");
										}
										else {
											fermerConn(s,pr);
										}
									}
									else {
										fermerConn(s,pr,"Nombre d'essais dépassé, représentez votre carte (no saveME).");  // Le terminal redevient en attente de lecture d'une carte
									}
								}
								else if (msg.equals("ReservNO")) {
									fermerConn(s,pr,"Vous n'avez pas reservé cette salle en ce moment.");
								}
								else if (msg.equals("BYE")) {
									
								} 
								else {
									fermerConn(s,pr);
								}
								
							} else {
								fermerConn(s,pr,"Nombre d'essais dépassé, représentez votre carte (ID terminal non conforme).");  // Le terminal redevient en attente de lecture d'une carte
							}

						} else if (msg.equals("CarteNO")) {
							fermerConn(s,pr,"Carte non reconnue.");
						} else if (msg.equals("BYE")){
							fermerConn(s,pr,"Le serveur ne veut plus communiquer.");
						} else {
							fermerConn(s,pr);
						}

						
						
					} else {
						fermerConn(s,pr,"Nombre d'essais dépassé, représentez votre carte (ID carte non conforme).");   // Le terminal redevient en attente de lecture d'une carte
					}

				} else {
					fermerConn(s,pr,"no IDENTIFY : Connexion interrompue");

				}

			} catch (IOException e) {
				System.err.println(e);
				System.out.println("Serveur introuvable (Vérifiez l'adresse IP / Port)");

			}

			Thread.sleep(500);
		} while (true);
		
	}

	
	
	/*
	 * Procédure qui permet d'envoyer des données vers un serveur
	 * paramétres :
	 * 		bf : l'objet PrintWriter permet d'ecrire des données et les envoyer via un socket
	 * 		msg : la donnée à envoyer 
	 */
	public static void envoyer(PrintWriter pr, String msg) {
		pr.println(msg);
		pr.flush();
	}

	
	/* Procédure qui permet de recevoir un message d'un serveur
	 * paramétres :
	 * 		bf : l'objet BufferedReader qui permet de lire des données envoyés via un socket
	 * 
	 */
	public static String recevoir(BufferedReader bf) throws IOException, SocketException {
		try {
			return bf.readLine();
		} catch (IOException e) {
			return "ERROR : Serveur ne réponds pas";
		}

	}

	
	
	
	public static void afficheMsg(String msg) {
		System.out.println("Server: " + msg);
	}
	
	
	
	
	// Procédure qui envoie "BYE" au serveur et ferme la connexion avec un message d'information
	public static void fermerConn(Socket s, PrintWriter pr, String msgInfo) throws IOException {
		envoyer(pr, "BYE");
		s.close();
		System.err.println(msgInfo);
		System.out.println("Fermeture de la connexion...");
	}
	
	
	
	
	// procédure qui envoie un BYE pour le serveur et ferme la connexion
	public static void fermerConn(Socket s, PrintWriter pr) throws IOException {
		envoyer(pr, "BYE");
		s.close();
		System.out.println("Fermeture de la connexion...");
	}
}
