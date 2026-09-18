//===============================================================================//
//
// SCRIPT: SCR_STATUS_TRIGGER_BURNING_THORNS
// FUNCTION: Checks a defending Beast for Burning Thorns.
//           After successful direct enemy Attack damage, applies 1 Burn
//           to the attacker and consumes Burning Thorns.
//
// ARGUMENTS: _ref_defender is the Beast that was damaged.
//            _ref_attacker is the enemy Beast that dealt the damage.
// RETURNS: True when Burning Thorns triggered.
//
//===============================================================================//

function scr_status_trigger_burning_thorns(_ref_defender,_ref_attacker){

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

	//--------------------//
	//OPPOSING TEAM ONLY//
	//--------------------//
	if (_ref_attacker._str_team == _ref_defender._str_team){
		return false;
	}

	//======================//
	//CHECK BURNING THORNS//
	//======================//
	var _ref_burning_thorns = scr_status_check(
		"BURNING_THORNS",
		_ref_defender
	);

	if (
		_ref_burning_thorns == -1 ||
		!instance_exists(_ref_burning_thorns)
	){
		return false;
	}

	//================//
	//STORE TARGET//
	//================//
	var _ref_original_target = global.ref_target_beast;

	//====================//
	//TARGET THE ATTACKER//
	//====================//
	global.ref_target_beast = _ref_attacker;

	//==========//
	//FEEDBACK//
	//==========//
	scr_gui_spawn_popup_scrolling(
		"TEXT",
		"BURNING THORNS",
		undefined,
		c_red,
		_ref_defender.x,
		_ref_defender.y - 48
	);

	//================//
	//APPLY 1 BURN//
	//================//
	scr_status_apply_dot("BURN");

	//================//
	//RESTORE TARGET//
	//================//
	global.ref_target_beast = _ref_original_target;

	//================//
	//CONSUME BUFF//
	//================//
	if (instance_exists(_ref_burning_thorns)){
		scr_status_buff_burning_thorns(
			"DEATH",
			_ref_burning_thorns
		);
	}

	return true;
}