<?php

require_once __DIR__ . '/../db_information.php';

$conn = new mysqli(db_servername, db_username, db_password, db_name);
if ($conn->connect_error){
    die("Connection failed: " . $conn->connect_error);
}

$account = $_POST['account_'];
$pw = $_POST['pw_'];
$login_mode = $_POST['login_mode_'];

if ($login_mode == "account"){
    $sql ="SELECT * FROM marines WHERE account = '$account'";
    $result = $conn->query($sql);

    if($result->num_rows > 0){
        $sql_ ="SELECT password FROM marines WHERE account = '$account'";
        $result_ = $conn->query($sql_)->fetch_object()->password;
        
        if($result_ == ""){
            echo "new account";
        }else{
            echo "already registered";
        }
        
    }else{
        echo "account not exist";
    }
}
if ($login_mode == "account_pw"){
    $sql ="SELECT * FROM marines WHERE account = '$account'";
    $result = $conn->query($sql);

    if($result->num_rows > 0){
        $sql_ ="SELECT password FROM marines WHERE account = '$account'";
        $result_ = $conn->query($sql_)->fetch_object()->password;
        
        if($result_ == ""){
            echo "new account 2";
        }else{
            $sql ="SELECT * FROM marines WHERE account = '$account' AND BINARY password = '$pw'";
            $result = $conn->query($sql);
            if($result->num_rows > 0){
                echo "login successed";
            }else{
                echo "password not exist";
            }
        }
    }else{
        echo "account not exist 2";
    }
}
 
$conn->close();
?>
