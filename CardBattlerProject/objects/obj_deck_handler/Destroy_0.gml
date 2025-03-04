//////////////////////////////////////////
// DESTROY THE DSLIST TO RECOVER MEMORY //
//////////////////////////////////////////
if (ds_exists(global.player_hand , ds_type_list)) {
    for (var _i = 0; _i < ds_list_size(global.player_hand ); _i++) {
        var _ref_card = ds_list_find_value(global.player_hand , _i);
        if (ds_exists(_ref_card, ds_type_map)) {
            ds_map_destroy(_ref_card);
        }
    }
    ds_list_destroy(global.player_hand );
}

if (ds_exists(global.player_exhaust_pile , ds_type_list)) {
    for (var _i = 0; _i < ds_list_size(global.player_exhaust_pile ); _i++) {
        var _ref_card = ds_list_find_value(global.player_exhaust_pile , _i);
        if (ds_exists(_ref_card, ds_type_map)) {
            ds_map_destroy(_ref_card);
        }
    }
    ds_list_destroy(global.player_exhaust_pile );
}