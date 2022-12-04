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

<div class="container">
    <h1 class="titre">MCD</h1>
    <img src="./IMG/MCD.png" alt="MCD" style="width: 100%;">
<hr>
<h1 class="titre">MLD</h1>
    <ul>
        <li>utilisateur (<b><u>id_user</u></b>, nom_user, prenom_user, date_naiss_user, email_user, mdp_user, photo_user, tel_user, rue_user, code_post_user, ville_user, hasfullaccess)</li>
        <li>adherent (<b><u>#id_adh</u></b>, pseudo_adh)</li>
        <li>employe (<b><u>#id_emp</u></b>, role, droit_acces, salaire)</li>
        <li>carte (<b><u>id_carte</u></b>, type_carte, date_exp, carte_active, #id_user)</li>
        <li>salle (<b><u>id_salle</u></b>, nom_salle, etage_salle, batiment_salle)</li>
        <li>materiel (<b><u>id_materiel</u></b>, type_materiel, date_achat, prix_mat, #id_salle)</li>
        <li>terminal (<b><u>id_terminal</u></b>, nom_terminal, actif, #id_salle)</li>
        <li>reserver (<b><u>#id_adh, #id_salle, dateTimeReserv</u></b>, dateTimeFin, dateTimeEntree, dateTimeSortie)</li>
        <li>editeur (<b><u>id_edit</u></b>, nom_edit, adr_edit, pays_edit)</li>
        <li>auteur (<b><u>id_aut</u></b>, nom_aut, prenom_aut, dateNaiss_aut, mvment_aut, email_aut, photo_aut)</li>
        <li>ouvrage (<b><u>ISBN_ouv</u></b>, titre_ouv, nbr_page_ouv, langue_ouv, image_ouv, date_parrution, prix_ouv, genre_ouv, theme_ouv, #id_edit)</li>
        <li>exemplaire (<b><u>id_exemp</u></b>, num_exemp, date_achat, #id_ouv)</li>
        <li>empreinter (<b><u>#id_adh, #id_exemp, date_emp</u></b>, dateRetourPrevue, dateRetour)</li>
        <li>ecrire (<b><u>#id_aut, #ISBN_ouv</u></b>)</li>
    </ul>
</div>



<?php
include_once __DIR__ . '/View/footer_index.php';

?>