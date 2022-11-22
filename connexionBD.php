<?php
    try {
        // objet PDO qui permet de faire des requete vers la BD
        $conn = new PDO('pgsql:host='. $host.';dbname='.$dbname.'',$user,$password);
        
    } catch (PDOException $e) {
        echo 'Impossible de se connecter à la BDD : '.$e->getMessage();
        
    }

?>