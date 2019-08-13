<?php

function db_connect(){
    // db接続関数
    if ($_SERVER['HTTP_HOST'] == "localhost"){
        $server ="localhost";
        $username="root";
        $password="alderaan";
        $db_name="ancate";
    }else{
        $server ="mysql622.db.sakura.ne.jp";
        $username="wolfnet-twei";
        $password="alderaan123";
        $db_name="wolfnet-twei_ancate";
    }

    $mysqli = new mysqli($server,$username,$password,$db_name);
    if($mysqli->connect_error){
        echo $mysqli->connect_error;
        exit();
    }else{
        $mysqli->set_charset("utf8");
    }
    return $mysqli;
}
?>
