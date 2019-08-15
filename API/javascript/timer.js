let Timer = function(){
    /*
     * タイマー開始/リセット
     */
    this.startTimer = function(){
        this.now = Date.now();
    }

     /*
     * 時間取得
     */
    this.getTime = function(){
        return Date.now() - this.now;
    }
}

function timer_storage(reset){
    if(!this.timer){
        this.timer = new Timer();
        this.timer.startTimer();
    }
    if(reset){
        this.timer.startTimer();
    }
    return (function(){
        return this.timer.getTime();
    });
}