<?php
if (!session_id()) {
    session_start();
}
$_SESSION['user']->nom_user = ucfirst($_SESSION['user']->nom_user);
$_SESSION['user']->prenom_user = ucfirst($_SESSION['user']->prenom_user);
$nom = $_SESSION['user']->nom_user;
$prenom = $_SESSION['user']->prenom_user;
$titre = "Dashboard - $nom $prenom";
include_once __DIR__ . '/View/header_dashboard.php';
?>

<div class="container mb-2">
    <div class="row d-flex justify-content-evenly  p-5">
        <div class="col-12 col-lg-4 mb-2">
            <div class="card" style="width: 15rem;">
                <a href="./empreints.php">
                    <img src="./IMG/book.png" class="card-img-top" alt="...">
                </a>

                <div class="card-body">
                    <h5 class="card-title">Ouvrages empruntés</h5>
                    <div class="d-flex justify-content-around">

                        <a href="./empreints.php">
                            <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" fill="rgb(202, 54, 8)" class="bi bi-pencil-square pointer" viewBox="0 0 16 16">
                                <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z" />
                                <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z" />
                            </svg>
                        </a>


                    </div>


                </div>
            </div>
        </div>
        <div class="col-12 col-lg-4  mb-2">
            <div class="card" style="width: 15rem;">
                <a href="./reservations.php">
                    <img src="./IMG/salle.webp" class="card-img-top" alt="...">
                </a>

                <div class="card-body">
                    <h5 class="card-title">Salles reservées</h5>

                    <div class="d-flex justify-content-around">

                        <a href="./reservations.php">
                            <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" fill="rgb(202, 54, 8)" class="bi bi-pencil-square pointer" viewBox="0 0 16 16">
                                <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z" />
                                <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z" />
                            </svg>
                        </a>



                    </div>
                </div>
            </div>
        </div>

        <div class="col-12 col-lg-4 mb-2">
            <div class="card" style="width: 15rem;">
                <a href="./bd.php">
                    <img src="./IMG/database.png" class="card-img-top" alt="...">
                </a>

                <div class="card-body">
                    <h5 class="card-title">Tables</h5>

                    <div class="d-flex justify-content-around">
                        <a href="./bd.php">
                            <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" fill="rgb(20, 105, 184)" class="bi bi-eye-fill pointer" viewBox="0 0 16 16">
                                <path d="M10.5 8a2.5 2.5 0 1 1-5 0 2.5 2.5 0 0 1 5 0z" />
                                <path d="M0 8s3-5.5 8-5.5S16 8 16 8s-3 5.5-8 5.5S0 8 0 8zm8 3.5a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7z" />
                            </svg>
                        </a>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<?php
include_once __DIR__ . '/View/footer_index.php';

?>