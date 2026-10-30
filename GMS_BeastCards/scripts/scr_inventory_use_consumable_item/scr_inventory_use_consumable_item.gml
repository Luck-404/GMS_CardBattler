//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_USE_CONSUMABLE_ITEM
// FUNCTION: Opens the item target pane for a consumable item.
//           Keeps the inventory pane inactive while target selection is open.
//           Does not consume the item until a valid target use succeeds.
//
// ARGUMENTS: _stct_item is the selected consumable item struct.
//            _ref_inventory_pane is the owning inventory pane.
// RETURNS: True if target selection opens, otherwise false.
//
//===============================================================================//

function scr_inventory_use_consumable_item(_stct_item,_ref_inventory_pane){

	//================//
	//VALIDATE ITEM//
	//================//
	if (_stct_item == undefined){
		scr_inventory_cancel_item_use(_ref_inventory_pane);
		return false;
	}

	//================//
	//NO ITEM EFFECT//
	//================//
	if (_stct_item._scr_item == undefined){

		var _ref_textbox = instance_create_layer(
			display_get_gui_width() * 0.5,
			display_get_gui_height() * 0.5,
			"ily_fx",
			obj_gui_scrolling_textbox
		);

		audio_play_sound(snd_inventory_use_item,0,false);

		_ref_textbox._ref_parent_gui = _ref_inventory_pane;
		_ref_textbox._str_text = "Nothing happens.";

		return false;
	}

	//================//
	//OPEN TARGET PANE//
	//================//
	var _ref_target_pane = instance_create_layer(
		display_get_gui_width() * 0.5,
		display_get_gui_height() * 0.5,
		"ily_fx",
		obj_gui_item_target_pane
	);

	audio_play_sound(snd_inventory_use_item,0,false);

	_ref_target_pane._ref_parent_gui = _ref_inventory_pane;
	_ref_target_pane._stct_item = _stct_item;
	_ref_target_pane._str_target_mode = "PARTY";

    // Food-only pane: remove 50px of unused space from the bottom.
    // Keep the original top edge so the Beast slots and Recent Meals do not move.
    if (variable_struct_exists(_stct_item,"_str_consumable_action") && _stct_item._str_consumable_action == "FOOD"){
        var _val_food_original_h = 620;
        var _val_food_bottom_trim = 50;

        _ref_target_pane._val_pane_w = 930;
        _ref_target_pane._val_pane_h = _val_food_original_h - _val_food_bottom_trim;
        _ref_target_pane._val_pane_left = _ref_target_pane.x - (_ref_target_pane._val_pane_w*0.5);
        _ref_target_pane._val_pane_top = _ref_target_pane.y - (_val_food_original_h*0.5);
        _ref_target_pane._val_left_x = _ref_target_pane._val_pane_left + 24;
        _ref_target_pane._val_right_x = _ref_target_pane._val_pane_left + 465;
        _ref_target_pane._val_start_y = _ref_target_pane._val_pane_top + 70;
    }


	return true;
}
