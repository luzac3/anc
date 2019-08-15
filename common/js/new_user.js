function hash(password){
    return new Promise(function(resolve, reject){
        $.ajax({
            url: "../php/hash.php",
            cache: false,
            timeout: 10000,
            type:'POST',
            dataType: 'JSON',
            data:{
            	password:password
            }

        }).then(
            function(data){
                if(!data){
                    // 0(エラー)返却時
                    reject("ハッシュ生成失敗");
                }else{
                    resolve(data);
                }
            },
            function(XMLHttpRequest, textStatus, errorThrown){
                console.log("XMLHttpRequest : " + XMLHttpRequest.status);
                console.log("textStatus     : " + textStatus);
                console.log("errorThrown    : " + errorThrown.message);
            	reject("通信に失敗しました");
            }
        );
    })
}