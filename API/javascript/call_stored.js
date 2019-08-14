function call_stored(stored_name,arg_arr,time_out = 10000){
    if(arg_arr){
        this.arg_arr = arg_arr;
    }else{
        this.arg_arr = null;
    }
    console.log(this.arg_arr);

    return new Promise((resolve, reject) => {
        $.ajax({
            url: "/anc/common/php/js_stored.php",
            cache: false,
            timeout: time_out,
            type:'POST',
            dataType: 'json',
            data:{
                stored_name:stored_name
                ,arg_arr:this.arg_arr
            }
        }).then(
            function(data){
                console.log(data);
                if(!isNaN){
                    data = parseInt(data);
                    if(data){
                        reject(data);
                    }
                }
                resolve(data);
            },
            function(XMLHttpRequest, textStatus, errorThrown){
                console.log("更新処理に失敗しました");
                console.log("XMLHttpRequest : " + XMLHttpRequest.status);
                console.log("textStatus     : " + textStatus);
                console.log("errorThrown    : " + errorThrown.message);
                reject(0);
                // return;
            }
        );
    });
}