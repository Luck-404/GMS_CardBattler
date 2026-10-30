//===============================================================================//
// SCRIPT: SCR_INVENTORY_ITEM_CONSUMABLE_FOOD
// FUNCTION: Feed selected Party Beast; caller consumes exactly one on success.
//===============================================================================//
function scr_inventory_item_consumable_food(_stct_item,_stct_target_unit,_val_popup_x,_val_popup_y){
    if (!is_struct(_stct_item) || !is_struct(_stct_target_unit)) return false;
    var _stct_food=scr_inventory_get_food_info(_stct_item._str_item_id);
    if (!is_struct(_stct_food)) return false;
    if (!scr_beast_feed_apply(_stct_target_unit,_stct_item._str_item_id)) return false;
    scr_gui_spawn_popup_scrolling("TEXT","FED "+string_upper(_stct_food._str_food_name),undefined,c_yellow,_val_popup_x,_val_popup_y);
    return true;
}
