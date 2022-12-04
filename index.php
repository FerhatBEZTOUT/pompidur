<?php 
$titre = "Pampidur";
include_once __DIR__.'/View/header_index.php';

?>


    <h1 class="titre">Bienvenue sur le site du Centre Pampidur</h1>
    <div class="row d-flex justify-content-center align-items-center">
            <div class="col-sm-10 col-md-4 d-none d-md-block">
                <a href="https://storyset.com/book">
                    <img src="./IMG/Thesis-pana.svg" alt="Fille travaillant sur un ordinateur">
                </a>
            </div>
            <div class="col-sm-12 col-md-6 row">
                <div class="col-12 px-2">
                    <p>Le centre Pampidur est ouvert à tout public. Trouvez les livres que vous cherchez grâce à cette application et venez les récupérer au centre Pampidur.</p>
                </div>
                <div class="col-12 px-2">
                    <p>Connectez-vous et profitez des salles  mises à votre disposition pour vos projets, meetings ou pour réviser en groupe tranquillement.</p>
                </div>
                <div class="col-12 px-2 text-center py-3">
                <a href="connexion.php"><button class="btn btn-primary my-2 mx-3" >Connexion</button></a><a href="inscription.php"><button class="btn btn-outline-primary">Je n'ai pas de compte</button></a>

                </div>
            </div>
           
            
        
    </div>

    

    



    <?php
    include_once __DIR__.'/View/footer_index.php';
    ?>