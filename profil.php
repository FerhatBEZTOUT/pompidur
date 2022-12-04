<?php
   if(!session_id()) {
    session_start();
}
$nom = $_SESSION['user']->nom_user;
$prenom = $_SESSION['user']->prenom_user;
$titre = "Mon espace - $nom $prenom";
$url_photo = $_SESSION['user']->photo_user;

$num_tel = $_SESSION['user']->tel_user;
$email_user = $_SESSION['user']->email_user;
$addr = $_SESSION['user']->rue_user.' '. $_SESSION['user']->code_post_user.' '. $_SESSION['user']->ville_user;
include_once __DIR__.'/Requetes/ouvrage.php';
include_once __DIR__.'/View/header_monespace.php';
?>

<section style="background-color: #eee;">
  <div class="container py-5">
    <div class="row">
      <div class="col">
        <h1 aria-label="breadcrumb" class="titre bg-light rounded-3 p-3 mb-4">Mon profil</h1>
      </div>
    </div>

    <div class="row">
      <div class="col-lg-4">
        <div class="card mb-4">
          <div class="card-body text-center">
            <img src="<?= $url_photo ?>" alt="avatar"
              class="rounded-circle img-fluid" style="width: 150px;">
            <h5 class="my-3"><?= $nom.' '.$prenom?></h5>
           
            <div class="d-flex justify-content-center mb-2">
              
              
            </div>
          </div>
        </div>
        
      </div>
      <div class="col-lg-8">
        <div class="card mb-4">
          <div class="card-body">
            <div class="row">
              <div class="col-sm-3">
                <p class="mb-0">Nom</p>
              </div>
              <div class="col-sm-9">
                <p class="text-muted mb-0"><?=$nom?></p>
              </div>
            </div>
            <hr>
            <div class="row">
              <div class="col-sm-3">
                <p class="mb-0">Prénom</p>
              </div>
              <div class="col-sm-9">
                <p class="text-muted mb-0"><?=$prenom?></p>
              </div>
            </div>
            <hr>
            <div class="row">
              <div class="col-sm-3">
                <p class="mb-0">Email</p>
              </div>
              <div class="col-sm-9">
                <p class="text-muted mb-0"><?=$email_user?></p>
              </div>
            </div>
            <hr>
            <div class="row">
              <div class="col-sm-3">
                <p class="mb-0">Téléphone</p>
              </div>
              <div class="col-sm-9">
                <p class="text-muted mb-0"><?=$num_tel?></p>
              </div>
            </div>
            <hr>
            <div class="row">
              <div class="col-sm-3">
                <p class="mb-0">Adresse</p>
              </div>
              <div class="col-sm-9">
                <p class="text-muted mb-0"><?=$addr ?></p>
              </div>
            </div>
          </div>
        </div>
        
      </div>
    </div>
  </div>
</section>




<?php

include_once __DIR__.'/View/footer_index.php'; 

?>