//===============================================================================//
//
// SCRIPT: SCR_STATUS_TRIGGER_DEFENSE_BUFFS
// FUNCTION: Resolves reactive Buff effects after a Beast is successfully
//           struck by an enemy Attack damage instance.
//
//           Toxic Hide triggers against Melee Attacks only.
//           Thorns triggers against ANY Attack, regardless of range.
//           Toxic Hide resolves before Thorns.
//
// ARGUMENTS: _ref_defender is the Beast struck.
//            _ref_attacker is the attacking Beast.
//            _stct_card is the Attack Card that caused the hit.
//
// RETURNS: True when at least one defensive effect triggers.
//
//===============================================================================//

function scr_status_trigger_defense_buffs(_ref_defender,_ref_attacker,_stct_card){

	#region VALIDATION

	//-------------------//
	//VALIDATE DEFENDER//
	//-------------------//
	if (!instance_exists(_ref_defender)){
		return false;
	}

	//-------------------//
	//VALIDATE ATTACKER//
	//-------------------//
	if (!instance_exists(_ref_attacker)){
		return false;
	}

	//----------------//
	//VALIDATE CARD//
	//----------------//
	if (!is_struct(_stct_card)){
		return false;
	}

	//--------------------//
	//OPPOSING TEAM ONLY//
	//--------------------//
	if (_ref_attacker._str_team == _ref_defender._str_team){
		return false;
	}

	//----------------//
	//ATTACKS ONLY//
	//----------------//
	if (_stct_card._str_card_type != "ATTACK"){
		return false;
	}

	//--------------------------//
	//IGNORE REACTIVE REENTRY//
	//--------------------------//
	if (
		global.flag_frozen_curse_triggering ||
		global.flag_thorns_retaliating
	){
		return false;
	}

	var _flag_triggered = false;

	#endregion

	#region EXISTING DEFENSE EFFECTS

	//============//
	//HEMOPHILIA//
	//============//
	var _ref_hemophilia = scr_status_check(
		"HEMOPHILIA",
		_ref_defender
	);

	if (
		_ref_hemophilia != -1 &&
		instance_exists(_ref_hemophilia)
	){

		if (
			scr_status_debuff_hemophilia(
				"TRIGGER",
				_ref_hemophilia
			)
		){
			_flag_triggered = true;
		}
	}

	//================//
	//FROZEN ARMOR//
	//================//
	if (scr_status_trigger_frozen_armor(_ref_defender,_ref_attacker)){
		_flag_triggered = true;
	}

	//==================//
	//STATIC BARRIER//
	//==================//
	if (scr_status_trigger_static_barrier(_ref_defender,_ref_attacker)){
		_flag_triggered = true;
	}

	//================//
	//BURNING THORNS//
	//================//
	if (scr_status_trigger_burning_thorns(_ref_defender,_ref_attacker)){
		_flag_triggered = true;
	}

	//=============//
	//CINDERGUARD//
	//=============//
	if (scr_status_trigger_cinderguard(_ref_defender,_ref_attacker)){
		_flag_triggered = true;
	}

	//================//
	//RAZOR SHELL//
	//================//
	if (scr_status_trigger_razor_shell(_ref_defender,_ref_attacker)){
		_flag_triggered = true;
	}

	//================//
	//ICE MIRROR//
	//================//
	if (scr_status_trigger_ice_mirror(_ref_defender,_ref_attacker)){
		_flag_triggered = true;
	}

	//========//
	//THORNS//
	//========//
	if (
		scr_status_trigger_thorns(
			_ref_defender,
			_ref_attacker
		)
	){

		_flag_triggered = true;

		scr_debug_log_battle_trigger(
			"THORNS",
			_ref_defender,
			_ref_attacker,
			"",
			"SCR_STATUS_TRIGGER_DEFENSE_BUFFS"
		);
	}
		
	//============//
	//TOXIC HIDE//
	//============//
	if (
		scr_status_trigger_toxic_hide(
			_ref_defender,
			_ref_attacker
		)
	){

		_flag_triggered = true;

		scr_debug_log_battle_trigger(
			"TOXIC HIDE",
			_ref_defender,
			_ref_attacker,
			"",
			"SCR_STATUS_TRIGGER_DEFENSE_BUFFS"
		);
	}	

	#endregion

	return _flag_triggered;
}