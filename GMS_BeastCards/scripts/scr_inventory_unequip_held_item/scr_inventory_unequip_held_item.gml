//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_UNEQUIP_HELD_ITEM
// FUNCTION: Removes a Held Item from a target Beast.
//           Runs the item's UNEQUIP effect, returns the exact item struct to
//           Inventory, clears the Held Item slot, and logs the result.
//
// ARGUMENTS: _stct_target_unit is the Beast holding the item.
//            _val_popup_x/_val_popup_y are the feedback popup coordinates.
// RETURNS: True when the item is successfully unequipped, otherwise false.
//
//===============================================================================//

function scr_inventory_unequip_held_item(_stct_target_unit,_val_popup_x,_val_popup_y){

	//================//
	//VALIDATE TARGET//
	//================//
	if (!is_struct(_stct_target_unit)){
		return false;
	}

	//================//
	//GET HELD ITEM//
	//================//
	var _stct_old_item = _stct_target_unit._stct_beast_held_item;

	if (
		_stct_old_item == undefined ||
		_stct_old_item == "EMPTY"
	){

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"NO HELD ITEM",
			undefined,
			c_white,
			_val_popup_x,
			_val_popup_y
		);

		return false;
	}

	//================//
	//UNEQUIP ITEM//
	//================//
	if (_stct_old_item._scr_item != undefined){

		_stct_old_item._scr_item(
			"UNEQUIP",
			_stct_old_item,
			_stct_target_unit
		);
	}

	//================//
	//RETURN TO INVENTORY//
	//================//
	var _flag_returned = scr_inventory_add_item_struct(
		_stct_old_item
	);

	if (!_flag_returned){

		scr_debug_log(
			"INVENTORY",
			"UNEQUIP",
			undefined,
			"HELD ITEM UNEQUIP FAILED" +
			" | ITEM: " +
			string_upper(_stct_old_item._str_item_name) +
			" | HOLDER: " +
			string_upper(_stct_target_unit._str_beast_name) +
			" | REASON: ITEM COULD NOT RETURN TO INVENTORY",
			"ERROR",
			"SCR_INVENTORY_UNEQUIP_HELD_ITEM"
		);

		return false;
	}

	_stct_target_unit._stct_beast_held_item = "EMPTY";

	//================//
	//FEEDBACK//
	//================//
	scr_gui_spawn_popup_scrolling(
		"TEXT",
		"UNEQUIPPED",
		undefined,
		c_white,
		_val_popup_x,
		_val_popup_y
	);

	//================//
	//DEBUG UNEQUIP//
	//================//
	scr_debug_log(
		"INVENTORY",
		"UNEQUIP",
		undefined,
		"HELD ITEM UNEQUIPPED" +
		" | ITEM: " +
		string_upper(_stct_old_item._str_item_name) +
		" | UID: " +
		string(_stct_old_item._uid_item) +
		" | HOLDER: " +
		string_upper(_stct_target_unit._str_beast_name) +
		" | BEAST UID: " +
		string(_stct_target_unit._uid_beast),
		"INFO",
		"SCR_INVENTORY_UNEQUIP_HELD_ITEM"
	);

	return true;
}