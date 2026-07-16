//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_USE_CONSUMABLE_ITEM
// FUNCTION: Opens the item target pane for a consumable item.
//           Keeps the inventory pane inactive while the target pane is open.
//           Does not consume the item until a valid target use succeeds.
//
//===============================================================================//
function scr_inventory_use_consumable_item(_stct_item,_ref_inventory_pane){

	if (_stct_item == undefined){
		scr_inventory_cancel_item_use(_ref_inventory_pane);
		return false;
	}

	if (_stct_item._scr_item == undefined){

		var _ref_textbox = instance_create_layer(
			display_get_gui_width() * 0.5,
			display_get_gui_height() * 0.5,
			"ily_fx",
			obj_gui_scrolling_textbox
		);
		
		audio_play_sound(snd_use_item,0,false);

		_ref_textbox._ref_parent_gui = _ref_inventory_pane;
		_ref_textbox._str_text = "Nothing happens.";

		return false;
	}

	var _ref_target_pane = instance_create_layer(
		display_get_gui_width() * 0.5,
		display_get_gui_height() * 0.5,
		"ily_fx",
		obj_gui_item_target_pane
	);

	audio_play_sound(snd_use_item,0,false);

	_ref_target_pane._ref_parent_gui = _ref_inventory_pane;
	_ref_target_pane._stct_item = _stct_item;
	_ref_target_pane._str_target_mode = "PARTY";

	return true;
}