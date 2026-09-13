//===============================================================================//
//
// SCRIPT: SCR_STATUS_CHECK_CON_RESISTANCE
// FUNCTION: Rolls CON resistance for an incoming DoT, Debuff, or CC Status.
//           Displays resistance feedback and logs successful resistance.
//
// ARGUMENTS: _ref_target is the Beast receiving the Status.
//            _flag_ignore_resistance bypasses the CON resistance check.
//            _str_status_name optionally identifies the resisted Status.
// RETURNS: True when the incoming Status is resisted; otherwise false.
//
//===============================================================================//

function scr_status_check_con_resistance(_ref_target,_flag_ignore_resistance=false,_str_status_name=""){

	//===================//
	//IGNORE RESISTANCE//
	//===================//
	if (_flag_ignore_resistance){
		return false;
	}

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return false;
	}

	if (!is_struct(_ref_target._ref_unit)){
		return false;
	}

	//==========================//
	//CALCULATE RESIST CHANCE//
	//==========================//
	var _val_resist_chance = scr_status_get_con_resist_chance(_ref_target);

	if (_val_resist_chance <= 0){
		return false;
	}

	var _val_roll = irandom_range(1,100);

	if (_val_roll > _val_resist_chance){
		return false;
	}

	//==================//
	//RESIST FEEDBACK//
	//==================//
	scr_battle_vfx_resist(_ref_target);

	scr_gui_spawn_popup_scrolling(
		"TEXT",
		"RESISTED",
		undefined,
		c_black,
		_ref_target.x + irandom_range(-32,32),
		_ref_target.y - 24 + irandom_range(-32,32)
	);

	//================//
	//DEBUG RESIST//
	//================//
	var _str_status = string_upper(string(_str_status_name));

	if (_str_status == ""){
		_str_status = "STATUS";
	}

	scr_debug_log(
		"BATTLE",
		"RESIST",
		_ref_target,
		string_upper(_ref_target._str_team) + " " +
		string_upper(_ref_target._ref_unit._str_beast_name) +
		" (LVL " + string(_ref_target._ref_unit._val_beast_level) + ")" +
		" RESISTED " + _str_status +
		" | CON RESIST: " + string(_val_resist_chance) + "%" +
		" | ROLL: " + string(_val_roll),
		"BATTLE",
		"SCR_STATUS_CHECK_CON_RESISTANCE"
	);

	return true;
}