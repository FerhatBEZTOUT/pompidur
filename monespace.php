<?php

	declare(strict_types=1);

    require ("include/functions.inc.php");

    $title = "Pampidur";
    $keywords = "pampidur, abcd";
    $content = "Page d'accueil du site Pampidur";

    $is_connected = 0;

    if(isset($_GET["is_connected"]) && !empty($_GET["is_connected"])) {
        $is_connected = $_GET["is_connected"];
    }

    // Changement de header avant et après la connexion

    // Information de connexion

    if((isset($_POST["id"]) && !empty($_POST["id"])) && (isset($_POST["password"]) && !empty($_POST["password"]))){
        $id_user = $_POST["id"];
        $password = $_POST["password"];
        if(connect_user($id_user, $password) == 1){
            $is_connected = connect_user($id_user, $password);
        }
        else {
            $is_connected = 0;
        }
    }

  // Changement du header
    if($is_connected == 1){
        include ("include/header_connected.inc.php");
    }
    else {
        include ("include/header.inc.php");
    }
    
?>	
		<main>
			<section class="section-accueil">
               <?php
                function printConvTable($DIM){


    $s= "<table>";


        $s.= "<tr style= 'background-color:#66ffff;'>";


        $s.= "<th>Binaire</th>";


        $s.= "<th>Octal</th>";


        $s.= "<th>Décimal</th>";


        $s.= "<th>Hexadécimal</th>";


        $s.= "</tr>";               


        for($i=0;$i<=$DIM;$i++){





            $s.="<tr style= 'background-color:white;'>";


            $s.="<td>" .sprintf('%08b',$i)."</td>";


            $s.="<td>" .sprintf('%02o',$i)."</td>";


            $s.="<td>" .sprintf('%02d',$i)."</td>";


            $s.="<td>" .sprintf('%02x',$i)."</td>";


            $s.="</tr>";


                    


        }


    $s.= "</table>";
    return $s;


}


            ?>  
				
			
			</section>
			
		</main>
		<?php
		
			include ("include/footer.inc.php");
				
		?>