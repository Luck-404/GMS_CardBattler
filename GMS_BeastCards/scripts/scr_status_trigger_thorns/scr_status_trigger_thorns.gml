//===============================================================================//
//
// SCRIPT: SCR_STATUS_TRIGGER_THORNS
// FUNCTION: Resolves Thorns retaliation after the host is successfully struck
//           by an enemy Melee Attack.
//           Deals the Thorns Status's stored neutral damage to the attacker.
//           Returns whether Thorns successfully triggered.
//
//===============================================================================//

function scr_status_trigger_thorns(_ref_defender,_ref_attacker){

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

	if (_ref_attacker._val_cur_hp <= 0){
		return false;
	}

	if (_ref_attacker._str_team == _ref_defender._str_team){
		return false;
	}

	//================//
	//CHECK THORNS//
	//================//
	var _ref_thorns = scr_status_check("THORNS",_ref_defender);

	if (_ref_thorns == -1){
		return false;
	}

	if (!instance_exists(_ref_thorns)){
		return false;
	}

	var _val_damage = _ref_thorns._val_status_magnitude;

	if (_val_damage <= 0){
		return false;
	}

	//==================//
	//RETALIATE DAMAGE//
	//==================//
	scr_minion_damage_target(
		_val_damage,
		_ref_attacker
	);

	//==========//
	//FEEDBACK//
	//==========//
	scr_gui_spawn_popup_scrolling(
		"TEXT",
		"THORNS",
		undefined,
		c_green,
		_ref_defender.x,
		_ref_defender.y - 48
	);

	return true;
}