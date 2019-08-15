// 呼び出してリターンを待ち、帰ってきた結果を返却する処理
function call_stored_wait(arg_arr,user_list,user_num){
    if(arg_arr){
        this.arg_arr = arg_arr;
    }else{
        this.arg_arr = null;
    }

    if(user_list){
        this.arg_arr["user_list"] = "";
        user_list.forEach(function(user_property){
            if(user_property.exist_flg){
                this.arg_arr["user_list"] += user_property.user_cd;
                this.arg_arr["user_list"] += ",";
            }
        });
        this.arg_arr["user_list"].slice(0,-1);
    }
    if(user_num){
    	this.arg_arr["user_num"] = user_num.user_num_exist;
    }

    return new Promise(function(resolve, reject){
        $.ajax({
            url: "/bingo/common/php/js_stored.php",
            cache: false,
            timeout: 30*60*1000,
            type:'POST',
            dataType: 'json',
            data:{
                stored_name:stored_name
                ,arg_arr:this.arg_arr
            }
        }).then(
            function(data){
                console.log(data);
                let ret = parseInt(data);

                console.log(data);

                if(data){
                    reject(data);
                }
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