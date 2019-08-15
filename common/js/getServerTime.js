let getServerTime = new Promise(function(resolve){
    const request = new XMLHttpRequest();
    request.open("HEAD",window.location.href, true);
    request.send();
    request.onreadystatechange = function(){
        if(this.readyState === 4){
            resolve(new Date(request.getResponseHeader("Date")));
        }
    }
});