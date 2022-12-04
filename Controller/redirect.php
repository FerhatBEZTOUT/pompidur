<?php


function redirectFromLanding(){
    if(isset($_SESSION['connecté'])) {
        if($_SESSION['user_type']=='emp') {
            header('location:../dashboard.php');
        } else {
            header('location:../monespace.php');
        }
        die();
    }
}


function redirectFromMonEspace(){
    if(isset($_SESSION['connecté'])) {
        if($_SESSION['user_type']=='emp') {
            header('location:../dashboard.php');
            die();
        }
        
    } else {
        header('location:../connexion.php');
    }
}


function redirectFromDashboard(){
    if(isset($_SESSION['connecté'])) {
        if($_SESSION['user_type']=='adh') {
            header('location:../monespace.php');
            die();
        }
        
    } else {
        header('location:../connexion.php');
    }
}

?>