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
            <h1 aria-label="breadcrumb" class="titre bg-light rounded-3 p-3 mb-4">Retour d'un ouvrage</h1>
        </div>
    </div>
<?php

if (isset($_GET['idExemp']) && isset($_GET['idAdh']) && isset($_GET['dateEmpr'])) {
    if(empty($_GET['idExemp']) || empty($_GET['idAdh']) || empty($_GET['dateEmpr'])) {
      echo '<div class="alert alert-danger d-flex align-items-center" role="alert">
                <svg class="bi flex-shrink-0 me-2" role="img" aria-label="Danger:"><use xlink:href="#exclamation-triangle-fill"/></svg>
                <div>
                    Une ou plusieurs de ces valeurs est manquante :ID exemplaire ou ID Adherent ou Date d\'emprunt 
                </div>
              </div>';
    } else {
      $idExemp = htmlentities($_GET['idExemp']);
      $idAdh = htmlentities($_GET['idAdh']);
      $dateEmp = htmlentities($_GET['dateEmpr']);
     
      include_once __DIR__ . '/Requetes/emprunt.php';
        $retour = RetourOuvrage($idExemp,$idAdh,$dateEmp);
        
        if ($retour) {
          
              echo '<div class="alert alert-success d-flex align-items-center" role="alert">
              <svg class="bi flex-shrink-0 me-2" role="img" aria-label="Success:"><use xlink:href="#check-circle-fill"/></svg>
              <div>
                    La date retour a bien été enregistrée !
              </div>
            </div>';
            
  
        } else {
          echo '<div class="alert alert-danger d-flex align-items-center" role="alert">
                <svg class="bi flex-shrink-0 me-2" role="img" aria-label="Danger:"><use xlink:href="#exclamation-triangle-fill"/></svg>
                <div>
                    Erreur lors de l\'enregistrement ...
                </div>
              </div>';
        }
    }
  
  } else {
    echo '<div class="alert alert-danger d-flex align-items-center" role="alert">
                <svg class="bi flex-shrink-0 me-2" role="img" aria-label="Danger:"><use xlink:href="#exclamation-triangle-fill"/></svg>
                <div>
                 Vous devez fournir "ID exemplaire" , "ID adhérent" et "Date d\'emprunt".
                </div>
              </div>';
  }
  ?>

<?php
   include_once __DIR__.'/View/footer_index.php'; 

?>