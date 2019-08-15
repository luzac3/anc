function defaultAjax(argArr, phpAddr, time_out = 1000){

    return new Promise((resolve, reject) => {
        $.ajax({
            url: phpAddr
            ,cache: false
            // ,timeout: time_out
            ,type:'POST'
            ,dataType: 'json'
            ,data:{
                argArr:argArr
            }
            //,processData: false
            //,contentType: false
            //,traditional: true
        }).then(
            function(data){
                console.log(data);
                resolve(data);
            },
            function(XMLHttpRequest, textStatus, errorThrown){
                console.log("更新処理に失敗しました");
                console.log("XMLHttpRequest : " + XMLHttpRequest.status);
                console.log("textStatus     : " + textStatus);
                console.log("errorThrown    : " + errorThrown.message);
                reject(0);
            }
        );
    });
}
