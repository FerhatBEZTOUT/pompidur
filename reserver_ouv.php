<?php
    if(!session_id()) {
      session_start();
  }
  $nom = $_SESSION['user']->nom_user;
  $prenom = $_SESSION['user']->prenom_user;
  $titre = "Mon espace - $nom $prenom";

  include_once __DIR__.'/Requetes/ouvrage.php';
  include_once __DIR__.'/View/header_monespace.php';
?>

<div class="row">
    <div class="col">
      <h1 aria-label="breadcrumb" class="titre bg-light rounded-3 p-3 mb-4">Ouvrage - Emprunt</h1>
    </div>
  </div>
  <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
  <symbol id="check-circle-fill" viewBox="0 0 16 16">
    <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z" />
  </symbol>

  <symbol id="exclamation-triangle-fill" viewBox="0 0 16 16">
    <path d="M8.982 1.566a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566zM8 5c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5zm.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2z" />
  </symbol>

</svg>

<?php

if (isset($_GET['isbn'])) {
  if(empty($_GET['isbn'])) {
    echo '<div class="alert alert-danger d-flex align-items-center" role="alert">
              <svg class="bi flex-shrink-0 me-2" role="img" aria-label="Danger:"><use xlink:href="#exclamation-triangle-fill"/></svg>
              <div>
               ISBN vide
              </div>
            </div>';
  } else {
    $isbn = htmlentities($_GET['isbn']);
      $exemplaire = getFirstExemplaireDispo($isbn);
      
      if ($exemplaire) {
        $id_exemp = $exemplaire->id_exemp; 
          $empreint = empreinterOuv($_SESSION['user']->id_user,$id_exemp);
          if ($empreint) {
            echo '<div class="alert alert-success d-flex align-items-center" role="alert">
            <svg class="bi flex-shrink-0 me-2" role="img" aria-label="Success:"><use xlink:href="#check-circle-fill"/></svg>
            <div>
              Ouvrage ajouté à vos empreints ! Venez le récupérer au centre Pampidur
            </div>
          </div>';
          } else {
            echo '<div class="alert alert-danger d-flex align-items-center" role="alert">
            <svg class="bi flex-shrink-0 me-2" role="img" aria-label="Danger:"><use xlink:href="#exclamation-triangle-fill"/></svg>
            <div>
             Erreur lors de l\'enregistrement de votre empreint
            </div>
          </div>';
          }

      } else {
        echo '<div class="alert alert-danger d-flex align-items-center" role="alert">
              <svg class="bi flex-shrink-0 me-2" role="img" aria-label="Danger:"><use xlink:href="#exclamation-triangle-fill"/></svg>
              <div>
               Il n\'y a malheureusement plus d\'exemplaire disponibles pour cet ouvrage. Merci de revenir plus tard.
              </div>
            </div>';
      }
  }

} else {
  echo '<div class="alert alert-danger d-flex align-items-center" role="alert">
              <svg class="bi flex-shrink-0 me-2" role="img" aria-label="Danger:"><use xlink:href="#exclamation-triangle-fill"/></svg>
              <div>
               Vous devez fournir un ISBN
              </div>
            </div>';
}
?>




<?php

include_once __DIR__.'/View/footer_index.php'; 

?>