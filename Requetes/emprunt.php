<?php
include_once __DIR__.'/../Model/connexionBD.php';


/**
 * recupererEmprunts : récupére les exemplaires empruntés par un adherent à une date donnée
 *
 * @param  mixed $idCarte : carte de l'utilisateur
 * @param  mixed $isbn : id d'un ouvrage
 * @param  mixed $dateEmp date d'emprunt d'un ouvrage
 * @return void
 */
function recupererEmprunts($idCarte,$isbn,$dateEmp) {
    GLOBAL $conn;
    try {
        $requetesql = "SELECT O.isbn_ouv, U.nom_user, U.prenom_user, O.titre_ouv, EM.id_exemp, EM.id_adh, EM.date_emp, EM.dateretour 
        FROM empreinter EM 
        JOIN exemplaire EX ON EM.id_exemp=EX.id_exemp 
        JOIN ouvrage O ON O.isbn_ouv=EX.isbn_ouv 
        JOIN utilisateur U ON U.id_user=EM.id_adh 
        WHERE EM.id_adh=(SELECT id_user FROM carte WHERE id_carte=$idCarte) 
        AND O.isbn_ouv LIKE '%$isbn%'";


        if ($dateEmp) 
            $requetesql=$requetesql." AND EM.date_emp = '$dateEmp'";
        else 
            $requetesql=$requetesql." ORDER BY EM.date_emp DESC";

        $query = $conn->prepare($requetesql);

       
        $query->execute();
        $result = $query->fetchAll(PDO::FETCH_OBJ);
        return $result;
        

    } catch (PDOException $e) {
        echo $e->getMessage();
    }
}



/**
 * deleteEmprunt : Supprime un emprunt dans la table "empreinter"
 *
 * @param  mixed $idExemp
 * @param  mixed $idAdh
 * @param  mixed $dateEmp
 * @return void
 */
function deleteEmprunt($idExemp, $idAdh, $dateEmp) {
    GLOBAL $conn;
    try {
        $query = $conn->prepare("DELETE FROM empreinter WHERE id_exemp=$idExemp AND id_adh=$idAdh AND date_emp='$dateEmp'");
        return $query->execute();

    } catch (PDOException $e) {
        echo $e->getMessage();
    }
}



/**
 * RetourOuvrage : Met à jour la date de retour d'un ouvrage
 *
 * @param  mixed $idExemp
 * @param  mixed $idAdh
 * @param  mixed $dateEmp
 * @return void
 */
function RetourOuvrage($idExemp, $idAdh, $dateEmp) {
    GLOBAL $conn;
    try {
        $dateretour = date("Y-m-d");
        $query = $conn->prepare("UPDATE empreinter SET dateretour='$dateretour' 
        WHERE id_exemp=$idExemp 
        AND id_adh=$idAdh 
        AND date_emp='$dateEmp'");
        return $query->execute();

    } catch (PDOException $e) {
        echo $e->getMessage();
    }

}
?>