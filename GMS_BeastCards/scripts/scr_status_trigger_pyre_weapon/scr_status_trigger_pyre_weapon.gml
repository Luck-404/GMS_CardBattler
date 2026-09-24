//===============================================================================//
//
// SCRIPT: SCR_STATUS_TRIGGER_PYRE_WEAPON
// FUNCTION: Checks an attacking Beast for Pyre Weapon.
//           Applies the Buff's Burn magnitude once to every living enemy
//           affected by the Attack resolution.
//
// ARGUMENTS: _ref_attacker is the attacking Beast.
//            _ref_primary_target is the selected target.
//            _stct_card is the resolving Attack Card.
// RETURNS: True if at least one Burn application succeeds.
//
//===============================================================================//

function scr_status_trigger_pyre_weapon(_ref_attacker,_ref_primary_target,_stct_card){

	//-------------------//
	//VALIDATE ATTACKER//
	//-------------------//
	if (!instance_exists(_ref_attacker)){
		return false;
	}

	if (_ref_attacker._val_cur_hp <= 0){
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

	//================//
	//CHECK PYRE WEAPON//
	//================//
	var _ref_pyre_weapon = scr_status_check(
		"PYRE_WEAPON",
		_ref_attacker
	);

	if (
		_ref_pyre_weapon == -1 ||
		!instance_exists(_ref_pyre_weapon)
	){
		return false;
	}

	if (
		_ref_pyre_weapon._val_status_lifetime <= 0 ||
		_ref_pyre_weapon._str_status_command == "DEATH"
	){
		return false;
	}

	//================//
	//GET BURN AMOUNT//
	//================//
	var _ct_burn = max(
		0,
		floor(_ref_pyre_weapon._val_status_magnitude)
	);

	if (_ct_burn <= 0){
		return false;
	}

	//====================//
	//GET ATTACK TARGETS//
	//====================//
	var _arr_targets = scr_battle_get_card_preview_targets(
		_stct_card,
		_ref_primary_target
	);

	//------------------------//
	//SINGLE-TARGET FALLBACK//
	//------------------------//
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
	//APPLY BURN//
	//================//
	for (var _it_target = 0;_it_target < array_length(_arr_targets);_it_target++){

		var _ref_target = _arr_targets[_it_target];

		//----------------//
		//VALIDATE TARGET//
		//----------------//
		if (!instance_exists(_ref_target)){
			continue;
		}

		if (
			_ref_target._str_list != "ALIVE" ||
			_ref_target._val_cur_hp <= 0
		){
			continue;
		}

		//------------------//
		//ENEMY TARGETS ONLY//
		//------------------//
		if (_ref_target._str_team == _ref_attacker._str_team){
			continue;
		}


		//================//
		//APPLY BURN STACKS//
		//================//
		repeat (_ct_burn){

			if (
				instance_exists(
					scr_status_apply_dot("BURN", _ref_target)
				)
			){
				_flag_triggered = true;
			}
		}
	}


	//==========//
	//FEEDBACK//
	//==========//
	if (_flag_triggered){

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"PYRE WEAPON",
			undefined,
			c_red,
			_ref_attacker.x,
			_ref_attacker.y - 48
		);
	}

	return _flag_triggered;
}
