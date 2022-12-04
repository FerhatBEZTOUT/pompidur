<?php
    include_once __DIR__.'/../Model/connexionBD.php';

      
    /**
     * getTables : Récupére le nom des tables d'une base de données à partir du schéma de cette BD
     *
     * @return void
     */
    function getTables(){
        GLOBAL $conn;
        try {
            $query = $conn->prepare("SELECT table_name FROM information_schema.tables WHERE table_schema='public'");
            $query->execute();
            $result = $query->fetchAll(PDO::FETCH_OBJ);
            return $result;

        } catch (PDOException $e) {
            echo $e->getMessage();
        }

    }

    
    /**
     * getNombreColonneTable : Récupére le nombre de colonnes d'une table
     *
     * @param  mixed $table
     * @return void
     */
    function getNombreColonneTable($table) {
        GLOBAL $conn;
        try {
            $query = $conn->prepare("SELECT COUNT(*)
            FROM information_schema.tables
            WHERE table_name = '$table'");
            $query->execute();
            $result = $query->fetch();
            return $result;

        } catch (PDOException $e) {
            echo $e->getMessage();
        }


        
    }

    
    /**
     * selectAllFromTable : Récupére toutes les colonnes d'une table avec un nombre limité ($limit) de lignes
     *
     * @param  mixed $table
     * @param  mixed $limit
     * @return void
     */
    function selectAllFromTable($table,$limit) {
        GLOBAL $conn;
        try {
            $query = $conn->prepare("SELECT * FROM $table LIMIT $limit");
            $query->execute();
            $result = $query->fetchAll(PDO::FETCH_ASSOC);
            return $result;

        } catch (PDOException $e) {
            echo $e->getMessage();
        }
    }




        
    /**
     * getColonnesOfTable : Récupére le nom des colonnes d'une table
     *
     * @param  mixed $table
     * @return void
     */
    function getColonnesOfTable($table) {
        GLOBAL $conn;
        try {
            
            $query = $conn->prepare("SELECT column_name FROM information_schema.columns WHERE table_name = '$table'");
            $query->execute();
            $result = $query->fetchAll(PDO::FETCH_ASSOC);
            return $result;

        } catch (PDOException $e) {
            echo $e->getMessage();
        }
    }


?>