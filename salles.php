<?php
   if(!session_id()) {
    session_start();
}
$nom = $_SESSION['user']->nom_user;
$prenom = $_SESSION['user']->prenom_user;
$titre = "Mon espace - $nom $prenom";

include_once __DIR__.'/Requetes/salle.php';
include_once __DIR__.'/View/header_monespace.php';
?>

<div class="row">
    <div class="col">
      <h1 aria-label="breadcrumb" class="titre bg-light rounded-3 p-3 mb-4">Salles existantes</h1>
    </div>
  </div>

<?php
    $list_Salle = getSalles();
echo '
        
    <div class="container">
        <table class="table table-responsive table-striped  ">
        <thead>
          <tr>
            <th scope="col">Nom salle</th>
            <th scope="col">Batiment</th>
            <th scope="col">Etage</th>
            <th scope="col">Action</th>
          </tr>
        </thead>
        <tbody>';
          
        foreach ($list_Salle as $salle) {
            echo '<tr>
            <th scope="row">'.$salle->nom_salle.'</th>
            <td>'.$salle->batiment_salle.'</td>
            <td>'.$salle->etage_salle.'</td>
           
            <td><a href="reserver_salle.php?id_salle='.$salle->id_salle.'"  target="_blank"><button class="btn btn-outline-primary">Reserver</button></a></td>
          </tr>';
        }
          
       echo '</tbody>
         </table>
         
         </div>';

?>





<?php

include_once __DIR__.'/View/footer_index.php'; 

?>