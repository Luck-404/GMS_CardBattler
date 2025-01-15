function scr_empty_exhausted() {
    var _size = ds_list_size(global.exhausted);
    
    for (var i = 0; i < _size; i++) {
        var _card = ds_list_find_value(global.exhausted, i);
        ds_list_add(global.card_inventory, _card); // Add card to inventory
    }
    
    ds_list_clear(global.exhausted); // Clear the exhausted list
}