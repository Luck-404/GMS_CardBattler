function scr_empty_hand() {
    var _size = ds_list_size(global.current_hand);
    
    for (var _i = 0; _i < _size; _i++) {
        var _card = ds_list_find_value(global.current_hand, _i);
        ds_list_add(global.card_inventory, _card); // Add card to inventory
    }
    
    ds_list_clear(global.current_hand); // Clear the current hand
}