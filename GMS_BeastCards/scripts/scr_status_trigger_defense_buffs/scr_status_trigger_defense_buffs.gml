//===============================================================================//
//
// SCRIPT: SCR_STATUS_TRIGGER_DEFENSE_BUFFS
// FUNCTION: Resolves reactive Buff effects after a Beast is successfully
//           struck by an enemy Attack damage instance.
//
// ARGUMENTS: _ref_defender is the Beast struck, _ref_attacker is the attacking
//            Beast, and _stct_card is the Attack card that caused the hit.
// RETURNS: True when at least one defensive Buff successfully triggers.
//
//===============================================================================//

function scr_status_trigger_defense_buffs(_ref_defender,_ref_attacker,_stct_card){

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
	if (global.flag_frozen_curse_triggering){
		return false;
	}

	var _flag_triggered = false;

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

	return _flag_triggered;
}