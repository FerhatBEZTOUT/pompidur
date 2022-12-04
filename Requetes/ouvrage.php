<?php
    include_once __DIR__.'/../Model/connexionBD.php';

    
    /**
     * getRandBooks : Récupére d'ouvrages aléatoires 
     *
     * @param  mixed $limit : nombre maximum d'ouvrages
     * @return void
     */
    function getRandBooks($limit) {
        GLOBAL $conn;
        try {
            $query = $conn->prepare("SELECT isbn_ouv, image_ouv FROM ouvrage ORDER BY random() LIMIT ?");
            $query->execute(array($limit));
            $result = $query->fetchAll(PDO::FETCH_OBJ);
            return $result;
            

        } catch (PDOException $e) {
            echo $e->getMessage();
        }
    }


    /**
     * recupererOuvrageByFiltre : Récupére tous les ouvrages ayant les chaines de caractéres données en paramétres (isbn, titre, genre, théme)    
     *
     * @param  mixed $isbn
     * @param  mixed $titreouv
     * @param  mixed $genreouv
     * @param  mixed $themeouv
     * @return void
     */
    function recupererOuvrageByFiltre($isbn, $titreouv, $genreouv, $themeouv) {
        GLOBAL $conn;
        try {
            $query = $conn->prepare("SELECT isbn_ouv, titre_ouv, genre_ouv, theme_ouv FROM ouvrage WHERE isbn_ouv LIKE '%$isbn%' AND titre_ouv LIKE '%$titreouv%' AND genre_ouv LIKE '%$genreouv%' AND theme_ouv LIKE '%$themeouv%'");
            $query->execute();
            $result = $query->fetchAll(PDO::FETCH_OBJ);
            
            return $result;
        } catch (PDOException $e) {
            echo $e->getMessage();
        }
    }


    /**
     * getFirstExemplaireDispo : Récupére un exemplaire dispo (ou null si aucun exemplaire est dispo)    
     *
     * @param  mixed $isbn
     * @return void
     */
    function getFirstExemplaireDispo($isbn) {
        GLOBAL $conn;
        try {
            $query = $conn->prepare("SELECT id_exemp FROM exemplaire E
            JOIN ouvrage O ON O.isbn_ouv=E.isbn_ouv
            WHERE O.isbn_ouv=?
            EXCEPT(
            SELECT DISTINCT EX.id_exemp FROM exemplaire EX
                        JOIN empreinter EM ON EX.id_exemp=EM.id_exemp
                        JOIN ouvrage O ON O.isbn_ouv=EX.isbn_ouv
                        WHERE O.isbn_ouv=?
                        AND EM.dateretour IS NULL ) LIMIT 1");
            $query->execute(array($isbn,$isbn));
            $result = $query->fetch(PDO::FETCH_OBJ);
            
            return $result;
        } catch (PDOException $e) {
            echo $e->getMessage();
        }
    }

    
   
    /**
     * empreinterOuv : Ajoute l'exemplaire emprunté dans la BD pour un utilisateur donné  
     *
     * @param  mixed $id_user
     * @param  mixed $id_exemp
     * @return void
     */
    function empreinterOuv($id_user,$id_exemp){
        GLOBAL $conn;
        try {
            $query = $conn->prepare("INSERT INTO empreinter(id_adh,id_exemp,date_emp,dateretourprevue) VALUES (?,?,CURRENT_DATE,CURRENT_DATE + INTERVAL'15 day')");
            return $query->execute(array($id_user,$id_exemp));
            
        } catch (PDOException $e) {
            echo $e->getMessage();
        }
    }
?>




