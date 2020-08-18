<?php

require_once __DIR__ . '/../db_information.php';

$conn = new mysqli(db_servername, db_username, db_password, db_name);
if ($conn->connect_error){
    die("Connection failed: " . $conn->connect_error);
}

$account = $_POST['account_'];
$pw = $_POST['pw_'];
$status = $_POST['status_'];
$reason = $_POST['reason_'];
$submit_time = $_POST['submit_time_'];



$sql = "UPDATE marines SET status = '$status', reason = '$reason', submit_time = '$submit_time' WHERE account = '$account' AND BINARY password = '$pw'";
    
if ($conn->query($sql) === TRUE){
    echo "today submit successfully";
}else{
    echo "Error: " . $sql . "<br>" . $conn->error;
}
 
$conn->close();
?>
