//===============================================================================//
//
// SCRIPT: SCR_USE_INVENTORY_HELD_ITEM
// FUNCTION: Equips a held item from inventory to a target party beast.
//           Unequips and returns the old held item when swapping.
//           Applies UNEQUIP and EQUIP item effects.
//           Removes the newly equipped item from inventory.
//
//===============================================================================//
function scr_use_inventory_held_item(_stct_new_item,_stct_target_unit,_val_popup_x,_val_popup_y){

	if (_stct_new_item == undefined || _stct_target_unit == undefined){
		return false;
	}

	if (_stct_new_item._str_item_type != "HELD"){
		return false;
	}

	if (_stct_new_item._scr_item == undefined){

		scr_spawn_popup_scrolling(
			"TEXT",
			"NO EFFECT",
			undefined,
			c_white,
			_val_popup_x,
			_val_popup_y
		);

		return false;
	}

	//---------------------//
	//REMOVE NEW FROM BAG//
	//---------------------//
	if (!scr_remove_item_from_inventory(_stct_new_item,1)){

		scr_spawn_popup_scrolling(
			"TEXT",
			"FAILED",
			undefined,
			c_white,
			_val_popup_x,
			_val_popup_y
		);

		return false;
	}

	//----------------//
	//UNEQUIP OLD ITEM//
	//----------------//
	var _stct_old_item = _stct_target_unit._ref_beast_held_item;

	if (_stct_old_item != undefined && _stct_old_item != "EMPTY"){

		if (_stct_old_item._scr_item != undefined){
			_stct_old_item._scr_item("UNEQUIP",_stct_old_item,_stct_target_unit);
		}

		scr_add_item_struct_to_inventory(_stct_old_item);
	}

	//---------------//
	//EQUIP NEW ITEM//
	//---------------//
	_stct_target_unit._ref_beast_held_item = _stct_new_item;

	_stct_new_item._scr_item("EQUIP",_stct_new_item,_stct_target_unit);

	//--------//
	//FEEDBACK//
	//--------//
	scr_spawn_popup_scrolling(
		"TEXT",
		"EQUIPPED",
		undefined,
		c_white,
		_val_popup_x,
		_val_popup_y
	);

	return true;
}