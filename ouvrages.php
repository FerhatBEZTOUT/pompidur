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

<div class="container mb-2">
<div class="row">
    <div class="col">
      <h1 aria-label="breadcrumb" class="titre bg-light rounded-3 p-3 mb-4">Recherche d'ouvrages</h1>
    </div>
  </div>
    <form action="ouvrages.php" method="POST" name="search-ouv">

        <div class="row mb-3">
            <div class="col-12 col-md-6 col-lg-3 mb-1">
            <input class="form-control col-sm-12 col-md-6 col-3 mx-1 d-inline-block" type="text" name="search-isbn" id="search-isbn" placeholder="ISBN">

            </div>

            <div class="col-12 col-md-6 col-lg-3 mb-1">
            <input  class="form-control col-sm-12 col-md-6 col-3 mx-1 d-inline-block" type="text" name="search-titre" id="search-titre" placeholder="Titre">

            </div>

            <div class="ccol-12 col-md-6 col-lg-3 mb-1">
            <input  class="form-control col-sm-12 col-md-6 col-3 mx-1 d-inline-block" type="text" name="search-genre" id="search-genre" placeholder="Genre">

            </div>

            <div class="col-12 col-md-6 col-lg-3 mb-1">
            <input class="form-control col-sm-12 col-md-6 col-3 mx-1 d-inline-block" type="text" name="search-theme" id="search-theme" placeholder="Théme">

            </div>
        </div>

        <div class="row mx-auto d-flex justify-content-center">
            <input type="submit" class="btn btn-primary col-6 col-sm-3" value="Rechercher" name="search">
        </div>
       

        
        

        
    </form>
  
</div>


<?php
     
    if (!isset($_POST['search-ouv'])) {
        if(empty($_POST['search-isbn']) && empty($_POST['search-titre']) && empty($_POST['search-genre']) && empty($_POST['search-theme']))
        echo '<h2 class="titre">Entrez les critéres de recherches</h2>';
        else {
        $isbn = htmlentities($_POST['search-isbn']);
        $titreouv = htmlentities($_POST['search-titre']);
        $genreouv = htmlentities($_POST['search-genre']);
        $themeouv = htmlentities($_POST['search-theme']);

        $list_ouv = recupererOuvrageByFiltre($isbn,$titreouv,$genreouv,$themeouv);
        
        
        echo '
        
    <div class="container">
        <table class="table table-responsive table-striped  ">
        <thead>
          <tr>
            <th scope="col">ISBN</th>
            <th scope="col">Titre</th>
            <th scope="col">Genre</th>
            <th scope="col">Théme</th>
            <th scope="col">Action</th>
          </tr>
        </thead>
        <tbody>';
          
        foreach ($list_ouv as $ouv) {
            echo '<tr>
            <th scope="row">'.$ouv->isbn_ouv.'</th>
            <td>'.$ouv->titre_ouv.'</td>
            <td>'.$ouv->genre_ouv.'</td>
            <td>'.$ouv->theme_ouv.'</td>
            <td><a href="reserver_ouv.php?isbn='.$ouv->isbn_ouv.'"  target="_blank"><button class="btn btn-outline-primary">Reserver</button></a></td>
          </tr>';
        }
          
       echo '</tbody>
         </table>
         
         </div>';
    
    }
}

?>

<?php
include_once __DIR__.'/View/footer_index.php'; 
?>




