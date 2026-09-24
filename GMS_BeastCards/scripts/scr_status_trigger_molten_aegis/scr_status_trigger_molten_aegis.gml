
//===============================================================================//
//
// SCRIPT: SCR_STATUS_TRIGGER_MOLTEN_AEGIS
// FUNCTION: Checks an attacking Beast for Molten Aegis.
//           Consumes exactly 1 charge on each successfully resolved Attack.
//           Applies 1 Burn to each living Beast affected by that Attack.
//           Remaining charges persist for subsequent Attacks.
//
// ARGUMENTS: _ref_attacker is the attacking Beast.
//            _ref_primary_target is the Attack's selected primary target.
//            _stct_card is the resolving Attack Card.
// RETURNS: True when a charge is consumed; false otherwise.
//
//===============================================================================//

function scr_status_trigger_molten_aegis(_ref_attacker,_ref_primary_target,_stct_card){

	//-------------------//
	//VALIDATE ATTACKER//
	//-------------------//
	if (!instance_exists(_ref_attacker)){
		return false;
	}

	//--------------//
	//VALIDATE CARD//
	//--------------//
	if (!is_struct(_stct_card)){
		return false;
	}

	if (_stct_card._str_card_type != "ATTACK"){
		return false;
	}

	//===================//
	//CHECK MOLTEN AEGIS//
	//===================//
	var _ref_molten_aegis = scr_status_check(
		"MOLTEN_AEGIS",
		_ref_attacker
	);

	if (
		_ref_molten_aegis == -1 ||
		!instance_exists(_ref_molten_aegis)
	){
		return false;
	}

	if (_ref_molten_aegis._ct_status_stacks <= 0){
		return false;
	}

	//====================//
	//GET ATTACK TARGETS//
	//====================//
	var _arr_targets = scr_battle_get_card_preview_targets(
		_stct_card,
		_ref_primary_target
	);

	if (
		array_length(_arr_targets) <= 0 &&
		instance_exists(_ref_primary_target)
	){
		array_push(_arr_targets,_ref_primary_target);
	}

	//================//
	//CONSUME 1 CHARGE//
	//================//
	if (
		!scr_status_buff_molten_aegis(
			"CONSUME",
			_ref_molten_aegis
		)
	){
		return false;
	}

	//================//
	//APPLY 1 BURN//
	//================//
	for (var _it_target = 0;_it_target < array_length(_arr_targets);_it_target++){

		var _ref_target = _arr_targets[_it_target];

		if (!instance_exists(_ref_target)){
			continue;
		}

		if (
			_ref_target._str_list != "ALIVE" ||
			_ref_target._val_cur_hp <= 0
		){
			continue;
		}

		//----------------//
		//APPLY BURN//
		//----------------//
		scr_status_apply_dot(
			"BURN",
			_ref_target
		);
	}

	return true;
}