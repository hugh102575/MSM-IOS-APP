<?php
$requustType = $_SERVER['REQUEST_METHOD'];

if ($requustType == 'GET'){
    die("Prohibit From Direct Access");
}
else if ($requustType == 'POST'){
    define('db_servername' , 'localhost');
    define('db_username' , 'u506682066_msm_user');
    define('db_password' , 'katcud-Cydwa4-dohzab');
    define('db_name' , 'u506682066_msm');

    define('db_admin','danny102575@gmail.com');
    define('db_admin_pw','Qazwsxqwe!');
}
?>