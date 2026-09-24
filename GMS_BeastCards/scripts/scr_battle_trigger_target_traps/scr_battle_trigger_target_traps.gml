//===============================================================================//
//
// SCRIPT: SCR_BATTLE_TRIGGER_TARGET_TRAPS
// FUNCTION: Checks Traps attached to a Beast when that Beast is directly targeted.
//           Activates the first valid TARGETED Trap in the BEFORE phase.
//           Returns whether that Trap cancels the incoming action.
//
// ARGUMENTS: _ref_attacker is the acting Beast, _ref_target is the directly
//            targeted Beast, and _stct_card is the incoming card.
// RETURNS: True when the triggered Trap cancels the action; otherwise false.
//
//===============================================================================//

function scr_battle_trigger_target_traps(_ref_attacker,_ref_target,_stct_card){

	//------------------//
	//VALIDATE CONTEXT//
	//------------------//
	if (!instance_exists(_ref_attacker)){
		return false;
	}

	if (!instance_exists(_ref_target)){
		return false;
	}

	if (_ref_target._str_list != "ALIVE" || _ref_target._val_cur_hp <= 0){
		return false;
	}

	if (!is_struct(_stct_card)){
		return false;
	}

	if (!variable_instance_exists(_ref_target,"_list_traps")){
		return false;
	}

	if (!ds_exists(_ref_target._list_traps,ds_type_list)){
		return false;
	}

	//======================//
	//CHECK ATTACHED TRAPS//
	//======================//
	for (var _it_trap = 0;_it_trap < ds_list_size(_ref_target._list_traps);_it_trap++){

		var _ref_trap = ds_list_find_value(_ref_target._list_traps,_it_trap);

		if (!instance_exists(_ref_trap)){
			continue;
		}

		if (_ref_trap._ref_host != _ref_target || _ref_trap._flag_triggered){
			continue;
		}

		if (_ref_trap._str_trigger_type != "TARGETED"){
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
		var _flag_cancel_action = _ref_trap._scr_trap_callback(
			"TRIGGER",
			_ref_trap,
			_ref_attacker,
			_ref_target,
			_stct_card
		);

		if (_flag_cancel_action){
			scr_battle_vfx_blocked(_ref_target);
		}

		return _flag_cancel_action;
	}

	return false;
}
