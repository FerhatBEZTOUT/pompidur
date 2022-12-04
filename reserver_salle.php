<?php
if (!session_id()) {
  session_start();
}

$set = true;


if (isset($_GET['id_salle']) && isset($_GET['datedebut']) && isset($_GET['datefin']) && isset($_GET['heuredebut']) && isset($_GET['heurefin'])) {

  if (empty($_GET['id_salle']) || empty($_GET['datedebut']) || empty($_GET['datefin']) || empty($_GET['heuredebut']) || empty($_GET['heurefin'])) {
    $set = false;
  } else {

    $id_salle = htmlentities($_GET['id_salle']);
    $_GET['id_salle'] = $id_salle;
    $dateDebut = htmlentities($_GET['datedebut']);
    $dateFin = htmlentities($_GET['datefin']);
    $heureDebut = htmlentities($_GET['heuredebut']);
    $heureFin = htmlentities($_GET['heurefin']);

    $dateTimeReserv = $dateDebut . ' ' . $heureDebut;
    $dateTimeFin = $dateFin . ' ' . $heureFin;
    $set = true;
  }
} else {
  $set = false;
}
$nom = $_SESSION['user']->nom_user;
$prenom = $_SESSION['user']->prenom_user;
$titre = "Mon espace - $nom $prenom";

include_once __DIR__ . '/Requetes/salle.php';
include_once __DIR__ . '/View/header_monespace.php';

?>

<div class="row">
  <div class="col">
    <h1 aria-label="breadcrumb" class="titre bg-light rounded-3 p-3 mb-4">Reservation de la salle : <?php if (isset($_GET['id_salle'])) echo $_GET['id_salle'] ?></h1>
  </div>
</div>


<form action="" method="GET" name="reserv-salle">

  <div class="row mb-3 px-4">
    <div class="col-lg-2"></div>
    <div class="row col-sm-12 col-lg-8">
      <div class="col-12 input-group">
        <span class="input-group-text" id="addon">ID Salle</span>
        <input class="form-control" type="text" id="id_salle" name="id_salle" readonly aria-label="id_salle" aria-describedby="addon" value="<?php if (isset($_GET['id_salle'])) echo $_GET['id_salle'] ?>">
      </div>
      <div class="col-12 col-md-6 col-lg-6 mb-1">
        <label for="datedebut">Date et heure début de reservation</label>
        <input class="form-control  d-inline-block" type="date" name="datedebut" id="datedebut">
        <input class="form-control d-inline-block" type="time" name="heuredebut" id="heuredebut">
      </div>

      <div class="col-12 col-md-6 col-lg-6 mb-1">
        <label for="datefin">Date et heure fin de reservation</label>
        <input class="form-control  d-inline-block" type="date" name="datefin" id="datefin">
        <input class="form-control  d-inline-block" type="time" name="heurefin" id="heurefin">
      </div>
    </div>
    <div class="col-lg-2"></div>

  </div>

  <div class="row mx-auto d-flex justify-content-center">
    <input type="submit" class="btn btn-primary col-6 col-sm-3" value="Reserver" name="reserver">
  </div>


</form>
<svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
  <symbol id="check-circle-fill" viewBox="0 0 16 16">
    <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z" />
  </symbol>

  <symbol id="exclamation-triangle-fill" viewBox="0 0 16 16">
    <path d="M8.982 1.566a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566zM8 5c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5zm.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2z" />
  </symbol>

</svg>

<div class="container mt-3">


<?php
if ($set) {
  if ($dateTimeReserv < $dateTimeFin) {
    $reservee = isSalleReserved($id_salle, $dateTimeReserv, $dateTimeFin);
    
    if (!$reservee['count']) {
      $inserted = reserverSalle($_SESSION['user']->id_user, $id_salle, $dateTimeReserv, $dateTimeFin);
      
      if ($inserted) {
        echo '<div class="alert alert-success d-flex align-items-center" role="alert">
              <svg class="bi flex-shrink-0 me-2" role="img" aria-label="Success:"><use xlink:href="#check-circle-fill"/></svg>
              <div>
                La salle a été reservée !
              </div>
            </div>';
      } else {
        echo '<div class="alert alert-danger d-flex align-items-center" role="alert">
              <svg class="bi flex-shrink-0 me-2" role="img" aria-label="Danger:"><use xlink:href="#exclamation-triangle-fill"/></svg>
              <div>
               Une erreur lors de la reservation. Réessayez
              </div>
            </div>';
      }
    } else {
      echo '<div class="alert alert-danger d-flex align-items-center" role="alert">
              <svg class="bi flex-shrink-0 me-2" role="img" aria-label="Danger:"><use xlink:href="#exclamation-triangle-fill"/></svg>
              <div>
               La salle n\'est pas disponible durant ce créneau
              </div>
            </div>';
    }
  } else {
    echo '<div class="alert alert-danger d-flex align-items-center" role="alert">
              <svg class="bi flex-shrink-0 me-2" role="img" aria-label="Danger:"><use xlink:href="#exclamation-triangle-fill"/></svg>
              <div>
               Date reservation doit être inférieur à date fin de réservation
              </div>
            </div>';
  }
} else {

  echo '<div class="alert alert-danger d-flex align-items-center" role="alert">
              <svg class="bi flex-shrink-0 me-2" role="img" aria-label="Danger:"><use xlink:href="#exclamation-triangle-fill"/></svg>
              <div>
               Vous devez remplir tous les champs
              </div>
            </div>';
}
?>
</div>
<?php


include_once __DIR__ . '/View/footer_index.php';

?>