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

        
    $sql = "INSERT INTO marines (account)
    VALUES
            ('AA001'), #校長室
            ('AA002'),
            ('AA003'),
            ('AA004'),

            ('AA005'), #士官督導長室
            ('AD001'),

            ('BA001'),   #學員生事務處
            ('BB001'),
            ('BB002'),
            ('BB003'),

            ('CA001'),   #總務處
            ('CB001'),
            ('CB002'),
            ('CB003'),
            ('CB004'),
            ('CB005'),
            ('CB006'),
            ('CB007'),
            ('CB008'),
            ('CB009'),
            ('CB010'),
            ('CB011'),
            ('CB012'),
            ('CB013'),

            ('DA001'),   #教務處
            ('DB001'),
            ('DB002'),
            ('DB003'),
            ('DB004'),
            ('DB005'),
            ('DB006'),
            ('DB007'),
            ('DB008'),
            ('DB009'),
            ('DB010'),
            ('DB011'),
            ('DB012'),
            ('DB013'),
            ('DB014'),
            ('DB015'),
            ('DB016'),

            ('EA001'),   #資訊模擬中心
            ('EB001'),
            ('EB002'),
            ('EB003'),
            ('EB004'),
            ('EB005'),
            ('EB006'),
        
            ('FA001'), #主計室
            ('FB001'),
            ('FB002'),
            ('FB003'),
            ('FB004'),

            ('GA001'), #醫務所
            ('GB001'),
            ('GB002'),
            ('GB003'),
            ('GB004'),
            ('GB005'),
            ('GB006'),
            ('GB007'),
            ('GB008'),
            ('GB009'),
            ('GB010'),

            ('HA001'),    #總教官室

            ('IA001'), #兩棲戰術組
            ('IB001'),
            ('IB002'),
            ('IB003'),
            ('IB004'),

            ('JA001'), #小部隊組
            ('JB001'),
            ('JB002'),
            ('JB003'),
            ('JB004'),
            ('JB005'),
            ('JB006'),
            ('JB007'),
            ('JB008'),

            ('KA001'), #通識教學組
            ('KB001'),
            ('KB002'),
            ('KB003'),
            ('KB004'),
            ('KB005'),

            ('LA001'),    #學員生總隊部
            ('LC001'),
            ('LD001'),

            ('LC101'),  #學員生一大隊
            ('LC102'),
            ('LC103'),
            ('LC111'),    #第一中隊
            ('LC112'),
            ('LC113'),
            ('LC114'),   #第二中隊
            ('LC115'),
            ('LC116'),
            ('LC117'),
            ('LC118'),
            ('LC119'),
            ('LC120'),
            ('LC121'),
            ('LC122'), #第三中隊
            ('LC123'),
            ('LC124'),
            ('LC125'),
            ('LC126'),
            ('LC127'),
            ('LC128'),
            ('LC129'),
            ('LC130'), #第四中隊
            ('LC131'),
            ('LC132'),
            ('LC133'),
            ('LC134'),
            ('LC135'),
            ('LC136'),
            ('LC137'),

            ('LC201'), #學員生二大隊
            ('LC202'),
            ('LC203'),
            ('LC211'), #第五中隊
            ('LC212'),
            ('LC213'),
            ('LC214'),
            ('LC215'),
            ('LC216'),
            ('LC217'),
            ('LC218'),
            ('LC219'),
            ('LC220'),
            ('LC221'), #第六中隊
            ('LC222'),
            ('LC223'),
            ('LC224'),
            ('LC225'),
            ('LC226'),
            ('LC227'),
            ('LC228'),
            ('LC229'),
            ('LC230'),
            ('LC231'),    #第七中隊
            ('LC232'),
            ('LC233'),
            ('LC234'),
            ('LC235'),
            ('LC236'),
            ('LC237'),
            ('LC238'),
            ('LC239'),
            ('LC240'),
            ('LC241'), #第八中隊
            ('LC242'),
            ('LC243'),
            ('LC244'),
            ('LC245'),
            ('LC246'),
            ('LC247'),
            ('LC248'),
            ('LC249'),
            ('LC250'),

            ('MB001'),  #莒拳隊
            ('MB002'),
            ('MB003'),
            ('MB004'),
            ('MB005'),
            ('MB006'),
            ('MB007'),
            ('MB008'),
            ('MB009'),
            ('MB010'),
            ('MB011'),
            ('MB012'),

            ('NB001'),  #勤務隊
            ('NB002'),
            ('NB003'),
            ('NB004'), #支援班
            ('NB005'),
            ('NB006'),
            ('NB007'),
            ('NB008'),
            ('NB009'),
            ('NB010'),
            ('NB011'),
            ('NB012'), #警衛班
            ('NB013'),
            ('NB014'),
            ('NB015'),
            ('NB016'),
            ('NB017'),
            ('NB018'),
            ('NB019'),
            ('NB020'),
            ('NB021'),
            ('NB022'),
            ('NB023'),
            ('NB024'), #修護運輸班
            ('NB025'),
            ('NB026'),
            ('NB027'),
            ('NB028'),
            ('NB029'),
            ('NB030'),
            ('NB031'),
            ('NB032'),
            ('NB033')
    ";
        
    if ($conn->query($sql) === TRUE) {
      echo "New records created successfully";
    } else {
      echo "Error: " . $sql . "<br>" . $conn->error;
    }
        
    $conn->close();
}else{
    echo "Login Failed";
}
?>

