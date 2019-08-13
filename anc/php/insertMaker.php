<?php
$root = $_SERVER["DOCUMENT_ROOT"];


require_once $root . '/anc/common/php/stored.php';

if(!empty($_POST["argArr"])){
    $tableName = $_POST["argArr"]["tableName"];

    // sqlファイル内容生成
    $sql = "INSERT INTO ";
    $sql .= $tableName;
    $sql .= " VALUES(";

    $colArr = $_POST["argArr"]["sql"];

    forEach($colArr as $rowArr){
        $sql .= "(";
            forEach($rowArr as $item){
                if($item =="null"){
                    $sql .= NULL;
                    continue;
                }
                $sql .= "'" . $item . "',";
            }
        $sql .= ")";
        $sql .= ",";
    };

    $sql = substr($sql, 0, -1);

    $sql .= ");";

    $sql .= PHP_EOL . "COMMIT;";
    $sql .= PHP_EOL . "quit;";

    // 一時ファイル用のタイムスタンプを取得
    $time = time();
    // 一時ファイル名を設定
    $tempFile = "temp_" . $time . ".sql";

    // sqlファイル生成
    file_put_contents($tempFile, $sql);


    // sqlファイルを生成し、シェルスクリプトをキックすることで起動し、削除する
    $output = shell_exec("sh " . $root . "/anc/anc/sh/kickSql.sh '" . $tempFile . "'");

    // ファイルの削除

	echo json_encode($output);
}else{
	echo json_encode(0);
}
?>
