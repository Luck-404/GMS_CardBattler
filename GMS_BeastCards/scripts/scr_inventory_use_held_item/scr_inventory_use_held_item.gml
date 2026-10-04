//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_USE_HELD_ITEM
// FUNCTION: Opens the shared Item target pane in HELD mode.
//           Lets the player see each Party Beast's current Held Item before
//           choosing which Beast receives the selected Item.
//
// ARGUMENTS: _stct_item is the selected Held Item.
//            _ref_inventory_pane is the owning Inventory pane.
// RETURNS: True when target selection opens.
//
//===============================================================================//

function scr_inventory_use_held_item(_stct_item,_ref_inventory_pane){

	//================//
	//VALIDATE ITEM//
	//================//
	if (_stct_item == undefined){

		scr_inventory_cancel_item_use(
			_ref_inventory_pane
		);

		return false;
	}

	if (_stct_item._str_item_type != "HELD"){

		scr_inventory_cancel_item_use(
			_ref_inventory_pane
		);

		return false;
	}

	//================//
	//OPEN TARGET PANE//
	//================//
	var _ref_target_pane =
		instance_create_layer(
			display_get_gui_width() * 0.5,
			display_get_gui_height() * 0.5,
			"ily_fx",
			obj_gui_item_target_pane
		);

	audio_play_sound(
		snd_inventory_use_item,
		0,
		false
	);

	_ref_target_pane._ref_parent_gui =
		_ref_inventory_pane;

	_ref_target_pane._stct_item =
		_stct_item;

	_ref_target_pane._str_target_mode =
		"HELD";

	return true;
}