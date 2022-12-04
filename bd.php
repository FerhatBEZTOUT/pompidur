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
            <h1 aria-label="breadcrumb" class="titre bg-light rounded-3 p-3 mb-4">Tables de la BD</h1>
        </div>
    </div>
    <?php   if (isset($_GET['table'])) { ?>
    <div class="row my-2">
        <div class="col">
            <h3 aria-label="breadcrumb" class="titre bg-light rounded-3 p-3 mb-4">Table :<?= htmlentities($_GET['table']) ?> </h3>
        </div>
    </div>
    <?php
    }
    ?>
    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
        <symbol id="check-circle-fill" viewBox="0 0 16 16">
            <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z" />
        </symbol>

        <symbol id="exclamation-triangle-fill" viewBox="0 0 16 16">
            <path d="M8.982 1.566a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566zM8 5c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5zm.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2z" />
        </symbol>

    </svg>
    <form action="" method="GET" name="search-table">

        <div class="row mb-3">
            <div class="col-12 col-md-6  mb-1">
                <select class="form-select" aria-label="Default select example" name="table">
                    <option selected value="0">Séléctionnez une table</option>
                    <?php
                    include_once __DIR__ . '/Requetes/table.php';

                    $list_table = getTables();

                    if ($list_table) {

                        foreach ($list_table as $table) {
                            echo '<option value="' . $table->table_name . '">' . $table->table_name . '</option>
                            ';
                        }
                    } else {
                        echo '<div class="alert alert-danger d-flex align-items-center" role="alert">
                        <svg class="bi flex-shrink-0 me-2" role="img" aria-label="Danger:"><use xlink:href="#exclamation-triangle-fill"/></svg>
                        <div>
                         Aucune table trouvée
                        </div>
                      </div>';
                    }
                    ?>

                </select>
            </div>

            <div class="col-12 col-md-6  mb-1">

                <div class="input-group mb-3">
                    <span class="input-group-text" id="basic-addon1">Nombre maximum de lignes</span>
                    <input class="form-control" type="number" name="limit" id="limit" value="20" aria-describedby="basic-addon1">
                </div>
            </div>



        </div>

        <div class="row mx-auto d-flex justify-content-center">
            <input type="submit" class="btn btn-primary col-6 col-sm-3" value="Voir" name="search">
        </div>

    </form>

</div>


<?php
if (isset($_GET['table']) && isset($_GET['limit'])) {
    if (empty($_GET['table']) || $_GET['table'] == '0' || empty($_GET['limit'])) {
        echo '<div class="alert alert-danger d-flex align-items-center" role="alert">
                        <svg class="bi flex-shrink-0 me-2" role="img" aria-label="Danger:"><use xlink:href="#exclamation-triangle-fill"/></svg>
                        <div>
                         Aucune table selectionnée
                        </div>
                      </div>';
    } else {
        $selected_table = selectAllFromTable(htmlentities($_GET['table']), htmlentities($_GET['limit']));

        if ($selected_table) {
            echo '<div class="container">
                <table class="table table-responsive table-striped  ">
                <thead>
                    <tr>';
            $colonnes = getColonnesOfTable(htmlentities($_GET['table']));
            
                foreach ($selected_table[0] as $key => $value)
                    echo '<th scope="col">' . $key . '</th>';
            


            echo '</tr>
                </thead>
                <tbody>';

                foreach ($selected_table as $table) {
                    echo '<tr>';
                    foreach ($table as $key =>$value) {
                        echo '<td>' . $value. '</td>';
                    }
                    echo '</tr>';
                }



            echo '</tbody>
             </table>
             
             </div>';
        } else {
            echo '<div class="alert alert-danger d-flex align-items-center" role="alert">
                        <svg class="bi flex-shrink-0 me-2" role="img" aria-label="Danger:"><use xlink:href="#exclamation-triangle-fill"/></svg>
                        <div>
                         Erreur lors de la récupération de la table
                        </div>
                      </div>';
        }
    }
} else {
    echo '<div class="alert alert-danger d-flex align-items-center" role="alert">
                        <svg class="bi flex-shrink-0 me-2" role="img" aria-label="Danger:"><use xlink:href="#exclamation-triangle-fill"/></svg>
                        <div>
                         Veuillez choisir une table et le nombre maximum de ligne à afficher
                        </div>
                      </div>';
}


?>


<?php
include_once __DIR__ . '/View/footer_index.php';

?>