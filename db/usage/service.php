<?php

require_once __DIR__ . '/../db_information.php';

$conn = new mysqli(db_servername, db_username, db_password, db_name);
if ($conn->connect_error){
    die("Connection failed: " . $conn->connect_error);
}

$account = $_POST['account_'];
$authority = $_POST['authority_'];
$location = $_POST['location_'];
$alter = $_POST['alter_'];

if ($authority == 'A' || $authority == 'a'){
    $sql = "SELECT * FROM marines";
}
if ($authority == 'B' || $authority == 'b'){
    $sql = "SELECT * FROM marines WHERE account LIKE '$location%'";
}
if ($authority == 'C' || $authority == 'c'){
    if ($alter == '0'){
        $sql = "SELECT * FROM marines WHERE account LIKE '$location%'";
    }
    if ($alter == '1'){
        $sql = "SELECT * FROM marines WHERE account LIKE CONCAT('$location','$authority','1','%')";
    }
    if ($alter == '2'){
        $sql = "SELECT * FROM marines WHERE account LIKE CONCAT('$location','$authority','2','%')";
    }
}
if ($authority == 'D' || $authority == 'd'){
    $sql = "SELECT * FROM marines WHERE account = '$account'";
}
//$sql = "SELECT * FROM marines WHERE account LIKE 'A%'";
if($result = $conn->query($sql)){
    $resultArray = array();
    $tempArray = array();
    while($row = $result->fetch_object()){
        $tempArray = $row;
        array_push($resultArray,$tempArray);
    }
    echo json_encode($resultArray);
}
$conn->close();
?>
