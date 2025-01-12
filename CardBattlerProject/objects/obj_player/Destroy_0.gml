if (ds_exists(card_inventory, ds_type_list)) {
    for (var i = 0; i < ds_list_size(card_inventory); i++) {
        var card = ds_list_find_value(card_inventory, i);
        if (ds_exists(card, ds_type_map)) {
            ds_map_destroy(card);
        }
    }
    ds_list_destroy(card_inventory);
}