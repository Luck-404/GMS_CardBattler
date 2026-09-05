//===============================================================================//
//
// SCRIPT: SCR_TRIGGER_STATIC_BARRIER
// FUNCTION: Checks a defending Beast for Static Barrier.
//           When successfully struck by an enemy Attack, applies 1 Stormstruck
//           to the attacker.
//
//===============================================================================//

function scr_trigger_static_barrier(_ref_defender,_ref_attacker){

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

	//----------------------//
	//CHECK STATIC BARRIER//
	//----------------------//
	var _ref_static_barrier =
		scr_check_for_status(
			"STATIC_BARRIER",
			_ref_defender
		);

	if (_ref_static_barrier == -1){
		return false;
	}

	//----------------------//
	//STORE CURRENT TARGET//
	//----------------------//
	var _ref_original_target =
		global.ref_target_beast;

	//--------------------//
	//TARGET THE ATTACKER//
	//--------------------//
	global.ref_target_beast =
		_ref_attacker;

	//----------//
	//FEEDBACK//
	//----------//
	scr_spawn_popup_scrolling(
		"TEXT",
		"STATIC BARRIER",
		undefined,
		c_aqua,
		_ref_defender.x,
		_ref_defender.y - 48
	);

	//-------------------//
	//APPLY STORMSTRUCK//
	//-------------------//
	scr_apply_dot_status(
		"STORMSTRUCK"
	);

	//----------------//
	//RESTORE TARGET//
	//----------------//
	if (instance_exists(_ref_original_target)){
		global.ref_target_beast =
			_ref_original_target;
	}
	else{
		global.ref_target_beast =
			_ref_defender;
	}

	return true;
}