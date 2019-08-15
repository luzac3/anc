<?php
header('Content-Type: text/html; charset=UTF-8');
$root = $_SERVER["DOCUMENT_ROOT"];

require_once $root . '/anc/common/php/stored.php';
require_once $root . '/anc/common/php/insertMaker.php';

if(!empty($_POST["argArr"])){
    $argArr = $_POST["argArr"];
    $storedName = $argArr["storedName"];
    //  パスワード生成関数呼び出し
    $hash = password_hash($argArr["userRegisterArr"]["pass"], PASSWORD_DEFAULT);
    // user番号用のタイムスタンプ取得
    $time = time();
    $argArr["userRegisterArr"]["userId"] = $time;
    $argArr["userRegisterArr"]["hash"] = $hash;

    $userRegisterArr = array(
        $argArr["userRegisterArr"]["userId"]
        ,$argArr["userRegisterArr"]["userName"]
        ,$argArr["userRegisterArr"]["twitterId"]
        ,$argArr["userRegisterArr"]["dancePlanFlg"]
        ,$argArr["userRegisterArr"]["hash"]
    );

    // ストアドプロシージャ呼び出し
    $result = stored(
        $storedName
        ,$userRegisterArr
    );
    
    forEach($argArr["sql"] as $key=>$sql){
        $argArr["sql"][$key]["userId"] = $time;
    }

    $output = insertMaker($argArr);

    echo json_encode($result);
}else{
    echo json_encode(0);
}
?>
