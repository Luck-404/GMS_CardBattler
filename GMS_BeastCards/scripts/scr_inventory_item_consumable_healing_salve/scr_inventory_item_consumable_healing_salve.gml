//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_ITEM_CONSUMABLE_HEALING_SALVE
// FUNCTION: Applies Healing Salve to a persistent Party Beast struct.
//           Restores up to 10 HP without exceeding Max HP.
//           Spawns popup feedback and returns whether the item was used.
//
// ARGUMENTS:
//     _stct_item        - Consumable item struct.
//     _stct_target_unit - Persistent Beast struct from the player's Party.
//     _val_popup_x      - Popup GUI X coordinate.
//     _val_popup_y      - Popup GUI Y coordinate.
//
// RETURNS: True if healing was applied, otherwise false.
//
//===============================================================================//

function scr_inventory_item_consumable_healing_salve(
	_stct_item,
	_stct_target_unit,
	_val_popup_x,
	_val_popup_y
){

	#region VALIDATION

	//================//
	//VALIDATE TARGET//
	//================//
	if (!is_struct(_stct_target_unit)){
		return false;
	}

	#endregion

	#region FULL HP

	//================//
	//CHECK FULL HP//
	//================//
	if (
		_stct_target_unit._val_beast_hp_cur >=
		_stct_target_unit._val_beast_hp_max
	){

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

	#endregion

	#region HEAL

	//================//
	//SNAPSHOT HP//
	//================//
	var _val_hp_before =
		_stct_target_unit
			._val_beast_hp_cur;

	//================//
	//HEAL TARGET//
	//================//
	_stct_target_unit._val_beast_hp_cur =
		min(
			_stct_target_unit
				._val_beast_hp_cur +
			10,
			_stct_target_unit
				._val_beast_hp_max
		);

	//================//
	//HEAL AMOUNT//
	//================//
	var _val_healed =
		_stct_target_unit
			._val_beast_hp_cur -
		_val_hp_before;

	#endregion

	#region FEEDBACK

	//================//
	//SPAWN FEEDBACK//
	//================//
	scr_gui_spawn_popup_scrolling(
		"TEXT",
		"+" +
		string(
			_val_healed
		) +
		" HP",
		undefined,
		c_green,
		_val_popup_x,
		_val_popup_y
	);

	#endregion

	return true;
}