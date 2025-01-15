function scr_empty_exhausted() {
    var _size = ds_list_size(global.exhausted);
    
    for (var _i = 0; _i < _size; _i++) {
        var _card = ds_list_find_value(global.exhausted, _i);
        ds_list_add(global.card_inventory, _card); // Add card to inventory
    }
    
    ds_list_clear(global.exhausted); // Clear the exhausted list
}