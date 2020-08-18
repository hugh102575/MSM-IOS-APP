<?php

require_once __DIR__ . '/../db_information.php';

$conn = new mysqli(db_servername, db_username, db_password, db_name);
if ($conn->connect_error){
    die("Connection failed: " . $conn->connect_error);
}

$account = $_POST['account_'];
$new_pw = $_POST['new_pw_'];
$old_pw = $_POST['old_pw_'];


$sql = "UPDATE marines SET password = '$new_pw' WHERE account = '$account' AND BINARY password = '$old_pw'";
    
if ($conn->query($sql) === TRUE){
    echo "Change password successfully";
}else{
    echo "Error: " . $sql . "<br>" . $conn->error;
}
 
$conn->close();
?>