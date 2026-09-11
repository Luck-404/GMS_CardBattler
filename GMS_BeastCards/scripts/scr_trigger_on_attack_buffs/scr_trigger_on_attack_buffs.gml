//===============================================================================//
//
// SCRIPT: scr_status_trigger_on_attack_buffs
// FUNCTION: Resolves Buffs and Auras that trigger when a Beast successfully
//           performs an Attack card resolution.
//
//===============================================================================//

function scr_status_trigger_on_attack_buffs(_ref_attacker,_ref_primary_target,_stct_card){

	if (!instance_exists(_ref_attacker)){
		return false;
	}

	if (!is_struct(_stct_card)){
		return false;
	}

	if (_stct_card._str_card_type != "ATTACK"){
		return false;
	}

	var _flag_triggered =
		false;

	//-------------//
	//ABYSSAL FORM//
	//-------------//
	var _ref_abyssal_form =
		scr_status_check(
			"ABYSSAL_FORM",
			_ref_attacker
		);

	if (_ref_abyssal_form != -1){

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

	//------------//
	//FROST WEAPON//
	//------------//
	if (
		scr_status_trigger_frost_weapon(
			_ref_attacker,
			_ref_primary_target,
			_stct_card
		)
	){
		_flag_triggered = true;
	}

	//---------------//
	//KRAKENS CHOSEN//
	//---------------//
	var _ref_krakens_chosen =
		scr_status_check(
			"KRAKENS_CHOSEN",
			_ref_attacker
		);

	if (_ref_krakens_chosen != -1){

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

	//----------//
	//FROSTFORM//
	//----------//
	var _ref_frostform =
		scr_status_check(
			"FROSTFORM",
			_ref_attacker
		);

	if (_ref_frostform != -1){

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

	//-------------//
	//DEEP MOMENTUM//
	//-------------//
	var _ref_deep_momentum =
		scr_status_check(
			"DEEP_MOMENTUM",
			_ref_attacker
		);

	if (_ref_deep_momentum != -1){

		if (
			scr_status_buff_deep_momentum(
				"TRIGGER",
				_ref_deep_momentum
			)
		){
			_flag_triggered = true;
		}
	}

	//------------//
	//PYRE WEAPON//
	//------------//
	// Future Vermilion equivalent.

	return _flag_triggered;
}