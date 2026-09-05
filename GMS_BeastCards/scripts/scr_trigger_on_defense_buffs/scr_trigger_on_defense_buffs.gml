//===============================================================================//
//
// SCRIPT: SCR_TRIGGER_ON_DEFENSE_BUFFS
// FUNCTION: Resolves general Buffs that trigger when a Beast is successfully
//           struck by an enemy Attack damage instance.
//
//===============================================================================//

function scr_trigger_on_defense_buffs(_ref_defender,_ref_attacker){

	if (!instance_exists(_ref_defender)){
		return false;
	}

	if (!instance_exists(_ref_attacker)){
		return false;
	}

	if (_ref_attacker._str_team == _ref_defender._str_team){
		return false;
	}

	var _flag_triggered =
		false;

	//-------------//
	//FROZEN ARMOR//
	//-------------//
	if (
		scr_trigger_frozen_armor(
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
		scr_trigger_static_barrier(
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
		scr_trigger_razor_shell(
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
		scr_trigger_ice_mirror(
			_ref_defender,
			_ref_attacker
		)
	){
		_flag_triggered = true;
	}

	return _flag_triggered;
}