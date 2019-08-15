function re_instance(property,old_property){
    const ret_property = new property();

    for (let key in old_property){
        ret_property[key] = old_property[key];
    }

    return ret_property;
}

