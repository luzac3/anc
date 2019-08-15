<?php
if(!isset($_SESSION)){
  session_start();
}
if(!empty($_POST["argArr"])){
    // 平文パスワード
    $userName = $_POST["argArr"]["userName"];
    $twitterId = $_POST["argArr"]["twitterId"];
    $pass = $_POST["argArr"]["pass"];
    $arg_arr = array(
        $userName
        ,$twitterId
    );
    $root = $_SERVER["DOCUMENT_ROOT"];

    // ストアド呼び出し用のファイルをロード
    require_once ($root."anc/common/php/stored.php");

    $result = stored("getHash",array($userName,$twitterId));
    if(!$result[0]){
        echo json_encode("ユーザー名が間違っています");
        return;
    }
    $hash = $result[0]["HASH"];

    $exhash = password_hash($pass, PASSWORD_DEFAULT);

    // パスワードを検証する
    if (password_verify($pass, $hash)) {
        $_SESSION['userName'] = $userName;
        $_SESSION['twitterId'] = $twitterId;
        $_SESSION['userId'] = $result[0]["USER_ID"];
        // 正常終了
        echo json_encode(1);
    } else {
        // パスワードが間違っている場合
        echo json_encode(2);
    }
}else{
    // 未知のエラー
    echo json_encode(0);
}

?>
