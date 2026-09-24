//===============================================================================//
//
// SCRIPT: SCR_BATTLE_TRIGGER_ATTACK_TRAPS
// FUNCTION: Checks Traps attached to a Beast before it resolves an Attack.
//           Activates the first valid ATTACKING Trap in the BEFORE phase.
//           Returns whether that Trap cancels the Attack.
//
// ARGUMENTS: _ref_attacker is the attacking Beast, _ref_target is its target,
//            and _stct_card is the Attack card being resolved.
// RETURNS: True when the triggered Trap cancels the Attack; otherwise false.
//
//===============================================================================//

function scr_battle_trigger_attack_traps(_ref_attacker,_ref_target,_stct_card){

	//-------------------//
	//VALIDATE ATTACKER//
	//-------------------//
	if (!instance_exists(_ref_attacker)){
		return false;
	}

	if (_ref_attacker._str_list != "ALIVE" || _ref_attacker._val_cur_hp <= 0){
		return false;
	}

	if (!is_struct(_stct_card)){
		return false;
	}

	if (_stct_card._str_card_type != "ATTACK"){
		return false;
	}

	if (!variable_instance_exists(_ref_attacker,"_list_traps")){
		return false;
	}

	if (!ds_exists(_ref_attacker._list_traps,ds_type_list)){
		return false;
	}

	//======================//
	//CHECK ATTACHED TRAPS//
	//======================//
	for (var _it_trap = 0;_it_trap < ds_list_size(_ref_attacker._list_traps);_it_trap++){

		var _ref_trap = ds_list_find_value(_ref_attacker._list_traps,_it_trap);

		if (!instance_exists(_ref_trap)){
			continue;
		}

		if (_ref_trap._ref_host != _ref_attacker || _ref_trap._flag_triggered){
			continue;
		}

		if (_ref_trap._str_trigger_type != "ATTACKING"){
			continue;
		}

		if (_ref_trap._str_trigger_phase != "BEFORE"){
			continue;
		}

		if (!is_callable(_ref_trap._scr_trap_callback)){
			continue;
		}

		//================//
		//TRIGGER TRAP//
		//================//
		var _flag_cancel_attack = _ref_trap._scr_trap_callback(
			"TRIGGER",
			_ref_trap,
			_ref_attacker,
			_ref_target,
			_stct_card
		);

		return _flag_cancel_attack;
	}

	return false;
}
