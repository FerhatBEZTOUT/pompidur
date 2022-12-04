<?php
if (!session_id()) {
    session_start();
}
$nom = $_SESSION['user']->nom_user;
$prenom = $_SESSION['user']->prenom_user;
$titre = "Dashboard - $nom $prenom";
include_once __DIR__ . '/View/header_dashboard.php';
?>

<div class="container mb-2">
    <div class="row">
        <div class="col">
            <h1 aria-label="breadcrumb" class="titre bg-light rounded-3 p-3 mb-4">Salles reservées</h1>
        </div>
    </div>
    <form action="" method="POST" name="search-ouv">

        <div class="row mb-3">
            <div class="col-12 col-lg-6  mb-1">
                <input class="form-control col-sm-12 col-md-6 col-3 mx-1 d-inline-block" type="text" name="search-carte" id="search-carte" placeholder="ID Carte">

            </div>
            <div class="col-12 col-lg-6  mb-1">
            <div class="input-group mb-3  ">
                <span class="input-group-text" id="basic-addon1">Date reservation</span>
                <input class="form-control" type="date" name="datereserv" id="datereserv" value="20" aria-describedby="basic-addon1">
            </div>
            </div>
            


        </div>

        <div class="row mx-auto d-flex justify-content-center">
            <input type="submit" class="btn btn-primary col-6 col-sm-3" value="Rechercher" name="search">
        </div>

    </form>

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

if (isset($_POST['search-carte'])) {
    if (empty($_POST['search-carte'])) {
        echo '<div class="alert alert-danger d-flex align-items-center" role="alert">
        <svg class="bi flex-shrink-0 me-2" role="img" aria-label="Danger:"><use xlink:href="#exclamation-triangle-fill"/></svg>
        <div>
         Vous devez au moins saisir un numéro de carte
        </div>
      </div>';
    } else {
        $idCarte = htmlentities($_POST['search-carte']);
        $datereserv = htmlentities($_POST['datereserv']);
        

        include_once __DIR__ . '/Requetes/reservation.php';
        $list_reserv = getReservationsByCarte($idCarte, $datereserv);
        if ($list_reserv) {
            $nom_user = ucfirst($list_reserv[0]->nom_user);
            $prenom_user = ucfirst($list_reserv[0]->prenom_user);
            $id_adh = ucfirst($list_reserv[0]->id_adh);
            echo '<div class="row">
            <div class="col">
              <h3 aria-label="breadcrumb" class="titre bg-light rounded-3 p-3 mb-4">Salles reservées par : ' . $nom_user . ' ' . $prenom_user . ' <span>(ID: ' . $id_adh . ')</span> </h3>
            </div>
          </div>';
            echo '
            
        <div class="container">
                
            <table class="table table-responsive table-striped  ">
            <thead>
              <tr>
                <th scope="col">ID Salle</th>
                <th scope="col">Date réservation</th>
                <th scope="col">Date fin réservation</th>
                <th scope="col">Date entrée</th>
                <th scope="col">Date sortie</th>
                <th scope="col">Action</th>
              </tr>
            </thead>
            <tbody>';

            foreach ($list_reserv as $reserv) {
                echo '<tr>
                <th scope="row">' . $reserv->id_salle . '</th>
                <td style="max-width:20rem;">' . $reserv->datetimereserv . '</td>
                <td>' . $reserv->datetimefin . '</td>
                <td>' . $reserv->datetimeentree . '</td>
                <td>' . $reserv->datetimesortie . '</td>';
        
                echo '
                <td>
                    <a href="del_reserv.php?idSalle=' . $reserv->id_salle . '&idAdh=' . $reserv->id_adh . '&datereserv=' . $reserv->datetimereserv . '"  target="_blank"><button class="btn btn-outline-danger">Annuler</button></a>
                    
                </td>
              </tr>';
            }

            echo '</tbody>
             </table>
             
             </div>';
        } else {
            echo '<div class="alert alert-danger d-flex align-items-center" role="alert">
            <svg class="bi flex-shrink-0 me-2" role="img" aria-label="Danger:"><use xlink:href="#exclamation-triangle-fill"/></svg>
            <div>
             Aucune salle n\'a été reservée pour cette date avec cette carte
            </div>
          </div>';
        }
    }
}

?>


<?php
include_once __DIR__ . '/View/footer_index.php';

?>