//===============================================================================//
//
// SCRIPT: SCR_BATTLE_CHANGE_MAX_MANA
// FUNCTION: Changes the player's Maximum Mana.
//           Prevents temporary reductions from dropping below saved base Mana,
//           clamps Current Mana when Maximum Mana falls, and logs the change.
//
// ARGUMENTS: _val_amount is the signed Maximum Mana change.
// RETURNS: The actual signed amount Maximum Mana changed.
//
//===============================================================================//

function scr_battle_change_max_mana(_val_amount){

	//================//
	//VALIDATE SYSTEM//
	//================//
	if (!instance_exists(obj_battle_player_controller)){
		return 0;
	}

	if (_val_amount == 0){
		return 0;
	}

	//================//
	//STORE OLD VALUES//
	//================//
	var _ref_player_controller = obj_battle_player_controller;

	var _val_old_max_mana = _ref_player_controller._val_max_mana;
	var _val_old_cur_mana = _ref_player_controller._val_cur_mana;

	//===================//
	//CHANGE MAXIMUM MANA//
	//===================//
	_ref_player_controller._val_max_mana =
		max(
			_ref_player_controller._val_saved_max_mana,
			_ref_player_controller._val_max_mana + _val_amount
		);

	var _val_actual_change =
		_ref_player_controller._val_max_mana -
		_val_old_max_mana;

	if (_val_actual_change == 0){
		return 0;
	}

	//================//
	//CLAMP CURRENT//
	//================//
	_ref_player_controller._val_cur_mana =
		min(
			_ref_player_controller._val_cur_mana,
			_ref_player_controller._val_max_mana
		);

	//================//
	//REFRESH MANA HUD//
	//================//
	scr_battle_reposition_mana();

	//================//
	//DEBUG MANA CHANGE//
	//================//
	var _str_change = string(_val_actual_change);

	if (_val_actual_change > 0){
		_str_change = "+" + _str_change;
	}

	scr_debug_log(
		"BATTLE",
		"MANA",
		_ref_player_controller,
		"PLAYER MAXIMUM MANA CHANGED " + _str_change +
		" | MAX: " + string(_val_old_max_mana) +
		" -> " + string(_ref_player_controller._val_max_mana) +
		" | CURRENT: " + string(_val_old_cur_mana) +
		" -> " + string(_ref_player_controller._val_cur_mana),
		"BATTLE",
		"SCR_BATTLE_CHANGE_MAX_MANA"
	);

	return _val_actual_change;
}