<?php



if(isset($_POST['image'])){
    
    $host = 'postgresql-pampidur.alwaysdata.net';
    $dbname = 'pampidur_test';
    $user = 'pampidur';
    $password = 'Ma3dnous!!';

    try {
        // objet PDO qui permet de faire des requete vers la BD
        $conn = new PDO('pgsql:host='. $host.';dbname='.$dbname.'',$user,$password);
        
    } catch (PDOException $e) {
        echo '<h1>Impossible de se connecter à la BDD : '.$e->getMessage().'</h1>';
        die();
    }

    $filename = $_POST['image'];
    $img = fopen($filename,'r') OR die("cannot read image\n");
    $data = fread($img,filesize($filename));
    $es_data = pg_escape_bytea($data);
    fclose($img);
    $query = $conn->prepare("INSERT INTO images VALUES (?,?)");
    $query->execute(array(1,$es_data));
    


}
    

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    
<form action="" method="POST">
    <input type="file" name="image" id="image">
</form>

</body>
</html>