//===============================================================================//
//
// SCRIPT: SCR_STATUS_TRIGGER_MELEE_DEFENSE_BUFFS
// FUNCTION: Resolves reactive Buffs after an enemy successfully deals
//           Melee Attack damage to a defending Beast.
//           Toxic Hide resolves before Thorns so its trigger is not lost if
//           Thorns subsequently defeats the attacker.
//           Logs each successful melee defensive trigger.
//
// ARGUMENTS: _ref_defender is the Beast struck by the Melee Attack.
//            _ref_attacker is the attacking enemy Beast.
// RETURNS: True when at least one melee defensive Buff triggers.
//
//===============================================================================//

function scr_status_trigger_melee_defense_buffs(_ref_defender,_ref_attacker){

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

	if (_ref_attacker._str_team == _ref_defender._str_team){
		return false;
	}

	var _flag_triggered = false;

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
			"SCR_STATUS_TRIGGER_MELEE_DEFENSE_BUFFS"
		);
	}

	//========//
	//THORNS//
	//========//
	if (
		instance_exists(_ref_attacker) &&
		_ref_attacker._val_cur_hp > 0
	){

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
				"SCR_STATUS_TRIGGER_MELEE_DEFENSE_BUFFS"
			);
		}
	}

	return _flag_triggered;
}