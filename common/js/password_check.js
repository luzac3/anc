function login(bng_no,password){
    return new Promise(function(resolve, reject){
        $.ajax({
            url: "../../php/login_check.php",
            cache: false,
            timeout: 10000,
            type:'POST',
            dataType: 'json',
            data:{
                bng_no:bng_no
                ,password:password
            }
        }).then(
            function(data){
                if(!data){
                    // 成功
                    resolve(data);
                }else{
                    // 失敗
                    reject(data);
                }

            },
            function(XMLHttpRequest, textStatus, errorThrown){
                console.log("通信に失敗しました");
                console.log("XMLHttpRequest : " + XMLHttpRequest.status);
                console.log("textStatus     : " + textStatus);
                console.log("errorThrown    : " + errorThrown.message);
                reject("通信に失敗しました");
            }
        );
    });
}
