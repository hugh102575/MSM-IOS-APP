<?php

require_once __DIR__ . '/../db_information.php';

$conn = new mysqli(db_servername, db_username, db_password, db_name);
if ($conn->connect_error){
    die("Connection failed: " . $conn->connect_error);
}

$account = $_POST['account_'];
$name = $_POST['name_'];
$pw = $_POST['pw_'];
$last_4_id = $_POST['last_4_id_'];

$sql = "UPDATE marines SET name = '$name', password = '$pw', last_4_id = '$last_4_id' WHERE account = '$account'";
    
if ($conn->query($sql) === TRUE){
    echo "New records created successfully";
}else{
    echo "Error: " . $sql . "<br>" . $conn->error;
}
 
$conn->close();
?>
