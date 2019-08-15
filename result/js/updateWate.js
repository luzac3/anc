function updateWate(){
    // アップデートの受信(繰り返し)

    let loopResponse = function(){
        // データ取得待機
        sql_wait().then(function(data){
            // コンテンツ書き換え

            // 全機材＆全ユーザが揃っていなければ再呼び出し
            if(data["STTS"] == "2" || data["STTS"] == "3"){
                setTimeout(loopResponse, 5000);
            }
        }).then(function(){
            setTimeout(loopresponse, 5000);
        });
    }
}