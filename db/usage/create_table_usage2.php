<?php

require_once __DIR__ . '/../db_information.php';

$admin = $_POST['admin'];
$admin_pw = $_POST['admin_pw'];
if ($admin == db_admin && $admin_pw == db_admin_pw){

    $conn = new mysqli(db_servername, db_username, db_password, db_name);
    if ($conn->connect_error){
        die("Connection failed: " . $conn->connect_error);
    }
    echo "Connect to database successfully"."<br>";

    $sql = "SELECT account FROM marines";
    $current_account=$conn->query($sql);
    if($current_account->num_rows > 0){

        $sql = "DROP TABLE marines";
        if($conn->query($sql) === TRUE){
            echo "Drop table successfully"."<br>";
        }else{
            echo "Drop table failed"."<br>";
        }


        $sql = "CREATE TABLE marines (
        account VARCHAR(30) PRIMARY KEY DEFAULT '',
        name VARCHAR(30) NOT NULL DEFAULT '',
        password VARCHAR(30) NOT NULL DEFAULT '',
        status VARCHAR(10) NOT NULL DEFAULT '',
        reason TEXT DEFAULT '',
        last_4_id VARCHAR(10) NOT NULL DEFAULT '',
        submit_time VARCHAR(30) NOT NULL DEFAULT ''
        )";

        if($conn->query($sql) === TRUE){
            echo "Table marines created successfully"."<br>";
        }else{
            echo "Error creating table: "."<br>" . $conn->error;
        }

        $sql = "INSERT INTO marines (account) VALUES ($current_account->fetch_object()->account)" ;

        if ($conn->query($sql) === TRUE) {
          echo "New records created successfully";
        } else {
          echo "Error: " . $sql . "<br>" . $conn->error;
        }

        $conn->close();

    }else{
        echo "Failed, 0 result";
    }
}else{
    echo "Login Failed";
}

?>

