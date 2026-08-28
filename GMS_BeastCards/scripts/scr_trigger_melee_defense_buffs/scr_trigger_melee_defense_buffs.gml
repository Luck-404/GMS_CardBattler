//===============================================================================//
//
// SCRIPT: SCR_TRIGGER_MELEE_DEFENSE_BUFFS
// FUNCTION: Resolves reactive Buffs after an enemy successfully deals
//           Melee Attack damage to a defending Beast.
//           Toxic Hide resolves before Thorns so its trigger is not lost if
//           Thorns subsequently defeats the attacker.
//
//===============================================================================//
function scr_trigger_melee_defense_buffs(_ref_defender,_ref_attacker){

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

	//------------//
	//TOXIC HIDE//
	//------------//
	if (
		scr_trigger_toxic_hide(
			_ref_defender,
			_ref_attacker
		)
	){
		_flag_triggered =
			true;
	}

	//--------//
	//THORNS//
	//--------//
	if (
		instance_exists(_ref_attacker) &&
		_ref_attacker._val_cur_hp > 0
	){

		if (
			scr_trigger_thorns(
				_ref_defender,
				_ref_attacker
			)
		){
			_flag_triggered =
				true;
		}
	}

	return _flag_triggered;
}