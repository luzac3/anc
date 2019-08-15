function elemEventSetter(elems,event,eventFunc,argArr=null){
    if(elems[0]){
        let len = elems.length;
        for(let i=0; i<len; i++){
            elems[i].addEventListener(event,eventFunc,this,argArr);
        }
    }else{
        elems.addEventListener(event,eventFunc,this,argArr);
    }
}
