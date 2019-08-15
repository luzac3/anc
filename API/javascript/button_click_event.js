/*
 * 共通のボタンクリック時イベント
 */

function click_event(this_obj){
    let class_name = this_obj.getAttribute("class");
    if(class_name == "close"){
        this_obj.parentNode.setAttribute("class","hidden");
        this_obj.style.visibility = "hidden";
    }
}
