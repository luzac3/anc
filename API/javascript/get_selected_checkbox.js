function get_checkbox(name){
    let result = [];

    const elements_list = document.getElementsByName(name);

    // ノードリストを配列に変換
    const elements = Array.prototype.slice.call(elements_list,0);

    elements.forEach(function(element){
        if(element.checked){
            result.push(element.value);
        }
    });
    return result;
}

function get_radiobutton(name){

}