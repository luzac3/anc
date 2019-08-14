<?php
header('Content-Type: text/html; charset=UTF-8');
$root = $_SERVER["DOCUMENT_ROOT"];

require_once $root . '/anc/common/php/stored.php';
require_once $root . '/anc/common/php/conection.php';

if(!empty($_POST["argArr"])){
    $tableName = $_POST["argArr"]["tableName"];

    // sqlファイル内容生成
    $sql = "SET NAMES utf8;";
    
    $sql .= "INSERT INTO ";
    $sql .= $tableName;
    $sql .= " VALUES";

    $colArr = $_POST["argArr"]["sql"];

    forEach($colArr as $rowArr){
        $sql .= "(";
        forEach($rowArr as $item){
            if($item =="null"){
                $sql .= "NULL,";
                continue;
            }
            $sql .= "'" . $item . "',";
        }
        $sql = substr($sql, 0, -1);
        $sql .= ")";
        $sql .= ",";
    };

    $sql = substr($sql, 0, -1);
    $sql .= ";";

    $sql .= PHP_EOL . "COMMIT;";
    $sql .= PHP_EOL . "quit";

    // 一時ファイル用のタイムスタンプを取得
    $time = time();
    // 一時ファイル名を設定
    $tempFile = "temp_" . $time . ".sql";
    
    // sqlファイル生成場所
    $sqlFileDir = $root . "anc/sql/";

    // sqlファイル生成
    file_put_contents($sqlFileDir.$tempFile, $sql);
    
    // ユーザー情報の指定
    $dbInfo = new DbInfo;
    
    $username = $dbInfo->username;
    $server = $dbInfo->server;
    $password = $dbInfo->password;
    $db_name = $dbInfo->db_name;
    
    $ret = "sh " . $root . "anc/common/sh/kickSql.sh " .$sqlFileDir.$tempFile. " " .$username. " " .$server. " " .$password. " " .$db_name;

    // sqlファイルを生成し、シェルスクリプトをキックすることで起動し、削除する
    $output = shell_exec("sh " . $root . "/anc/common/sh/kickSql.sh " .$sqlFileDir.$tempFile. " " .$username. " " .$server. " " .$password. " " .$db_name);

/*
    // ファイルの削除
    unlink($tempFile);
*/
    echo json_encode($output);
    //echo json_encode($ret);
}else{
    echo json_encode(0);
}
?>
