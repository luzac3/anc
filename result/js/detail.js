// イベント列挙
document.ready=function(){
    let joinnerList = document.getElementsByName("joinnerList");
    let equipmentList = document.getElementsByname("equipmentlist");
    let delay = document.getElementById("delay");

    // 変更待機起動(チェックボックスの変更待機項目。Adminユーザの場合のみ起動する
    // 変更を受信したら上部の内容を書き換え
    if(admin){
        updateWate();
    }

    // 編集ボタン押下時

    // 時間遅延ボタン押下時
    delay.addEventListener("click", timeChange);

    // チェックボックス変更時
    joinnerList.addEventlistener("change", checker, this, "joinner");
    equoipmentList.addEventListener("change", checker, this, "equip");
}