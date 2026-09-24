//===============================================================================//
//
// SCRIPT: SCR_STATUS_TRIGGER_MELTING_ARMAMENTS
// FUNCTION: Destroys up to its status magnitude of Armor on a qualifying
//           hostile Attack hit, before normal damage allocation. Does not deal
//           direct damage or trigger damage reactions; retains original feedback.
//
// ARGUMENTS: _ref_attacker - source Beast; _ref_target - damage recipient.
//            _stct_card - resolving Attack Card struct.
// RETURNS: Actual Armor destroyed (numeric).
//
//===============================================================================//

function scr_status_trigger_melting_armaments(_ref_attacker,_ref_target,_stct_card){

	//================//
	//VALIDATION//
	//================//
	if (!instance_exists(_ref_attacker)){
		return 0;
	}

	if (!instance_exists(_ref_target)){
		return 0;
	}

	if (!is_struct(_stct_card)){
		return 0;
	}

	//----------------//
	//ATTACKS ONLY//
	//----------------//
	if (_stct_card._str_card_type != "ATTACK"){
		return 0;
	}

	//--------------------//
	//OPPOSING TEAM ONLY//
	//--------------------//
	if (_ref_attacker._str_team == _ref_target._str_team){
		return 0;
	}

	if (_ref_target._val_cur_hp <= 0){
		return 0;
	}

	//================//
	//CHECK ARMOR//
	//================//
	if (_ref_target._val_armor <= 0){
		return 0;
	}

	//========================//
	//CHECK MELTING ARMAMENTS//
	//========================//
	var _ref_status = scr_status_check(
		"MELTING_ARMAMENTS",
		_ref_attacker
	);

	if (
		_ref_status == -1 ||
		!instance_exists(_ref_status)
	){
		return 0;
	}

	if (_ref_status._val_status_lifetime <= 0){
		return 0;
	}

	//========================//
	//CALCULATE ARMOR DAMAGE//
	//========================//
	var _stct_armor_result = scr_battle_destroy_armor(
		_ref_target,
		max(0,_ref_status._val_status_magnitude)
	);

	var _val_armor_destroyed = _stct_armor_result._val_armor_removed;

	if (_val_armor_destroyed <= 0){
		return 0;
	}

	//================//
	//FEEDBACK//
	//================//
	scr_gui_spawn_popup_scrolling(
		"TEXT",
		"-" + string(_val_armor_destroyed) + " ARMOR",
		undefined,
		c_blue,
		_ref_target.x + irandom_range(-32,32),
		_ref_target.y - 24 + irandom_range(-32,32)
	);

	//================//
	//ARMOR BREAK VFX//
	//================//
	if (_stct_armor_result._flag_armor_broken){

		scr_battle_vfx(
			_ref_target,
			spr_battle_vfx_armor_break,
			undefined,
			undefined,
			4,
			4,
			1,
			0,
			snd_battle_armor_break
		);
	}

	return _val_armor_destroyed;
}
