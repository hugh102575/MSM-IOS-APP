<?php

require_once __DIR__ . '/../db_information.php';

$admin = $_POST['admin'];
$admin_pw = $_POST['admin_pw'];
$account = $_POST['account'];
if ($admin == db_admin && $admin_pw == db_admin_pw)
    $conn = new mysqli(db_servername, db_username, db_password, db_name);
    if ($conn->connect_error){
        die("Connection failed: " . $conn->connect_error);
    }
    echo "Connect to database successfully"."<br>";

    $sql ="SELECT * FROM marines WHERE account = '$account'";
    $result = $conn->query($sql);

    if($result->num_rows > 0){
        $sql = "UPDATE marines SET name = '', password = '', status = '',reason = '', last_4_id = '',submit_time = '' WHERE account = '$account'";

        if ($conn->query($sql) === TRUE){
            echo "1 record clean successfully";
        }else{
            echo "Error: " . $sql . "<br>" . $conn->error;
        }
        
    }else{
        echo "account not exist";
    }
    
    $conn->close();
?>
