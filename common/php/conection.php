<?php

function db_connect(){
    $dbInfo = new DbInfo;
    
    $server = $dbInfo->server;
    $username = $dbInfo->username;
    $password = $dbInfo->password;
    $db_name = $dbInfo->db_name;

    $mysqli = new mysqli($server,$username,$password,$db_name);
    if($mysqli->connect_error){
        echo $mysqli->connect_error;
        exit();
    }else{
        $mysqli->set_charset("utf8");
    }
    return $mysqli;
}

class DbInfo{
    public $server = "";
    public $username = "";
    public $password = "";
    public $db_name = "";
    public $host = "";
    
    function __construct(){
        if ($_SERVER['HTTP_HOST'] == "localhost"){
            $this->server = "localhost";
            $this->username = "root";
            $this->password = "alderaan";
            $this->db_name = "ancate";
        }else{
            $this->server = "mysql622.db.sakura.ne.jp";
            $this->username = "wolfnet-twei";
            $this->password = "alderaan123";
            $this->db_name = "wolfnet-twei_ancate";
        }
    }
}
?>
