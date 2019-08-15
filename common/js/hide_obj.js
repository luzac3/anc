/*
 * @param 表示する要素のID名 必須
 * @return なし
 */
function hide_obj(id_name){
    const target = document.getElementById(id_name);
    target.style.visiblity = "hidden";
}