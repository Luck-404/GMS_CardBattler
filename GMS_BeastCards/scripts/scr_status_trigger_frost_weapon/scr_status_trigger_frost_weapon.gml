//===============================================================================//
//
// SCRIPT: SCR_STATUS_TRIGGER_FROST_WEAPON
// FUNCTION: Checks an attacking Beast for Frost Weapon.
//           Applies the Buff's Frostbite magnitude once to every living Beast
//           affected by the Attack resolution.
//
// ARGUMENTS: _ref_attacker, _ref_primary_target, _stct_card.
// RETURNS: True when the Frost Weapon effect triggers; false otherwise.
//
//===============================================================================//

function scr_status_trigger_frost_weapon(_ref_attacker,_ref_primary_target,_stct_card){

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

	//-------------------//
	//CHECK FROST WEAPON//
	//-------------------//
	var _ref_frost_weapon = scr_status_check("FROST_WEAPON",_ref_attacker);

	if (_ref_frost_weapon == -1){
		return false;
	}

	if (!instance_exists(_ref_frost_weapon)){
		return false;
	}

	var _ct_frostbite = max(0,_ref_frost_weapon._val_status_magnitude);

	if (_ct_frostbite <= 0){
		return false;
	}

	//--------------------//
	//GET ATTACK TARGETS//
	//--------------------//
	var _arr_targets = scr_battle_get_card_preview_targets(_stct_card,_ref_primary_target);

	/*
		Fallback for unusual ST Attack definitions whose target
		pattern is not represented by the normal preview helper.
	*/
	if (
		array_length(_arr_targets) <= 0 &&
		instance_exists(_ref_primary_target)
	){
		array_push(_arr_targets,_ref_primary_target);
	}

	if (array_length(_arr_targets) <= 0){
		return false;
	}

	var _flag_triggered = false;

	//================//
	//APPLY FROSTBITE//
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

		if (_ref_target._str_team == _ref_attacker._str_team){
			continue;
		}


		//-----------------//
		//APPLY FROSTBITE//
		//-----------------//
		repeat (_ct_frostbite){
			scr_status_apply_dot("FROSTBITE", _ref_target);
		}

		_flag_triggered = true;
	}


	//----------//
	//FEEDBACK//
	//----------//
	if (_flag_triggered){

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"FROST WEAPON",
			undefined,
			c_aqua,
			_ref_attacker.x,
			_ref_attacker.y - 48
		);
	}

	return _flag_triggered;
}
