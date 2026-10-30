//===============================================================================//
//
// SCRIPT: SCR_BATTLE_CHANGE_MAX_MANA
// FUNCTION: Changes the player's Maximum Mana.
//           Ordinary changes preserve the saved base Mana floor and clamp
//           Current Mana to the resulting Maximum Mana.
//           Cheat changes adjust Current and Maximum Mana together,
//           allowing testing of Mana pool sizes down to Maximum Mana 1.
//
// ARGUMENTS: _val_amount is the signed Maximum Mana change.
//            _flag_cheat_override changes both Current and Maximum Mana
//            and permits Cheat changes down to 1 Maximum Mana.
// RETURNS: The actual signed amount Maximum Mana changed.
//
//===============================================================================//

function scr_battle_change_max_mana(_val_amount,_flag_cheat_override=false){

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
	// The normal saved-base floor protects ordinary buffs. After the developer
	// deliberately lowers Max Mana below base, retain that lower floor so later
	// ordinary Mana changes cannot increase Max Mana during a negative change.
	var _val_floor = _ref_player_controller._val_saved_max_mana;
	if (_flag_cheat_override || _val_old_max_mana < _val_floor){
		_val_floor = 1;
	}

	_ref_player_controller._val_max_mana =
		max(
			_val_floor,
			_ref_player_controller._val_max_mana + _val_amount
		);

	var _val_actual_change =
		_ref_player_controller._val_max_mana -
		_val_old_max_mana;

	if (_val_actual_change == 0){
		return 0;
	}

	//==============================//
	//UPDATE CURRENT MANA AMOUNT//
	//==============================//
	// A Cheat changes the entire usable Mana pool by the same signed amount.
	// Normal Max Mana effects only clamp Current Mana when the cap shrinks.
	var _val_new_cur_mana = _val_old_cur_mana;

	if (_flag_cheat_override){
		_val_new_cur_mana += _val_actual_change;
	}

	_ref_player_controller._val_cur_mana =
		clamp(
			_val_new_cur_mana,
			0,
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
		(_flag_cheat_override ? " | CHEAT: YES" : "") +
		" | MAX: " + string(_val_old_max_mana) +
		" -> " + string(_ref_player_controller._val_max_mana) +
		" | CURRENT: " + string(_val_old_cur_mana) +
		" -> " + string(_ref_player_controller._val_cur_mana),
		"BATTLE",
		"SCR_BATTLE_CHANGE_MAX_MANA"
	);

	return _val_actual_change;
}
