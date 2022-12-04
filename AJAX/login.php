<?php

if(isset($_POST['email']) && isset($_POST['mdp'])) {

    if(empty($_POST['email']) || empty($_POST['mdp'])) {
      echo 'EMPTY';
        
    } 
    else {
      $email = htmlentities($_POST['email']);
      $mdp = htmlentities($_POST['mdp']);

      include_once __DIR__.'/../Requetes/user.php';
      
      $user = getUserByEmail($email);   // User == FALSE la fonction n'a trouvé aucun email
      
      if ($user) {
          if (password_verify($mdp,$user->mdp_user)) {
            if(!session_id()) {
              session_start();
            }
            $_SESSION['connecté']=1;
            $_SESSION['user']=$user;
            if($user->user_type=='emp') {
              $_SESSION['user_type']='emp';
              echo 'emp';
            } else {
              $_SESSION['user_type']='adh';
              echo 'adh';
            }
          }
      } 
      else {
          echo 'NOT FOUND';
      }
      
    }
  } 
  else {
    echo 'NOT SET';
  }

?>