//===============================================================================//
//
// SCRIPT: SCR_BATTLE_SACRIFICE_CORPSE
// FUNCTION: Consumes a selected dead Beast as a corpse resource.
//           Leaves the corpse instance in the graveyard for stable positioning,
//           prevents the corpse from being consumed again, and logs the
//           successful sacrifice.
//
// ARGUMENTS: _ref_corpse is the dead battle Beast being consumed.
// RETURNS: True when the corpse is successfully consumed; otherwise false.
//
//===============================================================================//

function scr_battle_sacrifice_corpse(_ref_corpse){

	//================//
	//VALIDATION//
	//================//

	//-----------------//
	//VALIDATE CORPSE//
	//-----------------//
	if (!instance_exists(_ref_corpse)){
		return false;
	}

	if (!is_struct(_ref_corpse._ref_unit)){
		return false;
	}

	if (_ref_corpse._str_list != "DEAD"){
		return false;
	}

	if (_ref_corpse._val_cur_hp > 0){
		return false;
	}

	if (_ref_corpse._flag_captured){
		return false;
	}

	if (_ref_corpse._flag_corpse_consumed){
		return false;
	}

	//==================//
	//CORPSE SACRIFICE//
	//==================//

	//----------------//
	//CONSUME CORPSE//
	//----------------//
	_ref_corpse._flag_corpse_consumed = true;

	//================//
	//FEEDBACK//
	//================//

	//----------------//
	//EXPEND FEEDBACK//
	//----------------//
	scr_battle_vfx_expend(_ref_corpse);

	scr_gui_spawn_popup_scrolling(
		"TEXT",
		"CORPSE RECYCLED",
		undefined,
		c_green,
		_ref_corpse.x,
		_ref_corpse.y - 48
	);

	//================//
	//DEBUG SACRIFICE//
	//================//
	var _str_source = "SYSTEM";

	if (
		instance_exists(global.ref_cast_card) &&
		is_struct(global.ref_cast_card._ref_card)
	){
		_str_source = string_upper(
			global.ref_cast_card._ref_card._str_card_name
		);
	}

	scr_debug_log(
		"BATTLE",
		"SACRIFICE",
		_ref_corpse,
		string_upper(_ref_corpse._str_team) + " " +
		string_upper(_ref_corpse._ref_unit._str_beast_name) +
		" (LVL " + string(_ref_corpse._ref_unit._val_beast_level) + ")" +
		" CORPSE SACRIFICED" +
		" | SOURCE: " + _str_source,
		"BATTLE",
		"SCR_BATTLE_SACRIFICE_CORPSE"
	);

	return true;
}