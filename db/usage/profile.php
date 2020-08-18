<?php

require_once __DIR__ . '/../db_information.php';

$conn = new mysqli(db_servername, db_username, db_password, db_name);
if ($conn->connect_error){
    die("Connection failed: " . $conn->connect_error);
}

$account = $_POST['account_'];
$pw = $_POST['pw_'];

$sql = "SELECT name FROM marines WHERE account = '$account' AND BINARY password = '$pw'";
$result = $conn->query($sql)->fetch_object();

$resultArray = array();
array_push($resultArray,$result);

echo json_encode($resultArray);

$conn->close();
?>
