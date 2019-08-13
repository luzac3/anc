<?php
session_start();
if(!empty($_POST)){
    // 平文パスワード
    $bng_no = $_POST["bng_no"];
    $password = $_POST["password"];

    $arg_arr = array(
        "bng_no" => $bng_no
    );

    // ストアド呼び出し用のファイルをロード
    require_once ("../php/stored.php");

    $result = stored("passwd_check_001",$arg_arr);

    if(!$result[0]){
        echo json_encode("ビンゴ番号が存在しません");
        return;
    }

    $hash = $result[0]["HSH"];

    // パスワードを検証する
    if (hash_equals($hash,crypt($password, $hash))) {
        $_SESSION['username'] = $username;
        $_SESSION['trk_num'] = $result[0]["TRK_NUM"];

        // 正常終了
        echo 0;
    } else {
        // パスワードが間違っている場合
        echo json_encode("パスワードが違います");
    }

}else{
    // 未知のエラー
        echo json_encode("未知のエラーです");
}

?>