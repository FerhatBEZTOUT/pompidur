<?php

$username = "user=pampidur";
$password = "password=Ma3dnous!!";
$host = "host=postgresql-pampidur.alwaysdata.net";
$database = "dbname=pampidur_bdd";
$port = "port=5432";

$con_string = "$host  $port $database $username $password";
$connect = pg_connect($con_string);
if (!$connect) {
    echo "Error : Unable to open database\n";
  }

$result = pg_query($connect, "SELECT * from utilisateur where email_user='jenna@gmail.com'");
if (!$result) {
  echo "Une erreur s'est produite.\n";
  exit;
}

var_dump(pg_fetch_all($result));
/*while ($row = pg_fetch_row($result)) {
  echo "id_adh: $row[0]\n";
}*/

?>
