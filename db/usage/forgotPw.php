<?php

require_once __DIR__ . '/../db_information.php';

$conn = new mysqli(db_servername, db_username, db_password, db_name);
if ($conn->connect_error){
    die("Connection failed: " . $conn->connect_error);
}

$account = $_POST['account_'];
$last_4_id = $_POST['last_4_id_'];

$sql ="SELECT * FROM marines WHERE account = '$account'";
$result = $conn->query($sql);

if($result->num_rows > 0){
    $sql ="SELECT last_4_id FROM marines WHERE account = '$account'";
    $result = $conn->query($sql)->fetch_object()->last_4_id;

    if ($result == ""){
        echo "not registered yet";
    }else{
        $sql ="SELECT password FROM marines WHERE account = '$account' AND last_4_id = '$last_4_id'";
        $result = $conn->query($sql)->fetch_object()->password;

        if ($result == ""){
            echo "last_4_id wrong";
        }else{
            echo $result;
        }
    }  
}else{
    echo "account not exist";
}

$conn->close();
?>
