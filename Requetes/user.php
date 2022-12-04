<?php
    include_once __DIR__.'/../Model/connexionBD.php';

        
    /**
     * getUserByEmail
     * Fonction qui permet de récupérer les données d'un utilisateur selon un email
     * @param  mixed $email (ex:jenna@gmail.com)
     * @return void
     */
    function getUserByEmail($email) {
        GLOBAL $conn;
        try {
            $query = $conn->prepare("SELECT U.*,A.pseudo_adh FROM utilisateur U JOIN adherent A ON U.id_user=A.id_adh WHERE U.email_user=?");    // Préparation de la requête (Point d'intérogation = paramétre)
            $query->execute(array($email));       // Passage des paramétres sous forme de tableau
            $result = $query->fetch(PDO::FETCH_OBJ);
            if($result) {     // Parcours du résultat et stockage dans une variable sous forme d'objet (FETCH_OBJ)
                $result->user_type='adh';
            } else {
                $query = $conn->prepare("SELECT U.*,E.roleemp,E.droit_acces,E.salaire FROM utilisateur U JOIN employe E ON U.id_user=E.id_emp WHERE U.email_user=?");
                $query->execute(array($email));  
                $result = $query->fetch(PDO::FETCH_OBJ);   
                $result->user_type='emp';
                
            };        
            
            return $result;             // Retourne l'objet ou NULL si rien n'a été trouvé
        } catch (PDOException $e){
            echo $e->getMessage();
        }
    }

    



   
?>