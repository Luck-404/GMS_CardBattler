//===============================================================================//
//
// SCRIPT: SCR_TRIGGER_ATTACK_TRAPS
// FUNCTION: Checks Traps attached to a Beast before it resolves an Attack.
//           Activates the first valid ATTACKING Trap.
//           Returns true when the Attack should be cancelled.
//
//===============================================================================//
function scr_trigger_attack_traps(_ref_attacker,_ref_target,_stct_card){

	if (!instance_exists(_ref_attacker)){
		return false;
	}

	if (_stct_card == undefined){
		return false;
	}

	if (_stct_card._str_card_type != "ATTACK"){
		return false;
	}

	if (!variable_instance_exists(_ref_attacker,"_list_traps")){
		return false;
	}

	//-----------------------//
	//CHECK ATTACHED TRAPS//
	//-----------------------//
	for (var _it_trap = 0; _it_trap < ds_list_size(_ref_attacker._list_traps); _it_trap++){

		var _ref_trap = ds_list_find_value(_ref_attacker._list_traps,_it_trap);

		if (!instance_exists(_ref_trap)){
			continue;
		}

		if (_ref_trap._flag_triggered){
			continue;
		}

		if (_ref_trap._str_trigger_type != "ATTACKING"){
			continue;
		}

		//----------------------//
		//MUST BE ENEMY TRAP//
		//----------------------//
		if (_ref_attacker._str_team == _ref_trap._str_owner_team){
			continue;
		}

		if (_ref_trap._scr_trap == undefined){
			continue;
		}

		var _flag_cancel_attack = _ref_trap._scr_trap(
			"TRIGGER",
			_ref_trap,
			_ref_attacker,
			_ref_target,
			_stct_card
		);

		if (_flag_cancel_attack){
			return true;
		}
	}

	return false;
}