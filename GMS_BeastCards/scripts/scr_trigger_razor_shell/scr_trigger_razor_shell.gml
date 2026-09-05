//===============================================================================//
//
// SCRIPT: SCR_TRIGGER_RAZOR_SHELL
// FUNCTION: Checks a defending Beast for Razor Shell.
//           When successfully struck by an enemy Attack, deals fixed NEU
//           damage to the attacker.
//
//===============================================================================//

function scr_trigger_razor_shell(_ref_defender,_ref_attacker){

	if (!instance_exists(_ref_defender)){
		return false;
	}

	if (!instance_exists(_ref_attacker)){
		return false;
	}

	if (_ref_attacker._val_cur_hp <= 0){
		return false;
	}

	//-------------------//
	//MUST BE AN ENEMY//
	//-------------------//
	if (_ref_attacker._str_team == _ref_defender._str_team){
		return false;
	}

	//------------------//
	//CHECK RAZOR SHELL//
	//------------------//
	var _ref_razor_shell =
		scr_check_for_status(
			"RAZOR_SHELL",
			_ref_defender
		);

	if (_ref_razor_shell == -1){
		return false;
	}

	//----------//
	//FEEDBACK//
	//----------//
	scr_spawn_popup_scrolling(
		"TEXT",
		"RAZOR SHELL",
		undefined,
		c_white,
		_ref_defender.x,
		_ref_defender.y - 48
	);

	//--------------------//
	//DEAL RETALIATION//
	//--------------------//
	scr_damage_target_minion(
		_ref_razor_shell._val_status_magnitude,
		_ref_attacker
	);

	return true;
}