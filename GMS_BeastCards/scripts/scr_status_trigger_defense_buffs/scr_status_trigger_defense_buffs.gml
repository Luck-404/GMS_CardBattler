//===============================================================================//
//
// SCRIPT: scr_status_trigger_defense_buffs
// FUNCTION: Resolves reactive effects after a Beast is successfully
//           struck by an enemy Attack damage instance.
//
//===============================================================================//

function scr_status_trigger_defense_buffs(
	_ref_defender,
	_ref_attacker,
	_stct_card
){

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

	//------------------//
	//OPPOSING TEAM ONLY//
	//------------------//
	if (_ref_attacker._str_team == _ref_defender._str_team){
		return false;
	}

	//----------------//
	//ATTACKS ONLY//
	//----------------//
	if (_stct_card._str_card_type != "ATTACK"){
		return false;
	}

	//-------------------------//
	//IGNORE REACTIVE REENTRY//
	//-------------------------//
	if (global.flag_frozen_curse_triggering){
		return false;
	}

	var _flag_triggered =
		false;

	//-------------//
	//FROZEN ARMOR//
	//-------------//
	if (
		scr_status_trigger_frozen_armor(
			_ref_defender,
			_ref_attacker
		)
	){
		_flag_triggered = true;
	}

	//----------------//
	//STATIC BARRIER//
	//----------------//
	if (
		scr_status_trigger_static_barrier(
			_ref_defender,
			_ref_attacker
		)
	){
		_flag_triggered = true;
	}

	//-----------//
	//RAZOR SHELL//
	//-----------//
	if (
		scr_status_trigger_razor_shell(
			_ref_defender,
			_ref_attacker
		)
	){
		_flag_triggered = true;
	}

	//----------//
	//ICE MIRROR//
	//----------//
	if (
		scr_status_trigger_ice_mirror(
			_ref_defender,
			_ref_attacker
		)
	){
		_flag_triggered = true;
	}

	return _flag_triggered;
}