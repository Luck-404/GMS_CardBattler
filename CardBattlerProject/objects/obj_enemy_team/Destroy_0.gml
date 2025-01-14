//////////////////////////////////////////
// DESTROY THE DSLIST TO RECOVER MEMORY //
//////////////////////////////////////////
//if (ds_exists(global.enemy_team , ds_type_list)) {
//    for (var _i = 0; _i < ds_list_size(global.enemy_team ); _i++) {
//        var _ref_creature = ds_list_find_value(global.enemy_team , _i);
//        if (ds_exists(_ref_creature, ds_type_map)) {
//            ds_map_destroy(_ref_creature);
//        }
//    }
//    ds_list_destroy(global.enemy_team );
//}