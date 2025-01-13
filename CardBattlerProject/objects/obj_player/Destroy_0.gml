//////////////////////////////////////////
// DESTROY THE DSLIST TO RECOVER MEMORY //
//////////////////////////////////////////
if (ds_exists(global.card_inventory , ds_type_list)) {
    for (var _i = 0; _i < ds_list_size(global.card_inventory ); _i++) {
        var _ref_card = ds_list_find_value(global.card_inventory , _i);
        if (ds_exists(_ref_card, ds_type_map)) {
            ds_map_destroy(_ref_card);
        }
    }
    ds_list_destroy(global.card_inventory );
}