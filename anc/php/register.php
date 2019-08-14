<?php
header('Content-Type: text/html; charset=UTF-8');
$root = $_SERVER["DOCUMENT_ROOT"];

require_once $root . '/anc/common/php/conection.php';
require_once $root . '/anc/common/php/makePass.php';
require_once $root . '/anc/common/php/insertMaker.php';

if(!empty($_POST["argArr"])){
    $argArr = $_POST["argArr"];
    $storedName = $argArr["storedName"];

    //  パスワード生成関数呼び出し
    $hash = makePass($argArr["pass"]);

    // user番号用のタイムスタンプ取得
    $time = time();

    $arg_arr["userRegisterArr"]["userId"] = $time;
    $arg_arr["userRegisterArr"]["hash"] = $hash;

    // ストアドプロシージャ呼び出し
    $result = stored($storedName, $arg_arr["userRegisterArr"]);

    forEach($arg_arr["sql"] as $key=>$sql){
        $arg_arr["sql"][$key]["userId"] = $time;
    }

    $output = insertMaker($argArr);

    echo json_encode($output);
    //echo json_encode($ret);
}else{
    echo json_encode(0);
}
?>
