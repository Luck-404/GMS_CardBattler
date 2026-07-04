//===============================================================================//
//
// SCRIPT: SCR_UNEQUIP_HELD_ITEM_TO_INVENTORY
// FUNCTION: Removes a held item from a target beast.
//           Runs the item's UNEQUIP effect.
//           Returns the item struct to inventory.
//           Clears the beast held item slot.
//
//===============================================================================//
function scr_unequip_held_item_to_inventory(_stct_target_unit,_val_popup_x,_val_popup_y){

	if (_stct_target_unit == undefined){
		return false;
	}

	var _stct_old_item = _stct_target_unit._ref_beast_held_item;

	if (_stct_old_item == undefined || _stct_old_item == "EMPTY"){

		scr_spawn_popup_scrolling(
			"TEXT",
			"NO HELD ITEM",
			undefined,
			c_white,
			_val_popup_x,
			_val_popup_y
		);

		return false;
	}

	if (_stct_old_item._scr_item != undefined){
		_stct_old_item._scr_item("UNEQUIP",_stct_old_item,_stct_target_unit);
	}

	scr_add_item_struct_to_inventory(_stct_old_item);

	_stct_target_unit._ref_beast_held_item = "EMPTY";

	scr_spawn_popup_scrolling(
		"TEXT",
		"UNEQUIPPED",
		undefined,
		c_white,
		_val_popup_x,
		_val_popup_y
	);

	return true;
}