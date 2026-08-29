//===============================================================================//
//
// SCRIPT: SCR_CHECK_CON_RESISTANCE
// FUNCTION: Rolls CON resistance for a DoT, Debuff, or CC application.
//           Displays feedback when the target successfully resists.
//           Returns true when the incoming status is resisted.
//
//===============================================================================//
function scr_check_con_resistance(_ref_target,_flag_ignore_resistance=false){

	if (_flag_ignore_resistance){
		return false;
	}

	if (!instance_exists(_ref_target)){
		return false;
	}

	if (_ref_target._ref_unit == undefined){
		return false;
	}

	var _val_resist_chance =
		scr_get_con_resist_chance(_ref_target);

	var _val_roll =
		irandom_range(1,100);

	if (_val_roll > _val_resist_chance){
		return false;
	}

	//----------//
	//FEEDBACK//
	//----------//
	scr_spawn_popup_scrolling(
		"TEXT",
		"RESISTED",
		undefined,
		c_black,
		_ref_target.x + irandom_range(-32,32),
		_ref_target.y - 24 + irandom_range(-32,32)
	);

	show_debug_message(
		"CON RESIST | " +
		string(_ref_target._ref_unit._str_beast_name) +
		" | CHANCE: " +
		string(_val_resist_chance) +
		"% | ROLL: " +
		string(_val_roll)
	);

	return true;
}