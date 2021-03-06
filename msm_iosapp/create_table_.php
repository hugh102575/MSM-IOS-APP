<?php

require_once 'db_information.php';

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
position VARCHAR(30) NOT NULL DEFAULT '',
name VARCHAR(30) NOT NULL DEFAULT '',
password VARCHAR(30) NOT NULL DEFAULT '',
status VARCHAR(10) NOT NULL DEFAULT '',
reason TEXT DEFAULT '',
last_4_id VARCHAR(10) NOT NULL DEFAULT ''
)";

if($conn->query($sql) === TRUE){
    echo "Table marines created successfully"."<br>";
}else{
    echo "Error creating table: "."<br>" . $conn->error;
}

    
$sql = "INSERT INTO marines (account, position)
VALUES
        ('AA001' , '少將校長'), #校長室
        ('AA002' , '上校教育長'),
        ('AA003' , '上校政戰主任'),
        ('AA004' , '少校監察官'),

        ('AA005' , '一等長士督長'), #士官督導長室
        ('AD001' , '上士行政士'),

        ('BA001' , '中校處長'),   #學員生事務處
        ('BB001' , '少校政戰官'),
        ('BB002' , '上尉心輔官'),
        ('BB003' , '上尉保防官'),

        ('CA001' , '中校處長'),   #總務處
        ('CB001' , '少校副處長'),
        ('CB002' , '中尉補給官'),
        ('CB003' , '中尉工程官'),
        ('CB004' , '三等長文書士'),
        ('CB005' , '一等長後勤士'),
        ('CB006' , '三等長兵修士'),
        ('CB007' , '上士人事士'),
        ('CB008' , '中士人事士'),
        ('CB009' , '中士文書士'),
        ('CB010' , '下士人事士'),
        ('CB011' , '上兵人事士'),
        ('CB012' , '雇二人事士'),
        ('CB013' , '雇二檔管員'),

        ('DA001' , '中校處長'),   #教務處
        ('DB001' , '少校副處長'),
        ('DB002' , '少校動官員'),
        ('DB003' , '少校作戰官'),
        ('DB004' , '中尉動員官'),
        ('DB005' , '中尉教育官'),
        ('DB006' , '三等長教育士'),
        ('DB007' , '一等長教育士'),
        ('DB008' , '一等長體育士'),
        ('DB009' , '上士情報士'),
        ('DB010' , '上士教育士'),
        ('DB011' , '中士教育士'),
        ('DB012' , '中士教育士'),
        ('DB013' , '中士體育士'),
        ('DB014' , '中士體育士'),
        ('DB015' , '下士體育士'),
        ('DB016' , '下士體育士'),

        ('EA001' , '中校主任'),   #資訊模擬中心
        ('EB001' , '少校資參官'),
        ('EB002' , '上尉教官'),
        ('EB003' , '中尉系統官'),
        ('EB004' , '上士通信士'),
        ('EB005' , '中士助教'),
        ('EB006' , '下士助教'),
    
        ('FA001' , '中校主任'), #主計室
        ('FB001' , '少校預財官'),
        ('FB002' , '上尉預財官'),
        ('FB003' , '上士預財官'),
        ('FB004' , '下士預財官'),

        ('GA001' , '少校主任'), #醫務所
        ('GB001' , '上尉醫官'),
        ('GB002' , '中尉醫官'),
        ('GB003' , '中尉醫官'),
        ('GB004' , '二等長醫務士'),
        ('GB005' , '上士醫務士'),
        ('GB006' , '中士醫務士'),
        ('GB007' , '中士醫務士'),
        ('GB008' , '下士醫務兵'),
        ('GB009' , '上兵醫務兵'),
        ('GB010' , '上兵醫務兵'),

        ('HA001' , '上校總教官'),    #總教官室

        ('IA001' , '中校組長'), #兩棲戰術組
        ('IB001' , '中校戰術教官'),
        ('IB002' , '中校情報教官'),
        ('IB003' , '中校砲兵教官'),
        ('IB004' , '上尉戰術教官'),

        ('JA001' , '上校組長'), #小部隊組
        ('JB001' , '中校戰術教官'),
        ('JB002' , '少校戰術教官'),
        ('JB003' , '二等長教官'),
        ('JB004' , '一等長教官'),
        ('JB005' , '一等長教官'),
        ('JB006' , '三等長教官'),
        ('JB007' , '一等長教官'),
        ('JB008' , '二等長教官'),

        ('KA001' , '中校組長'), #通識教學組
        ('KB001' , '中校政治教官'),
        ('KB002' , '少校體育教官'),
        ('KB003' , '少校政治教官'),
        ('KB004' , '少校後勤教官'),
        ('KB005' , '中尉教官'),

        ('LA001' , '上校總隊長'),    #學員生總隊部
        ('LC001' , '中校政戰處長'),
        ('LD001' , '中士行政士'),

        ('LC101' , '中校大隊長'),  #學員生一大隊
        ('LC102' , '少校輔導長'),
        ('LC103' , '中士行政士'),
        ('LC111' , '少校中隊長'),    #第一中隊
        ('LC112' , '中尉輔導長'),
        ('LC113' , '下士行政士'),
        ('LC114' , '一等長中隊長'),   #第二中隊
        ('LC115' , '三等長輔導長'),
        ('LC116' , '上士區隊長'),
        ('LC117' , '上士區隊長'),
        ('LC118' , '下士區隊長'),
        ('LC119' , '下士區隊長'),
        ('LC120' , '下士區隊長'),
        ('LC121' , '下士行政士'),
        ('LC122' , '一等長中隊長'), #第三中隊
        ('LC123' , '二等長輔導長'),
        ('LC124' , '上士區隊長'),
        ('LC125' , '上士區隊長'),
        ('LC126' , '下士區隊長'),
        ('LC127' , '下士區隊長'),
        ('LC128' , '下士區隊長'),
        ('LC129' , '下士行政士'),
        ('LC130' , '一等長中隊長'), #第四中隊
        ('LC131' , '二等長輔導長'),
        ('LC132' , '上士區隊長'),
        ('LC133' , '上士區隊長'),
        ('LC134' , '下士區隊長'),
        ('LC135' , '下士區隊長'),
        ('LC136' , '下士區隊長'),
        ('LC137' , '下士行政士'),

        ('LC201' , '中校大隊長'), #學員生二大隊
        ('LC202' , '少校輔導長'),
        ('LC203' , '中士行政士'),
        ('LC211' , '上尉中隊長'), #第五中隊
        ('LC212' , '少尉輔導長'),
        ('LC213' , '上士助教領導'),
        ('LC214' , '中士助教'),
        ('LC215' , '下士助教'),
        ('LC216' , '下士助教'),
        ('LC217' , '上兵助教'),
        ('LC218' , '上兵助教'),
        ('LC219' , '下士助教'),
        ('LC220' , '下士行政士'),
        ('LC221' , '上尉中隊長'), #第六中隊
        ('LC222' , '少尉輔導長'),
        ('LC223' , '上士助教'),
        ('LC224' , '中士助教'),
        ('LC225' , '下士助教'),
        ('LC226' , '下士助教'),
        ('LC227' , '下士助教'),
        ('LC228' , '下士助教'),
        ('LC229' , '下士助教'),
        ('LC230' , '下士行政士'),
        ('LC231' , '上尉中隊長'),    #第七中隊
        ('LC232' , '少尉輔導長'),
        ('LC233' , '上士助教'),
        ('LC234' , '中士助教'),
        ('LC235' , '下士助教'),
        ('LC236' , '下士助教'),
        ('LC237' , '下士助教'),
        ('LC238' , '上兵助教'),
        ('LC239' , '上兵助教'),
        ('LC240' , '下士行政士'),
        ('LC241' , '上尉隊長'), #第八中隊
        ('LC242' , '少尉輔導長'),
        ('LC243' , '上士助教'),
        ('LC244' , '中士助教'),
        ('LC245' , '下士助教'),
        ('LC246' , '上兵助教'),
        ('LC247' , '上兵助教'),
        ('LC248' , '下士隊長'),
        ('LC249' , '下士隊長'),
        ('LC250' , '上兵行政士'),

        ('MB001' , '中校隊長'),  #莒拳隊
        ('MB002' , '少校輔導長'),
        ('MB003' , '三等長助教'),
        ('MB004' , '一等長助教'),
        ('MB005' , '一等長助教'),
        ('MB006' , '三等長助教'),
        ('MB007' , '上士助教'),
        ('MB008' , '上士助教'),
        ('MB009' , '中士助教'),
        ('MB010' , '中士助教'),
        ('MB011' , '中士助教'),
        ('MB012' , '中士行政士'),

        ('NB001' , '上尉隊長'),  #勤務隊
        ('NB002' , '三等長副隊長'),
        ('NB003' , '下士行政士'),
        ('NB004' , '中士班長'), #支援班
        ('NB005' , '中士補給士'),
        ('NB006' , '中士補給士'),
        ('NB007' , '下士補給士'),
        ('NB008' , '下士營產士'),
        ('NB009' , '一兵補給兵'),
        ('NB010' , '上兵補給兵'),
        ('NB011' , '上兵補給兵'),
        ('NB012' , '上士班長'), #警衛班
        ('NB013' , '中士副班長'),
        ('NB014' , '下士作戰士'),
        ('NB015' , '下士作戰士'),
        ('NB016' , '上兵步槍兵'),
        ('NB017' , '上兵步槍兵'),
        ('NB018' , '二兵步槍兵'),
        ('NB019' , '一兵步槍兵'),
        ('NB020' , '二兵步槍兵'),
        ('NB021' , '上兵步槍兵'),
        ('NB022' , '一兵機槍兵'),
        ('NB023' , '一兵機槍兵'),
        ('NB024' , '上士班長'), #修護運輸班
        ('NB025' , '中士副班長'),
        ('NB026' , '下士機工士'),
        ('NB027' , '下士駕駛士'),
        ('NB028' , '上兵機工士'),
        ('NB029' , '上兵機工士'),
        ('NB030' , '上兵駕駛兵'),
        ('NB031' , '一兵駕駛兵'),
        ('NB032' , '一兵駕駛兵'),
        ('NB033' , '二兵駕駛兵')
";
    
if ($conn->query($sql) === TRUE) {
  echo "New records created successfully";
} else {
  echo "Error: " . $sql . "<br>" . $conn->error;
}
    
$conn->close();
?>

