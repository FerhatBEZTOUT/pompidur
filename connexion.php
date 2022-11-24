<?php

	declare(strict_types=1);

	include ("include/functions.inc.php");
	
	$title = "Pampidur";
	$keywords = "Pampidur, abcd";
	$content = "Page de connexion du site Pampidur ";


	$formulaire = "<h2 class=\"h2-accueil\">Connexion</h2>
				<fieldset class=\"fieldset-connexion\">
					<form action=\"\" method=\"post\" class=\"fieldset-form\">
						<div class=\"form-div\">
							<label>email : </label>
							<input type=\"text\" name=\"email\" size=\"20\" placeholder=\"email, Ex : mel@mail.com\" autofocus=\"true\" required/>
						</div>
						<div class=\"form-div\">
							<label>Mot de passe : </label>
							<input type=\"password\" name=\"password\" size=\"10\" placeholder=\"Mot de passe...\" required/>
						</div>					
						<input type=\"submit\" value=\"Connexion\" />
					</form>
				</fieldset>";
	
	 if((isset($_POST["password"]) && !empty($_POST["password"])) && (isset($_POST["email"]) && !empty($_POST["email"]))){
        $id = $_POST["email"];
        $password = $_POST["password"];

        if(connect_user($id, $password)){
        	$name = get_name_user($id);
        	$formulaire = "<h2 class=\"h2-accueil\">Connecté</h2>
        					<p class=\"p-details\">Bienvenue, ".$name[0]." ".$name[1]."</p>";
        	include ("include/header_connected.inc.php");
        }
    	else {
	        $error = "<p class=\"p-details\">Mot de passe ou identifiant incorrect !!</p>";
	        $formulaire .= $error;
	        include ("include/header.inc.php");
	    }
    }
    else {
    	include ("include/header.inc.php");
    }
	
?>
		
		<main>
			<section class="section-accueil">
				<?php echo $formulaire; ?>
			</section>
		</main>
		<?php
		
			include ("include/footer.inc.php");
				
		?>