//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_USE_QUEST_ITEM
// FUNCTION: Uses a Quest Item from the overworld Inventory.
//           Runs the item's attached Quest script when available.
//           Logs whether the Quest Item successfully resolved.
//
// ARGUMENTS: _stct_item is the selected Quest Item struct.
//            _ref_inventory_pane is the owning Inventory pane.
// RETURNS: Result returned by the Quest script, or false if use cannot resolve.
//
//===============================================================================//

function scr_inventory_use_quest_item(_stct_item,_ref_inventory_pane){

	//================//
	//VALIDATE ITEM//
	//================//
	if (_stct_item == undefined){

		scr_inventory_cancel_item_use(
			_ref_inventory_pane
		);

		return false;
	}

	if (_stct_item._str_item_type != "QUEST"){

		scr_inventory_cancel_item_use(
			_ref_inventory_pane
		);

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

		audio_play_sound(
			snd_inventory_use_item,
			0,
			false
		);

		_ref_textbox._ref_parent_gui = _ref_inventory_pane;
		_ref_textbox._str_text = "Nothing seems to happen.";

		scr_debug_log(
			"INVENTORY",
			"QUEST",
			undefined,
			"QUEST ITEM USE FAILED" +
			" | ITEM: " +
			string_upper(_stct_item._str_item_name) +
			" | REASON: NO ITEM EFFECT",
			"WARNING",
			"SCR_INVENTORY_USE_QUEST_ITEM"
		);

		return false;
	}

	//================//
	//USE QUEST ITEM//
	//================//
	var _flag_success = _stct_item._scr_item(
		_stct_item,
		_ref_inventory_pane
	);

	//================//
	//DEBUG QUEST USE//
	//================//
	scr_debug_log(
		"INVENTORY",
		"QUEST",
		undefined,
		"QUEST ITEM USED" +
		" | ITEM: " +
		string_upper(_stct_item._str_item_name) +
		" | ID: " +
		string_upper(_stct_item._str_item_id) +
		" | RESULT: " +
		(_flag_success ? "SUCCESS" : "NO EFFECT") +
		" | ROOM: " +
		room_get_name(room),
		"INFO",
		"SCR_INVENTORY_USE_QUEST_ITEM"
	);

	return _flag_success;
}