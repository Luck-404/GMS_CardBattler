//////////////////////////////////////////
// DESTROY THE DSLIST TO RECOVER MEMORY //
//////////////////////////////////////////
if (ds_exists(global.current_hand , ds_type_list)) {
    for (var _i = 0; _i < ds_list_size(global.current_hand ); _i++) {
        var _ref_card = ds_list_find_value(global.current_hand , _i);
        if (ds_exists(_ref_card, ds_type_map)) {
            ds_map_destroy(_ref_card);
        }
    }
    ds_list_destroy(global.current_hand );
}

if (ds_exists(global.exhausted , ds_type_list)) {
    for (var _i = 0; _i < ds_list_size(global.exhausted ); _i++) {
        var _ref_card = ds_list_find_value(global.exhausted , _i);
        if (ds_exists(_ref_card, ds_type_map)) {
            ds_map_destroy(_ref_card);
        }
    }
    ds_list_destroy(global.exhausted );
}