<?php
    if(!session_id()) {
        session_start();
      }

      
    include_once __DIR__.'/../Controller/redirect.php';
     
    redirectFromMonEspace();
?>

<!-- Début Header -->
<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-3.6.1.min.js"
        integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <link rel="stylesheet" href="./CSS/index.css">
    <link rel="shortcut icon" href="../IMG/diamond.ico" type="image/x-icon">
    <script src="//code.jquery.com/jquery-1.12.4.js"></script>
    <script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <title>
        <?= $titre?>
    </title>
</head>

<body class="vh-100" style="display:flex;
    min-height:100vh;
    flex-direction: column;">
    <!-- Navbar -->
    <div class="container-fluid px-5 bg-light mon-bg">
    <nav class="navbar navbar-expand-sm navbar-light bg-light nav" aria-label="Third navbar example">
        <a class="navbar-brand logo" href="../">
            <img src="../IMG/pampidur_logo.png" width="35" height="35" class="d-inline-block align-top" alt="logo"/>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarsExample03" aria-controls="navbarsExample03" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>

        <div class="navbar-collapse collapse" id="navbarsExample03">
            <ul class="navbar-nav me-auto mb-2 mb-sm-0 ">
            
            <li class="nav-item">
                <a class="nav-link menuNav" href="../ouvrages.php">Ouvrages</a>
                
            </li>

            <li class="nav-item">
                <a class="nav-link menuNav" href="../salles.php">Salles</a>
                
            </li>

            <li class="nav-item">
                <a class="nav-link menuNav" href="../profil.php">Mon profil</a>
                
            </li>
            
            </ul>
            
            <a class="nav-link deconnect d-inline-block" href="..\Controller\deconnexion.php">
                    Deconnexion <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-box-arrow-right" viewBox="0 0 16 16">
                    <path fill-rule="evenodd" d="M10 12.5a.5.5 0 0 1-.5.5h-8a.5.5 0 0 1-.5-.5v-9a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 .5.5v2a.5.5 0 0 0 1 0v-2A1.5 1.5 0 0 0 9.5 2h-8A1.5 1.5 0 0 0 0 3.5v9A1.5 1.5 0 0 0 1.5 14h8a1.5 1.5 0 0 0 1.5-1.5v-2a.5.5 0 0 0-1 0v2z"/>
                    <path fill-rule="evenodd" d="M15.854 8.354a.5.5 0 0 0 0-.708l-3-3a.5.5 0 0 0-.708.708L14.293 7.5H5.5a.5.5 0 0 0 0 1h8.793l-2.147 2.146a.5.5 0 0 0 .708.708l3-3z"/>
                </svg></a>
        </div>
        
    </nav>

</div>
    <!-- Fin Header -->