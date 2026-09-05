//===============================================================================//
//
// SCRIPT: SCR_TRIGGER_CARD_CAST_TRAPS
// FUNCTION: Checks Traps attached to a Beast after it successfully casts a card.
//           Activates the first valid CASTING Trap.
//
//===============================================================================//

function scr_trigger_card_cast_traps(_ref_caster,_ref_target,_stct_card){

	if (!instance_exists(_ref_caster)){
		return false;
	}

	if (_stct_card == undefined){
		return false;
	}

	if (!variable_instance_exists(_ref_caster,"_list_traps")){
		return false;
	}

	//-----------------------//
	//CHECK ATTACHED TRAPS//
	//-----------------------//
	for (
		var _it_trap = 0;
		_it_trap < ds_list_size(_ref_caster._list_traps);
		_it_trap++
	){

		var _ref_trap =
			ds_list_find_value(
				_ref_caster._list_traps,
				_it_trap
			);

		if (!instance_exists(_ref_trap)){
			continue;
		}

		if (_ref_trap._flag_triggered){
			continue;
		}

		if (_ref_trap._str_trigger_type != "CASTING"){
			continue;
		}

		//------------------//
		//MUST BE ENEMY TRAP//
		//------------------//
		if (_ref_caster._str_team == _ref_trap._str_owner_team){
			continue;
		}

		if (_ref_trap._scr_trap == undefined){
			continue;
		}

		var _flag_triggered =
			_ref_trap._scr_trap(
				"TRIGGER",
				_ref_trap,
				_ref_caster,
				_ref_target,
				_stct_card
			);

		if (_flag_triggered){
			return true;
		}
	}

	return false;
}