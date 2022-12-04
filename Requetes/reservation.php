<?php
    include_once __DIR__.'/../Model/connexionBD.php';    

    
    /**
     * getReservationByCarte : récupére les reservations d'un adhérent en utilisant son numéro de carte
     *
     * @param  mixed $id_carte
     * @param  mixed $date_reserv
     * @return void
     */
    function getReservationsByCarte($id_carte,$date_reserv) {
        GLOBAL $conn;
        try {
            $requete = "SELECT U.nom_user,U.prenom_user,R.* FROM reserver R 
            JOIN adherent A ON R.id_adh=A.id_adh
            JOIN utilisateur U ON A.id_adh=U.id_user
            WHERE A.id_adh=(SELECT id_user FROM carte WHERE id_carte=$id_carte)";

            if ($date_reserv) {
                $requete = $requete." AND datetimereserv>='$date_reserv' AND datetimereserv<'$date_reserv'::DATE + INTERVAL '1 day'";
            }
            $query = $conn->prepare($requete);
            $query->execute();
            $result = $query->fetchAll(PDO::FETCH_OBJ);
            return $result;

        } catch (PDOException $e) {
            echo $e->getMessage();
        }
    }


    function deleteReservation($idSalle, $idAdh, $date_reserv) {
        GLOBAL $conn;
        try {
            $query = $conn->prepare("DELETE FROM reserver WHERE id_salle='$idSalle' AND id_adh=$idAdh AND datetimereserv>='$date_reserv' AND datetimereserv<'$date_reserv'::DATE + INTERVAL '1 day'");
            return $query->execute();
    
        } catch (PDOException $e) {
            echo $e->getMessage();
        }
    }
    
?>