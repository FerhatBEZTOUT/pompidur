<?php
    if(!session_id()) {
        session_start();
      }
    include_once __DIR__.'/../Controller/redirect.php';
    
    redirectFromLanding();
?>

<!-- Début Header -->
<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <link rel="stylesheet" href="./CSS/index.css">
    <link rel="shortcut icon" href="../IMG/diamond.ico" type="image/x-icon">
    <script src="//code.jquery.com/jquery-1.12.4.js"></script>
  <script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <title><?= $titre?></title>
</head>

<body class="vh-100" style="display:flex;
    min-height:100vh;
    flex-direction: column;">
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light nav">
        <a class="navbar-brand d-flex mx-auto justify-content-center logo" href="../"><img src="../IMG/pampidur_logo.png" alt="Logo" style="width: 13%;"></a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse px-4" id="navbarNavAltMarkup">
            <div class="navbar-nav ">
                <a class="nav-item nav-link" href="../connexion.php">Connexion</a>
                <a class="nav-item nav-link" href="../inscription.php">Inscription</a>
                
                <a class="nav-item nav-link" href="../about-us.php">Qui sommes nous</a>
                
            </div>
        </div>
    </nav>
<!-- Fin Header -->
    