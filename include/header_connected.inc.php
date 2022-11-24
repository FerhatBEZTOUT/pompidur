<?php


if((isset($_GET["nom"]) && !empty($_GET["nom"])) && (isset($_GET["prenom"]) && !empty($_GET["prenom"]))){
	$name = array();
	$name[0] = $_GET["nom"];
	$name[1] = $_GET["prenom"];
}	

if(isset($_GET["t_user"]) && !empty($_GET["t_user"])){
	$t_user = $_GET["t_user"];
	// 1 : employe, 2: adherant
	if(strcmp($t_user, "employe") === 0){
		$nav_part = "<li><a href=\"dashboard.php?nom=".$name[0]."&prenom=".$name[1]."&t_user=employe\"><img src=\"img/info.png\" alt=\"interface employé\" /></a></li>";
	}
	else if (strcmp($t_user, "adherent") === 0){
		$nav_part = "<li><a href=\"monespace.php?nom=".$name[0]."&prenom=".$name[1]."&t_user=adherent\"><img src=\"img/info.png\" alt=\"Logo du site\" /></a></li>";
	}

}



?>


<!DOCTYPE html>
<html lang="fr">
	<head>
		<!-- métadonnées de la page -->
		<meta charset="utf-8" />
		<meta name="author" content="MADOUR Melissa & ZETOUT Ferhat" />
		<meta name="date" content="2022-11-21T17:38:22+0100" />
		<meta name="contenu" content="<?php echo $content; ?>" />
		<meta name="keywords" content="<?php echo $keywords; ?>" />
		<title><?php echo $title; ?></title>
		<!-- Liaison avec la feuille de style -->
		<link rel="stylesheet" href="style/styles.css" />
		<link rel="icon" href="img/Logo_site.png" />
	</head>
	<body class="body">
		<header>
			<a href="index.php"><img src="img/Logo_site.png" alt="Logo du site" /></a>
			<!-- <h1><a href="index.php">bu pampidur</a></h1> -->
			<p style="margin:auto;">vous etes actuellement connecté autant qu'<?php echo $t_user;?> du site Pampidur.</p>
		</header>
		<aside>
			<ul>
				<li><a href="index.php<?php echo "?nom=".$name[0]."&prenom=".$name[0]."&t_user=".$t_user ?>"><img src="img/menu.png" alt="Accueil" /></a></li>
				<li><a href="connexion.php<?php echo "?nom=".$name[0]."&prenom=".$name[0]."&t_user=".$t_user ?>"><img src="img/deconnexion.png" alt="Déconnexion" /></a></li>
				<li><?php echo initiales($name[0], $name[1]);?></li>
				<?php echo $nav_part;?>
			</ul>
		</aside>