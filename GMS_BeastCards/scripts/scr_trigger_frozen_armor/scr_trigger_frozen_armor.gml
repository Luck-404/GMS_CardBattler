//===============================================================================//
//
// SCRIPT: SCR_TRIGGER_FROZEN_ARMOR
// FUNCTION: Checks a defending Beast for Frozen Armor.
//           When successfully struck by an enemy Attack, applies 1 Frostbite
//           to the attacker.
//
//===============================================================================//

function scr_trigger_frozen_armor(_ref_defender,_ref_attacker){

	if (!instance_exists(_ref_defender)){
		return false;
	}

	if (!instance_exists(_ref_attacker)){
		return false;
	}

	if (_ref_attacker._val_cur_hp <= 0){
		return false;
	}

	//-------------------//
	//MUST BE AN ENEMY//
	//-------------------//
	if (_ref_attacker._str_team == _ref_defender._str_team){
		return false;
	}

	//---------------------//
	//CHECK FROZEN ARMOR//
	//---------------------//
	var _ref_frozen_armor =
		scr_check_for_status(
			"FROZEN_ARMOR",
			_ref_defender
		);

	if (_ref_frozen_armor == -1){
		return false;
	}

	//----------------------//
	//STORE CURRENT TARGET//
	//----------------------//
	var _ref_original_target =
		global.ref_target_beast;

	//--------------------//
	//TARGET THE ATTACKER//
	//--------------------//
	global.ref_target_beast =
		_ref_attacker;

	//----------//
	//FEEDBACK//
	//----------//
	scr_spawn_popup_scrolling(
		"TEXT",
		"FROZEN ARMOR",
		undefined,
		c_aqua,
		_ref_defender.x,
		_ref_defender.y - 48
	);

	//----------------//
	//APPLY FROSTBITE//
	//----------------//
	scr_apply_dot_status(
		"FROSTBITE"
	);

	//----------------//
	//RESTORE TARGET//
	//----------------//
	if (instance_exists(_ref_original_target)){
		global.ref_target_beast =
			_ref_original_target;
	}
	else{
		global.ref_target_beast =
			_ref_defender;
	}

	return true;
}