//===============================================================================//
//
// SCRIPT: SCR_STATUS_TRIGGER_FROZEN_ARMOR
// FUNCTION: Checks a defending Beast for Frozen Armor.
//           When successfully struck by an enemy Attack, applies 1 Frostbite
//           to the attacker.
//
//===============================================================================//

function scr_status_trigger_frozen_armor(_ref_defender,_ref_attacker){

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

	//------------------//
	//MUST BE AN ENEMY//
	//------------------//
	if (_ref_attacker._str_team == _ref_defender._str_team){
		return false;
	}

	//--------------------//
	//CHECK FROZEN ARMOR//
	//--------------------//
	var _ref_frozen_armor = scr_status_check("FROZEN_ARMOR",_ref_defender);

	if (_ref_frozen_armor == -1){
		return false;
	}

	if (!instance_exists(_ref_frozen_armor)){
		return false;
	}

	//----------------------//
	//STORE ORIGINAL TARGET//
	//----------------------//
	var _ref_original_target = global.ref_target_beast;

	//--------------------//
	//TARGET THE ATTACKER//
	//--------------------//
	global.ref_target_beast = _ref_attacker;

	//----------//
	//FEEDBACK//
	//----------//
	scr_gui_spawn_popup_scrolling(
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
	scr_status_apply_dot("FROSTBITE");

	//----------------//
	//RESTORE TARGET//
	//----------------//
	global.ref_target_beast = _ref_original_target;

	return true;
}