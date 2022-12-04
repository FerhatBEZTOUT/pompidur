<?php
    include_once __DIR__.'/../Model/connexionBD.php';

       
    /**
     * getSalles :  Récupére les salles ordonnées par batiment , étage
     *
     * @return void
     */
    function getSalles() {
        GLOBAL $conn;
        try {
            $query = $conn->prepare("SELECT id_salle, nom_salle, etage_salle, batiment_salle FROM salle ORDER BY batiment_salle,etage_salle");
            $query->execute();
            $result = $query->fetchAll(PDO::FETCH_OBJ);
            return $result;

        } catch (PDOException $e) {
            echo $e->getMessage();
        }
    }

    function getSalleByID($id_salle) {
        GLOBAL $conn;
        try {
            $query = $conn->prepare("SELECT nom_salle, etage_salle, batiment_salle FROM salle WHERE id_salle=?");
            $query->execute(array($id_salle));
            $result = $query->fetch(PDO::FETCH_OBJ);
            return $result;

        } catch (PDOException $e) {
            echo $e->getMessage();
        }
    }


    
    /**
     * isSalleReserved : Récupére tous les ouvrages ayant les chaines de caractéres données en paramétres (isbn, titre, genre, théme)    
     *
     * @param  mixed $id_salle
     * @param  mixed $dateTimeReserv
     * @param  mixed $dateTimeFin
     * @return void
     */
    function isSalleReserved($id_salle, $dateTimeReserv, $dateTimeFin) {
        GLOBAL $conn;
        try {
            $query = $conn->prepare("SELECT COUNT(*) FROM reserver
            WHERE id_salle=?
            AND (
            ('$dateTimeReserv'<=dateTimeReserv AND '$dateTimeFin'>dateTimeReserv)
            OR
            ('$dateTimeReserv'<=dateTimeReserv AND '$dateTimeFin'>=dateTimeFin)
            OR
            ('$dateTimeReserv'>=dateTimeReserv AND '$dateTimeFin'<=dateTimeFin)
            OR
            ('$dateTimeReserv'<dateTimeFin AND '$dateTimeFin'>=dateTimeFin)
            )
            ");
            $query->execute(array($id_salle));
            $result = $query->fetch();
            
            return $result;
        } catch (PDOException $e) {
            echo $e->getMessage();
        }
    }


    
    /**
     * reserverSalle : Reserver une salle pour un créneau donné   
     *
     * @param  mixed $idUser
     * @param  mixed $id_salle
     * @param  mixed $dateTimeReserv
     * @param  mixed $dateTimeFin
     * @return void
     */
    function reserverSalle($idUser, $id_salle, $dateTimeReserv, $dateTimeFin) {
        GLOBAL $conn;
        try {
            $query = $conn->prepare("INSERT INTO reserver(id_adh,id_salle,dateTimeReserv,dateTimeFin) VALUES (?,?,?,?)");
            $query->execute(array($idUser,$id_salle,$dateTimeReserv,$dateTimeFin));
            
            return $query;
        } catch (PDOException $e) {
            echo $e->getMessage();
        }
    }
?>
