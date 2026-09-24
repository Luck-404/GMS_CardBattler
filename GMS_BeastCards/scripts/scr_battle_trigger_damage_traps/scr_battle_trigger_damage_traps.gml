//===============================================================================//
//
// SCRIPT: SCR_BATTLE_TRIGGER_DAMAGE_TRAPS
// FUNCTION: Checks Traps attached to a Beast after direct damage resolves.
//           Only checks DAMAGED / AFTER Traps.
//           Damage must reach the Beast's Armor, Overhealth, or HP.
//           Damage absorbed entirely by Minions does not qualify.
//
// ARGUMENTS: _ref_target is the Beast that received direct damage.
//            _val_damage_received is damage received by the Beast.
// RETURNS: True if a Trap triggers; otherwise false.
//
//===============================================================================//

function scr_battle_trigger_damage_traps(_ref_target,_val_damage_received){

	//================//
	//VALIDATION//
	//================//
	if (!instance_exists(_ref_target)){
		return false;
	}

	if (_val_damage_received <= 0){
		return false;
	}

	if (!ds_exists(_ref_target._list_traps,ds_type_list)){
		return false;
	}

	//===================//
	//CHECK DAMAGE TRAPS//
	//===================//
	for (var _it_trap = ds_list_size(_ref_target._list_traps) - 1;_it_trap >= 0;_it_trap--){

		var _ref_trap = ds_list_find_value(_ref_target._list_traps,_it_trap);

		if (!instance_exists(_ref_trap)){
			continue;
		}

		if (_ref_trap._ref_host != _ref_target || _ref_trap._flag_triggered){
			continue;
		}

		if (_ref_trap._str_trigger_type != "DAMAGED"){
			continue;
		}

		if (_ref_trap._str_trigger_phase != "AFTER"){
			continue;
		}

		if (!is_callable(_ref_trap._scr_trap_callback)){
			continue;
		}

		//================//
		//TRIGGER TRAP//
		//================//
		return _ref_trap._scr_trap_callback(
			"TRIGGER",
			_ref_trap,
			undefined,
			_ref_target,
			undefined
		);
	}

	return false;
}
