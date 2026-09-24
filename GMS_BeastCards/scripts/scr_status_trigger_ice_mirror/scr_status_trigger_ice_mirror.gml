//===============================================================================//
//
// SCRIPT: SCR_STATUS_TRIGGER_ICE_MIRROR
// FUNCTION: Checks a defending Beast for Ice Mirror.
//           When successfully struck by an enemy Attack, grants Armor
//           to the defender.
//
//===============================================================================//

function scr_status_trigger_ice_mirror(_ref_defender,_ref_attacker){

	//-------------------//
	//VALIDATE DEFENDER//
	//-------------------//
	if (!instance_exists(_ref_defender)){
		return false;
	}

	if (_ref_defender._val_cur_hp <= 0){
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

	//-----------------//
	//CHECK ICE MIRROR//
	//-----------------//
	var _ref_ice_mirror = scr_status_check("ICE_MIRROR",_ref_defender);

	if (_ref_ice_mirror == -1){
		return false;
	}

	if (!instance_exists(_ref_ice_mirror)){
		return false;
	}

	var _val_armor = max(0,_ref_ice_mirror._val_status_magnitude);

	if (_val_armor <= 0){
		return false;
	}

	//----------//
	//FEEDBACK//
	//----------//
	scr_gui_spawn_popup_scrolling(
		"TEXT",
		"ICE MIRROR",
		undefined,
		c_aqua,
		_ref_defender.x,
		_ref_defender.y - 48
	);

	//-----------//
	//GAIN ARMOR//
	//-----------//
	scr_battle_armor_target(
		"FIXED",
		_val_armor,
		_ref_defender
	);


	return true;
}