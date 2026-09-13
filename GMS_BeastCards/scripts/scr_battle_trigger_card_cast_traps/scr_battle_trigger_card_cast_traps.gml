//===============================================================================//
//
// SCRIPT: SCR_BATTLE_TRIGGER_CARD_CAST_TRAPS
// FUNCTION: Checks Traps attached to a Beast after it successfully casts a card.
//           Activates the first valid enemy CASTING Trap in the AFTER phase.
//
// ARGUMENTS: _ref_caster is the Beast that cast the card, _ref_target is the
//            card target, and _stct_card is the card that successfully resolved.
// RETURNS: True when the triggered Trap reports success; otherwise false.
//
//===============================================================================//

function scr_battle_trigger_card_cast_traps(_ref_caster,_ref_target,_stct_card){

	//-----------------//
	//VALIDATE CASTER//
	//-----------------//
	if (!instance_exists(_ref_caster)){
		return false;
	}

	if (!is_struct(_stct_card)){
		return false;
	}

	if (!variable_instance_exists(_ref_caster,"_list_traps")){
		return false;
	}

	if (!ds_exists(_ref_caster._list_traps,ds_type_list)){
		return false;
	}

	//======================//
	//CHECK ATTACHED TRAPS//
	//======================//
	for (var _it_trap = 0;_it_trap < ds_list_size(_ref_caster._list_traps);_it_trap++){

		var _ref_trap = ds_list_find_value(_ref_caster._list_traps,_it_trap);

		if (!instance_exists(_ref_trap)){
			continue;
		}

		if (_ref_trap._flag_triggered){
			continue;
		}

		if (_ref_trap._str_trigger_type != "CASTING"){
			continue;
		}

		if (_ref_trap._str_trigger_phase != "AFTER"){
			continue;
		}

		//-------------------//
		//MUST BE ENEMY TRAP//
		//-------------------//
		if (_ref_caster._str_team == _ref_trap._str_owner_team){
			continue;
		}

		if (_ref_trap._scr_trap_callback == undefined){
			continue;
		}

		//================//
		//TRIGGER TRAP//
		//================//
		var _flag_triggered = _ref_trap._scr_trap_callback(
			"TRIGGER",
			_ref_trap,
			_ref_caster,
			_ref_target,
			_stct_card
		);

		return _flag_triggered;
	}

	return false;
}