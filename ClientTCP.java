package client_project;
import java.io.IOException ;
import java.io.BufferedReader ;
import java.io.InputStreamReader ;
import java.io.PrintWriter ;
import java.io.IOException ;
import java.net.Socket ;
import java.net.UnknownHostException ;

public class ClientTCP {
    public static void main (String argv []) throws IOException {
        Socket socket = null ;
        PrintWriter flux_sortie = null ;
        BufferedReader flux_entree = null ;
        String chaine ;

        try {
            // deuxieme argument : le numero de port que l'on contacte
            socket = new Socket ("127.0.0.1", 2005) ;
            flux_sortie = new PrintWriter (socket.getOutputStream (), true) ;
            flux_entree = new BufferedReader (new InputStreamReader (
                                        socket.getInputStream ())) ;
        } 
        catch (UnknownHostException e) {
            System.err.println ("Hote inconnu") ;
            System.exit (1) ;
        } 

	// L'entree standard
        BufferedReader entree_standard = new BufferedReader ( new InputStreamReader ( System.in)) ;

	do {
		// on lit ce que l'utilisateur a tape sur l'entree standard
		chaine = entree_standard.readLine () ;

		// et on l'envoie au serveur
		flux_sortie.println (chaine) ;

		// on lit ce qu'a envoye le serveur
		chaine = flux_entree.readLine () ;

		// et on l'affiche a l'ecran
		System.out.println ("Le serveur m'a repondu : " + chaine) ;
        } while (chaine != null) ;

        flux_sortie.close () ;
        flux_entree.close () ;
        entree_standard.close () ;
        socket.close () ;
    }
}
