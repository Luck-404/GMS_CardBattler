//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_USE_HELD_ITEM
// FUNCTION: Opens the item target pane for a held item.
//           Lets the player choose which party beast receives the item.
//           Actual equip/swap behavior is handled by scr_use_inventory_held_item.
//
//===============================================================================//
function scr_inventory_use_held_item(_stct_item,_ref_inventory_pane){

	if (_stct_item == undefined){
		scr_inventory_cancel_item_use(_ref_inventory_pane);
		return false;
	}

	var _ref_target_pane = instance_create_layer(
		display_get_gui_width() * 0.5,
		display_get_gui_height() * 0.5,
		"ily_fx",
		obj_gui_item_target_pane
	);

	_ref_target_pane._ref_parent_gui = _ref_inventory_pane;
	_ref_target_pane._stct_item = _stct_item;
	_ref_target_pane._str_target_mode = "HELD";

	return true;
}