//===============================================================================//
//
// SCRIPT: SCR_STATUS_TRIGGER_CINDERGUARD
// FUNCTION: Checks a defending Beast for Cinderguard.
//           After successful direct enemy Attack damage, applies 1 Burn to the
//           attacker and consumes one Cinderguard charge.
//
// ARGUMENTS: _ref_defender is the Beast that was damaged.
//            _ref_attacker is the enemy Beast that dealt the damage.
// RETURNS: True when Cinderguard triggered.
//
//===============================================================================//

function scr_status_trigger_cinderguard(_ref_defender,_ref_attacker){

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

	//==================//
	//CHECK CINDERGUARD//
	//==================//
	var _ref_cinderguard = scr_status_check("CINDERGUARD",_ref_defender);

	if (
		_ref_cinderguard == -1 ||
		!instance_exists(_ref_cinderguard)
	){
		return false;
	}

	if (_ref_cinderguard._ct_status_stacks <= 0){
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
		"CINDERGUARD",
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
	//CONSUME CHARGE//
	//================//
	if (instance_exists(_ref_cinderguard)){

		_ref_cinderguard._ct_status_stacks--;

		if (_ref_cinderguard._ct_status_stacks <= 0){
			scr_status_buff_cinderguard("DEATH",_ref_cinderguard);
		}
		else{
			scr_status_reposition(_ref_defender);
		}
	}

	return true;
}