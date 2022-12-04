<?php
if (!session_id()) {
  session_start();
}
$_SESSION['user']->nom_user =ucfirst($_SESSION['user']->nom_user);
$_SESSION['user']->prenom_user =ucfirst($_SESSION['user']->prenom_user);
$nom = $_SESSION['user']->nom_user;
$prenom = $_SESSION['user']->prenom_user;
$titre = "Mon espace - $nom $prenom";

include_once __DIR__ . '/Requetes/ouvrage.php';
include_once __DIR__ . '/View/header_monespace.php';

?>

<section class="container ">
  <div class="row">
    <div class="col">
      <h1 aria-label="breadcrumb" class="titre bg-light rounded-3 p-3 mb-4">Bienvenue <?= $prenom ?></h1>
      <p class="text-center">Une petite suggestion d'ouvrages tirés aléatoirement pour vous</p>
    </div>
  </div>

  <div id="carouselExampleCaptions" class="carousel slide" data-bs-ride="false">
    <div class="carousel-indicators">
      <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
      <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1" aria-label="Slide 2"></button>
      <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2" aria-label="Slide 3"></button>
    </div>
    <div class="carousel-inner mx-auto my-3" style="width: 40%; max-height:80%;   ">

      <?php
      $listBook = getRandBooks(3);
      for ($i = 0; $i < count($listBook); $i++) {
        $url = $listBook[$i]->image_ouv;
        $isbn_ouv = $listBook[$i]->isbn_ouv;
        if ($i == 0) {
          echo '<div class="carousel-reserv-show carousel-item active">
        
            <a href="reserver_ouv.php?isbn=' . $isbn_ouv . '"><img src="' . $url . '" class="d-block w-100" alt="..."> </a>
        
            <div class="carousel-caption d-none d-md-block">
            <a href="reserver_ouv.php?isbn=' . $isbn_ouv . '">
            <h5 class="btn-reserv btn btn-outline-dark">Reserver</h5>
            </a>
        </div>
          </div>';
        } else {
          echo '<div class="carousel-reserv-show carousel-item">
        
            <a href="reserver_ouv.php?isbn=' . $isbn_ouv . '"><img src="' . $url . '" class="d-block w-100" alt="..."> </a>
        
            <div class="carousel-caption d-none d-md-block">
            <a href="reserver_ouv.php?isbn=' . $isbn_ouv . '">
            <h5 class="btn-reserv btn btn-outline-dark">Reserver</h5>
            </a>
        </div>
          </div>';
        }
      }












      ?>
    </div>
    <button class="carousel-control-prev" style="background-color: rgba(36, 31, 31, 0.807);" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
      <span class="carousel-control-prev-icon" aria-hidden="true" fill="%23c593d8"></span>
      <span class="visually-hidden">Previous</span>
    </button>
    <button class="carousel-control-next" type="button" style="background-color: rgba(36, 31, 31, 0.807);" data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
      <span class="carousel-control-next-icon" aria-hidden="true" fill="#000000"></span>
      <span class="visually-hidden">Next</span>
    </button>
  </div>
  <a href="reserver.php?="></a>
</section>

<?php
include_once __DIR__ . '/View/footer_index.php';

?>