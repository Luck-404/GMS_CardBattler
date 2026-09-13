//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_EQUIP_HELD_ITEM
// FUNCTION: Equips a Held Item from Inventory to a target Party Beast.
//           Unequips and returns the previous Held Item when swapping.
//           Applies UNEQUIP and EQUIP effects and logs the final Held Item state.
//
// ARGUMENTS: _stct_new_item is the Held Item and _stct_target_unit is the Beast.
//            _val_popup_x/_val_popup_y are the feedback popup coordinates.
// RETURNS: True when the item is successfully equipped, otherwise false.
//
//===============================================================================//

function scr_inventory_equip_held_item(_stct_new_item,_stct_target_unit,_val_popup_x,_val_popup_y){

	//================//
	//VALIDATE ITEM//
	//================//
	if (
		_stct_new_item == undefined ||
		!is_struct(_stct_target_unit)
	){
		return false;
	}

	if (_stct_new_item._str_item_type != "HELD"){
		return false;
	}

	if (_stct_new_item._scr_item == undefined){

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"NO EFFECT",
			undefined,
			c_white,
			_val_popup_x,
			_val_popup_y
		);

		return false;
	}

	//================//
	//GET OLD ITEM//
	//================//
	var _stct_old_item = _stct_target_unit._stct_beast_held_item;

	var _str_old_item_name = "EMPTY";

	if (
		_stct_old_item != undefined &&
		_stct_old_item != "EMPTY"
	){
		_str_old_item_name = string_upper(
			_stct_old_item._str_item_name
		);
	}

	//================//
	//REMOVE NEW ITEM//
	//================//
	if (!scr_inventory_remove_item(_stct_new_item,1)){

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"FAILED",
			undefined,
			c_white,
			_val_popup_x,
			_val_popup_y
		);

		return false;
	}

	//================//
	//UNEQUIP OLD ITEM//
	//================//
	if (
		_stct_old_item != undefined &&
		_stct_old_item != "EMPTY"
	){

		if (_stct_old_item._scr_item != undefined){

			_stct_old_item._scr_item(
				"UNEQUIP",
				_stct_old_item,
				_stct_target_unit
			);
		}

		scr_inventory_add_item_struct(
			_stct_old_item
		);
	}

	//================//
	//EQUIP NEW ITEM//
	//================//
	_stct_target_unit._stct_beast_held_item = _stct_new_item;

	var _flag_equipped = _stct_new_item._scr_item(
		"EQUIP",
		_stct_new_item,
		_stct_target_unit
	);

	//================//
	//ROLL BACK FAILURE//
	//================//
	if (!_flag_equipped){

		_stct_target_unit._stct_beast_held_item = _stct_old_item;

		scr_inventory_add_item_struct(
			_stct_new_item
		);

		if (
			_stct_old_item != undefined &&
			_stct_old_item != "EMPTY"
		){

			scr_inventory_remove_item(
				_stct_old_item,
				1
			);

			if (_stct_old_item._scr_item != undefined){

				_stct_old_item._scr_item(
					"EQUIP",
					_stct_old_item,
					_stct_target_unit
				);
			}
		}

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"FAILED",
			undefined,
			c_white,
			_val_popup_x,
			_val_popup_y
		);

		scr_debug_log(
			"INVENTORY",
			"EQUIP",
			undefined,
			"HELD ITEM EQUIP FAILED" +
			" | ITEM: " +
			string_upper(_stct_new_item._str_item_name) +
			" | TARGET: " +
			string_upper(_stct_target_unit._str_beast_name) +
			" | PREVIOUS: " +
			_str_old_item_name +
			" | STATE ROLLED BACK",
			"WARNING",
			"SCR_INVENTORY_EQUIP_HELD_ITEM"
		);

		return false;
	}

	//================//
	//FEEDBACK//
	//================//
	scr_gui_spawn_popup_scrolling(
		"TEXT",
		"EQUIPPED",
		undefined,
		c_white,
		_val_popup_x,
		_val_popup_y
	);

	//================//
	//DEBUG EQUIP//
	//================//
	scr_debug_log(
		"INVENTORY",
		"EQUIP",
		undefined,
		"HELD ITEM EQUIPPED" +
		" | ITEM: " +
		string_upper(_stct_new_item._str_item_name) +
		" | UID: " +
		string(_stct_new_item._uid_item) +
		" | HOLDER: " +
		string_upper(_stct_target_unit._str_beast_name) +
		" | BEAST UID: " +
		string(_stct_target_unit._uid_beast) +
		" | PREVIOUS: " +
		_str_old_item_name,
		"INFO",
		"SCR_INVENTORY_EQUIP_HELD_ITEM"
	);

	return true;
}