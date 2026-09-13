//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_USE_EGG_ITEM
// FUNCTION: Uses a Beast Egg from the overworld Inventory.
//           Creates the Egg's Beast, adds it to the Party or Ranch,
//           consumes the Egg, and logs the resulting hatch.
//
// ARGUMENTS: _stct_item is the selected Egg item struct.
//            _ref_inventory_pane is the owning Inventory pane.
// RETURNS: True if the Egg was successfully hatched, otherwise false.
//
//===============================================================================//

function scr_inventory_use_egg_item(_stct_item,_ref_inventory_pane){

	//================//
	//VALIDATE ITEM//
	//================//
	if (_stct_item == undefined){

		scr_inventory_cancel_item_use(_ref_inventory_pane);

		return false;
	}

	//================//
	//GET BEAST ID//
	//================//
	var _str_beast_id = scr_inventory_get_egg_beast_id(
		_stct_item._str_item_id
	);

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

	//================//
	//GET DESTINATION//
	//================//
	var _str_destination = "PARTY";

	if (ds_list_size(global.list_player_party) >= 5){
		_str_destination = "RANCH";
	}

	//================//
	//HATCH BEAST//
	//================//
	var _stct_new_beast = scr_beast_init_random(
		_str_beast_id
	);

	if (!is_struct(_stct_new_beast)){

		scr_debug_log(
			"INVENTORY",
			"EGG",
			undefined,
			"EGG HATCH FAILED" +
			" | ITEM: " +
			string_upper(_stct_item._str_item_name) +
			" | BEAST ID: " +
			string_upper(_str_beast_id) +
			" | REASON: BEAST CREATION FAILED",
			"ERROR",
			"SCR_INVENTORY_USE_EGG_ITEM"
		);

		return false;
	}

	var _flag_added = scr_party_add_beast(
		_stct_new_beast
	);

	if (!_flag_added){

		scr_debug_log(
			"INVENTORY",
			"EGG",
			undefined,
			"EGG HATCH FAILED" +
			" | ITEM: " +
			string_upper(_stct_item._str_item_name) +
			" | BEAST: " +
			string_upper(_stct_new_beast._str_beast_name) +
			" | REASON: PARTY/RANCH ADD FAILED",
			"ERROR",
			"SCR_INVENTORY_USE_EGG_ITEM"
		);

		return false;
	}

	audio_play_sound(
		snd_beast_hatch,
		0,
		false
	);

	audio_play_sound(
		_stct_new_beast._snd_beast_cry,
		0,
		false
	);

	//================//
	//REMOVE EGG//
	//================//
	var _flag_egg_removed = scr_inventory_remove_item(
		_stct_item,
		1
	);

	//================//
	//DEBUG HATCH//
	//================//
	scr_debug_log(
		"INVENTORY",
		"EGG",
		undefined,
		"EGG HATCHED" +
		" | EGG: " +
		string_upper(_stct_item._str_item_name) +
		" | BEAST: " +
		string_upper(_stct_new_beast._str_beast_name) +
		" | LEVEL: " +
		string(_stct_new_beast._val_beast_level) +
		" | UID: " +
		string(_stct_new_beast._uid_beast) +
		" | DESTINATION: " +
		_str_destination +
		" | EGG CONSUMED: " +
		(_flag_egg_removed ? "YES" : "NO"),
		_flag_egg_removed ? "INFO" : "ERROR",
		"SCR_INVENTORY_USE_EGG_ITEM"
	);

	//================//
	//OPEN RESULT TEXTBOX//
	//================//
	var _ref_textbox = instance_create_layer(
		display_get_gui_width() * 0.5,
		display_get_gui_height() * 0.5,
		"ily_fx",
		obj_gui_scrolling_textbox
	);

	_ref_textbox._ref_parent_gui = _ref_inventory_pane;

	_ref_textbox._str_text =
		"The egg hatched into " +
		string(_stct_new_beast._str_beast_name) +
		". It was sent to your " +
		string_lower(_str_destination) +
		"." +
		"\n\nAbility: " +
		string(_stct_new_beast._str_beast_ability) +
		"\nBreed: " +
		string(_stct_new_beast._str_beast_breed);

	return true;
}