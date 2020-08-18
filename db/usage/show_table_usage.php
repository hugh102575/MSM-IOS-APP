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

	$sql = "SELECT * FROM marines";
	$result = $conn->query($sql);
	$display_pw = False;
	if ($result->num_rows > 0) {
	  // output data of each row
	  while($row = $result->fetch_assoc()) {
	    if ($display_pw == False){
	        echo $row["account"].'&nbsp'.
	        //$row["position"].'&nbsp'.
	        $row["name"].'&nbsp'.
	        $row["status"].'&nbsp'.
	        $row["reason"].'&nbsp'.
	        $row["submit_time"].'<br>';
	    }else{
	        echo $row["account"].'&nbsp'.
	        //$row["position"].'&nbsp'.
	        $row["name"].'&nbsp'.
	        $row["password"].'&nbsp'.
	        $row["status"].'&nbsp'.
	        $row["reason"].'&nbsp'.
	        $row["last_4_id"].'&nbsp'.
	        $row["submit_time"].'<br>';
	    }
	  }
	}else{
  		echo "0 results";
	}
	$conn->close();
}else{
    echo "Login Failed";
}
?>