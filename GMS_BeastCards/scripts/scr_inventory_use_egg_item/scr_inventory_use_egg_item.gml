//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_USE_EGG_ITEM
// FUNCTION: Uses an egg item from the overworld inventory.
//           Creates the egg's beast, adds it to party or ranch,
//           removes the egg, and opens a scrolling result textbox.
//
//===============================================================================//
function scr_inventory_use_egg_item(_stct_item,_ref_inventory_pane){

	if (_stct_item == undefined){
		scr_inventory_cancel_item_use(_ref_inventory_pane);
		return false;
	}

	var _str_beast_id = scr_get_egg_beast_id(_stct_item._str_item_id);

	if (_str_beast_id == undefined){

		var _ref_fail_textbox = instance_create_layer(
			display_get_gui_width() * 0.5,
			display_get_gui_height() * 0.5,
			"ily_fx",
			obj_gui_scrolling_textbox
		);

		_ref_fail_textbox._ref_parent_gui = _ref_inventory_pane;
		_ref_fail_textbox._str_text = "Nothing happens.";

		return false;
	}

	var _str_destination = "party";

	if (ds_list_size(global.list_player_party) >= 5){
		_str_destination = "ranch";
	}

	var _stct_new_beast = scr_init_beast_random(_str_beast_id);

	scr_add_beast_to_party(_stct_new_beast);
	scr_remove_item_from_inventory(_stct_item,1);

	var _ref_textbox = instance_create_layer(
		display_get_gui_width() * 0.5,
		display_get_gui_height() * 0.5,
		"ily_fx",
		obj_gui_scrolling_textbox
	);

	_ref_textbox._ref_parent_gui = _ref_inventory_pane;
	_ref_textbox._str_text = 
		"The egg hatched into " + string(_stct_new_beast._str_beast_name) + 
		". It was sent to your " + _str_destination + "." +
		"\n\nAbility: " + string(_stct_new_beast._str_beast_ability) +
		"\nBreed: " + string(_stct_new_beast._str_beast_breed);
	return true;
}