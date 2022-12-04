<?php
       if(!session_id()) {
        session_start();
    }
    $nom = $_SESSION['user']->nom_user;
    $prenom = $_SESSION['user']->prenom_user;
    $titre = "Dashboard - $nom $prenom";
    include_once __DIR__.'/View/header_dashboard.php';
?>


<div class="row">
        <div class="col">
            <h1 aria-label="breadcrumb" class="titre bg-light rounded-3 p-3 mb-4">Annulation de reservation d'une salle</h1>
        </div>
    </div>
<?php

if (isset($_GET['idSalle']) && isset($_GET['idAdh']) && isset($_GET['datereserv'])) {
    if(empty($_GET['idSalle']) || empty($_GET['idAdh']) || empty($_GET['datereserv'])) {
      echo '<div class="alert alert-danger d-flex align-items-center" role="alert">
                <svg class="bi flex-shrink-0 me-2" role="img" aria-label="Danger:"><use xlink:href="#exclamation-triangle-fill"/></svg>
                <div>
                    Une ou plusieurs de ces valeurs est manquante : ID Salle ou ID Adherent ou Date de reservation
                </div>
              </div>';
    } else {
      $idSalle = htmlentities($_GET['idSalle']);
      $idAdh = htmlentities($_GET['idAdh']);
      $dateReserv = htmlentities($_GET['datereserv']);
      
      include_once __DIR__ . '/Requetes/reservation.php';
        $deleted = deleteReservation($idSalle,$idAdh,$dateReserv);
        
        if ($deleted) {
          
              echo '<div class="alert alert-success d-flex align-items-center" role="alert">
              <svg class="bi flex-shrink-0 me-2" role="img" aria-label="Success:"><use xlink:href="#check-circle-fill"/></svg>
              <div>
                Reservation annulée 
              </div>
            </div>';
            
  
        } else {
          echo '<div class="alert alert-danger d-flex align-items-center" role="alert">
                <svg class="bi flex-shrink-0 me-2" role="img" aria-label="Danger:"><use xlink:href="#exclamation-triangle-fill"/></svg>
                <div>
                 Erreur lors de la suprression
                </div>
              </div>';
        }
    }
  
  } else {
    echo '<div class="alert alert-danger d-flex align-items-center" role="alert">
                <svg class="bi flex-shrink-0 me-2" role="img" aria-label="Danger:"><use xlink:href="#exclamation-triangle-fill"/></svg>
                <div>
                 Vous devez fournir "ID Salle" et "ID Adherent" et "Date de reservation".
                </div>
              </div>';
  }
  ?>



<?php
   include_once __DIR__.'/View/footer_index.php'; 

?>