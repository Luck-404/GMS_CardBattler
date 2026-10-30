//===============================================================================//
// SCRIPT: SCR_BEAST_FEED_APPLY
// FUNCTION: Feeds a persistent Beast, keeping exactly the newest three foods.
//           Applies only the difference between previous and new food bonuses.
//           Repeated foods stack. Removing the oldest food removes its bonus.
//           Preserves other sources of stat changes and the current HP ratio.
// RETURNS: True on a valid food and Beast; false without mutations otherwise.
//===============================================================================//
function scr_beast_feed_apply(_stct_beast,_str_food_id){
    if (!is_struct(_stct_beast)) return false;
    if (!is_struct(scr_inventory_get_food_info(_str_food_id))) return false;
    var _arr_old = [];
    if (variable_struct_exists(_stct_beast,"_arr_beast_feed_list") && is_array(_stct_beast._arr_beast_feed_list)){
        for (var _i=0;_i<array_length(_stct_beast._arr_beast_feed_list);_i++){
            var _str_old = _stct_beast._arr_beast_feed_list[_i];
            if (is_struct(scr_inventory_get_food_info(_str_old))) array_push(_arr_old,_str_old);
        }
    }
    while (array_length(_arr_old)>3) array_delete(_arr_old,0,1);
    var _arr_new = array_create(array_length(_arr_old));
    for (var _i=0;_i<array_length(_arr_old);_i++) _arr_new[_i]=_arr_old[_i];
    array_push(_arr_new,_str_food_id);
    if (array_length(_arr_new)>3) array_delete(_arr_new,0,1);

    // The applied ledger tracks only food-owned bonuses (not base stats, level,
    // held items, skills, or any other temporary / permanent modifier).
    var _stct_prior = {};
    if (variable_struct_exists(_stct_beast,"_stct_beast_feed_applied") && is_struct(_stct_beast._stct_beast_feed_applied)){
        _stct_prior = _stct_beast._stct_beast_feed_applied;
    }
    var _stct_next = {};
    for (var _i=0;_i<array_length(_arr_new);_i++){
        var _stct_food = scr_inventory_get_food_info(_arr_new[_i]);
        var _arr_names = variable_struct_get_names(_stct_food._stct_bonuses);
        for (var _j=0;_j<array_length(_arr_names);_j++){
            var _str_key = _arr_names[_j];
            var _val_prev = variable_struct_exists(_stct_next,_str_key) ? variable_struct_get(_stct_next,_str_key) : 0;
            variable_struct_set(_stct_next,_str_key,_val_prev + variable_struct_get(_stct_food._stct_bonuses,_str_key));
        }
    }
    var _val_old_max_hp = max(1,_stct_beast._val_beast_hp_max);
    var _val_old_hp = max(0,_stct_beast._val_beast_hp_cur);
    var _val_hp_ratio = clamp(_val_old_hp / _val_old_max_hp,0,1);
    var _arr_keys = ["_val_beast_hp_stat","_val_beast_con_stat","_val_beast_ppow_stat","_val_beast_mpow_stat","_val_beast_pdef_stat","_val_beast_mdef_stat","_val_beast_speed_stat","_val_beast_crit_stat","_val_beast_dod_stat","_val_beast_min_stat"];
    for (var _i=0;_i<array_length(_arr_keys);_i++){
        var _str_key = _arr_keys[_i];
        var _val_was = variable_struct_exists(_stct_prior,_str_key) ? variable_struct_get(_stct_prior,_str_key) : 0;
        var _val_now = variable_struct_exists(_stct_next,_str_key) ? variable_struct_get(_stct_next,_str_key) : 0;
        var _val_difference = _val_now - _val_was;
        if (_val_difference != 0){
            var _val_current = variable_struct_exists(_stct_beast,_str_key) ? variable_struct_get(_stct_beast,_str_key) : 0;
            variable_struct_set(_stct_beast,_str_key,max(0,_val_current + _val_difference));
        }
    }
    _stct_beast._arr_beast_feed_list = _arr_new;
    _stct_beast._stct_beast_feed_applied = _stct_next;
    if (variable_struct_exists(_stct_beast,"_val_beast_hp_stat") && variable_struct_exists(_stct_beast,"_val_beast_level")){
        _stct_beast._val_beast_hp_max = scr_beast_get_max_hp(_stct_beast._val_beast_hp_stat,_stct_beast._val_beast_level);
        if (_val_old_hp <= 0) _stct_beast._val_beast_hp_cur = 0;
        else _stct_beast._val_beast_hp_cur = clamp(max(1,ceil(_stct_beast._val_beast_hp_max*_val_hp_ratio)),1,_stct_beast._val_beast_hp_max);
    }
    scr_debug_log("BEAST","FEED",undefined,"FED "+string(_stct_beast._str_beast_name)+" | FOOD: "+_str_food_id+" | MEALS: "+string(array_length(_arr_new)),"INFO","SCR_BEAST_FEED_APPLY");
    return true;
}
