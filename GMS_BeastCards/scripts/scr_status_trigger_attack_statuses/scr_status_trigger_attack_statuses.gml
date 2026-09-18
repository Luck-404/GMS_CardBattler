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
				_ref_primary_target
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

	//==============//
	//PYRE WEAPON//
	//==============//
	// Future Vermilion equivalent.

	return _flag_triggered;
}