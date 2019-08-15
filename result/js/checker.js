function checker(target, kind){
    // ユーザーと機材のチェックを入れたときの挙動

	// 変更された値を取得
    let check = target.value;

    let chkFlg = null;

    if(target.checked){
        chkFlg = 1;

        // チェックされた参加者をリストから削除
    }

    let result = null;

    if(kind == "joinner"){
        // sqlreaderの呼び出し
        result = sqlReader();

        // うまくいったらその内容でコンテンツをリロード

    }else{
        //
    }
    //ajaxで内容を書き換え
}