function scr_empty_hand() {
    var _size = ds_list_size(global.current_hand);
    
    for (var i = 0; i < _size; i++) {
        var _card = ds_list_find_value(global.current_hand, i);
        ds_list_add(global.card_inventory, _card); // Add card to inventory
    }
    
    ds_list_clear(global.current_hand); // Clear the current hand
}