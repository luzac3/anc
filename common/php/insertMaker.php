<?php
$root = $_SERVER["DOCUMENT_ROOT"];


require_once $root . '/bingo/common/php/stored.php';

if(!empty($_POST["argArr"])){
    // sqlファイル内容生成
    $sql = "INSERT INTO ";
    $sql .= $_POST["tableName"];
    $sql .= " VALUES(";

    $colArr = $_POST["argArr"];

    forEach($rowArr as $colArr){
            forEach($item as $rowArr){
                $sql .= "'" . $item . "',";
            }
        $sql .= "NOW(3),";
        $sql .= "NOW(3)";
        $sql = ")";
        $sql = ",";
    };

    $sql = substr($sql, 0, -1);

    $sql .= ");";

    $sql .= PHP_EOL . "COMMIT";
    $sql .= PHP_EOL . "quit";

    // 一時ファイル用のタイムスタンプを取得
    $time = time();
    // 一時ファイル名を設定
    $tempFile = "temp_" . $time . ".sql";

    // sqlファイル生成
    file_put_contents($tempFile, "");


    // sqlファイルを生成し、シェルスクリプトをキックすることで起動し、削除する
    $output = shell_exec("sh " . $root . "/bingo/common/sh/kickSql.sh '" . $tempFile . "'");

    // ファイルの削除

	echo json_encode($output);
}else{
	echo json_encode(0);
}
?>
