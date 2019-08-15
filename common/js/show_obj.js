/*
 * 要素を表示状態に変える。
 * 普通に表示するのではなく、要素の背景を白で塗りつぶして表示する(前面に小ウィンドウのように表示)
 * 色指定やOpacityの設定も出来るようにしておこうかなあ
 *
 * @param 表示する要素のID名 必須
 * @param 表示する要素の幅(％)
 * @param 表示する要素の高さ(％)
 * @param サイズの指定方法 falseなら％表示(デフォルト)、trueならPx
 * @return なし
 */
function show_obj(id_name,width,height,size){
    const target = document.getElementById(id_name);
    target.style.display = "block";

    let unit = "%";

    if(size){
        unit = "px";
    }

    if(width){
        target.width = width + unit;
    }
    if(height){
        target.height = height + unit;
    }

    target.style.backgroundColor = "#ffffff";

}