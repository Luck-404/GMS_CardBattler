//===============================================================================//
//
// SCRIPT: SCR_STATUS_TRIGGER_ATTACK_STATUSES
// FUNCTION: Resolves Buffs and Auras triggered when a Beast resolves an Attack.
//
// ARGUMENTS: _ref_attacker is the Beast that resolved the Attack.
//            _ref_primary_target is the Attack's selected primary target.
//            _stct_card is the resolved Attack Card struct.
// RETURNS: True when at least one Status successfully triggers.
//
//===============================================================================//

function scr_status_trigger_attack_statuses(_ref_attacker,_ref_primary_target,_stct_card){

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

	var _flag_triggered = false;

	//================//
	//FLAMING LASHES//
	//================//
	var _ref_flaming_lashes = scr_status_check(
		"FLAMING_LASHES",
		_ref_attacker
	);

	if (
		_ref_flaming_lashes != -1 &&
		instance_exists(_ref_flaming_lashes)
	){

		if (
			scr_status_buff_flaming_lashes(
				"TRIGGER",
				_ref_flaming_lashes
			)
		){
			_flag_triggered = true;
		}
	}

	//================//
	//FURNACE HEART//
	//================//
	var _ref_furnace_heart = scr_status_check("FURNACE_HEART",_ref_attacker);

	if (
		_ref_furnace_heart != -1 &&
		instance_exists(_ref_furnace_heart) &&
		_ref_furnace_heart._flag_furnace_heart_charged
	){

		if (
			scr_status_buff_furnace_heart(
				"TRIGGER",
				_ref_furnace_heart,
				undefined,
				_ref_primary_target
			)
		){
			_flag_triggered = true;
		}
	}

	//===============//
	//ABYSSAL FORM//
	//===============//
	var _ref_abyssal_form = scr_status_check("ABYSSAL_FORM",_ref_attacker);

	if (
		_ref_abyssal_form != -1 &&
		instance_exists(_ref_abyssal_form)
	){

		if (
			scr_status_buff_abyssal_form(
				"TRIGGER",
				_ref_abyssal_form,
				undefined,
				undefined,
				_ref_primary_target
			)
		){
			_flag_triggered = true;
		}
	}

	//==============//
	//FROST WEAPON//
	//==============//
	if (
		scr_status_trigger_frost_weapon(
			_ref_attacker,
			_ref_primary_target,
			_stct_card
		)
	){
		_flag_triggered = true;
	}

	//==============//
	//MOLTEN AEGIS//
	//==============//
	if (
		scr_status_trigger_molten_aegis(
			_ref_attacker,
			_ref_primary_target,
			_stct_card
		)
	){
		_flag_triggered = true;
	}

	//=============//
	//BLOODCOATED//
	//=============//
	var _ref_bloodcoated = scr_status_check("BLOODCOATED",_ref_attacker);

	if (
		_ref_bloodcoated != -1 &&
		instance_exists(_ref_bloodcoated)
	){

		if (
			scr_status_buff_bloodcoated(
				"TRIGGER",
				_ref_bloodcoated,
				undefined,
				undefined,
				_ref_primary_target,
				_stct_card
			)
		){

			_flag_triggered = true;

			scr_debug_log_battle_trigger(
				"BLOODCOATED",
				_ref_attacker,
				_ref_primary_target,
				"ATTACK APPLIED BLEED",
				"SCR_STATUS_TRIGGER_ATTACK_STATUSES"
			);
		}
	}

	//=================//
	//KRAKENS CHOSEN//
	//=================//
	var _ref_krakens_chosen = scr_status_check("KRAKENS_CHOSEN",_ref_attacker);

	if (
		_ref_krakens_chosen != -1 &&
		instance_exists(_ref_krakens_chosen)
	){

		if (
			scr_status_aura_krakens_chosen(
				"TRIGGER",
				_ref_krakens_chosen,
				undefined,
				_ref_primary_target,
				undefined,
				_stct_card
			)
		){
			_flag_triggered = true;
		}
	}

	//============//
	//FROSTFORM//
	//============//
	var _ref_frostform = scr_status_check("FROSTFORM",_ref_attacker);

	if (
		_ref_frostform != -1 &&
		instance_exists(_ref_frostform)
	){

		if (
			scr_status_aura_frostform(
				"TRIGGER",
				_ref_frostform,
				undefined,
				_ref_primary_target
			)
		){
			_flag_triggered = true;
		}
	}

	//===============//
	//DEEP MOMENTUM//
	//===============//
	var _ref_deep_momentum = scr_status_check("DEEP_MOMENTUM",_ref_attacker);

	if (
		_ref_deep_momentum != -1 &&
		instance_exists(_ref_deep_momentum)
	){

		if (
			scr_status_buff_deep_momentum(
				"TRIGGER",
				_ref_deep_momentum
			)
		){
			_flag_triggered = true;
		}
	}

	//=======//
	//LEECH//
	//=======//
	/*
		This callback runs after every Attack resolution, even when
		Leech is inactive, to advance the damage-result cursor.
	*/

	var _ref_leech = scr_status_check("LEECH",_ref_attacker);

	if (
		scr_status_buff_leech(
			"TRIGGER",
			_ref_leech,
			undefined,
			undefined,
			_ref_attacker,
			_stct_card
		)
	){

		_flag_triggered = true;

		scr_debug_log_battle_trigger(
			"LEECH",
			_ref_attacker,
			_ref_attacker,
			"ATTACK HP DAMAGE CONVERTED TO HEALING",
			"SCR_STATUS_TRIGGER_ATTACK_STATUSES"
		);
	}

	//===========//
	//PYRE WEAPON//
	//===========//
	if (
		scr_status_trigger_pyre_weapon(
			_ref_attacker,
			_ref_primary_target,
			_stct_card
		)
	){
		_flag_triggered = true;
	}

	return _flag_triggered;
}