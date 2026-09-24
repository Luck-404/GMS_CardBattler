//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_ITEM_CONSUMABLE_HEALING_SALVE
// FUNCTION: Applies Healing Salve to a target party Beast.
//           Restores up to 10 HP without exceeding Max HP.
//           Spawns popup feedback and returns whether the item was used.
//
// ARGUMENTS: _stct_item is the item struct. _stct_target_unit is the target Beast.
//            _val_popup_x and _val_popup_y are the popup GUI coordinates.
// RETURNS: True if healing was applied, otherwise false.
//
//===============================================================================//

function scr_inventory_item_consumable_healing_salve(_stct_item,_stct_target_unit,_val_popup_x,_val_popup_y){

	//================//
	//VALIDATE TARGET//
	//================//
	if (_stct_target_unit == undefined){
		return false;
	}

	//================//
	//CHECK FULL HP//
	//================//
	if (_stct_target_unit._val_cur_hp >= _stct_target_unit._val_max_hp){

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"FULL HP",
			undefined,
			c_white,
			_val_popup_x,
			_val_popup_y
		);

		return false;
	}

	//================//
	//HEAL TARGET//
	//================//
	var _val_hp_before = _stct_target_unit._val_cur_hp;

	_stct_target_unit._val_cur_hp = min(
		_stct_target_unit._val_cur_hp + 10,
		_stct_target_unit._val_max_hp
	);

	var _val_healed = _stct_target_unit._val_cur_hp - _val_hp_before;

	//================//
	//SPAWN FEEDBACK//
	//================//
	scr_gui_spawn_popup_scrolling(
		"TEXT",
		"+" + string(_val_healed) + " HP",
		undefined,
		c_green,
		_val_popup_x,
		_val_popup_y
	);

	return true;
}