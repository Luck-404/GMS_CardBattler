//===============================================================================//
// SCRIPT: SCR_BEAST_FEED_GET_RECENT
// FUNCTION: Returns up to 3 meal display structs, NEWEST FIRST, followed by
//           empty display placeholders. Does not alter the Beast or its stats.
//===============================================================================//
function scr_beast_feed_get_recent(_stct_beast){
    var _arr_result=[];
    if (is_struct(_stct_beast) && variable_struct_exists(_stct_beast,"_arr_beast_feed_list") && is_array(_stct_beast._arr_beast_feed_list)){
        var _arr_meals=_stct_beast._arr_beast_feed_list;
        for (var _i=array_length(_arr_meals)-1;_i>=0;_i--){
            var _stct_food=scr_inventory_get_food_info(_arr_meals[_i]);
            if (is_struct(_stct_food)) array_push(_arr_result,_stct_food);
            if (array_length(_arr_result)>=3) break;
        }
    }
    while (array_length(_arr_result)<3) array_push(_arr_result,undefined);
    return _arr_result;
}
