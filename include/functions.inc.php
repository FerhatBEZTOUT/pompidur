<?php

	include ("include/util.inc.php");

	/*Nom d'utilisateur*/
	define("EMAIL", "mel@gmail.com");
	
	/*Mot de passe*/
	define("PASSWORD", "A123456");
	
	

	
	/**********************
	
	/**
	* Fonction qui se connecte au serveur Web
	* @return $connect une ressource php de type PgSql\Connection
	*/
	
	function connect_server_web() {
		$username = "user=pampidur";
		$password = "password=Ma3dnous!!";
		$host = "host=postgresql-pampidur.alwaysdata.net";
		$database = "dbname=pampidur_bdd";
		$port = "port=5432";
		
		$con_string = $host." ".$port." ".$database." ".$username." ".$password;
		$connect = pg_connect($con_string);
		return $connect;
	}

	/**
	 * Fonction qui teste l'identifiant et le mot de passe de connexion au site.
	 * @param $id_user l'identifiant de connexion.
	 * @param $password le mot de passe de connexion.
	 * @return $is_connected indique si la tentative de connexion est valide ou non.
	 * */

	function connect_user(string $mail_user, string $password) : bool {
        // initialisation de $is_connected
        $is_connected = false;

        //connexion a la bd
        $connect = connect_server_web();

        // recuperation de l'id
        $tmp = pg_query($connect, "SELECT mdp_user FROM utilisateur WHERE email_user='".$mail_user."';");
        $table = pg_fetch_all($tmp);
      	$result = $table[0];
      	$hash_pw_db = $result['mdp_user'];
		
      	if(password_verify($password, $hash_pw_db)){
      		$is_connected = true;
      	}  

        return $is_connected;
    }

    
    /**
		* Fonction qui vérifie le mail et le mdp d'un utilisateur ensuit verifie si l'utilisatuer en question est un adherent il le renvoie dans la page dashboard.php sinon vers monespace.php
		* @param $ email_user 
		* @param $ mdp_user mot de passe
		* @return true si c'est les bons identifiants, sinon false
		* */

    function get_name_user(string $mail_user) : array {
        $connect = connect_server_web();
        if($connect === 0){
            echo "<p>Error : Unable to open database</p>\n";
            return array("", "");
        }
        /* Requête: select nom_user, prenom_user from utilisateur where utilisateur.mail_user='mel@gmail.com';*/
        $tmp = pg_query($connect, "SELECT nom_user, prenom_user FROM utilisateur WHERE utilisateur.email_user='".$mail_user."';");
        //On récupère la première ligne car on aura un seul tuple après la sélection
        $result = pg_fetch_row($tmp);
        if($result == NULL){
            $result = array();
        }
        return $result;
    }


	
	function get_stock() : array {
		$connect = connect_server_web();
		if(connect_server_web()== 0){
			echo "<p>Error : Unable to open database</p>\n";
			return array("");
		}
		$tmp = pg_query($connect, "SELECT DISTINCT ON (1) id_user, id_adh, id_emp FROM utilisateur,employe,adherent;");
		$result = pg_fetch_all($tmp);
		return $result;
	}
		
	
?>