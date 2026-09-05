//===============================================================================//
//
// SCRIPT: SCR_TRIGGER_ICE_MIRROR
// FUNCTION: Checks a defending Beast for Ice Mirror.
//           When successfully struck by an enemy Attack, grants Armor
//           to the defender.
//
//===============================================================================//

function scr_trigger_ice_mirror(_ref_defender,_ref_attacker){

	if (!instance_exists(_ref_defender)){
		return false;
	}

	if (!instance_exists(_ref_attacker)){
		return false;
	}

	if (_ref_attacker._str_team == _ref_defender._str_team){
		return false;
	}

	//-----------------//
	//CHECK ICE MIRROR//
	//-----------------//
	var _ref_ice_mirror =
		scr_check_for_status(
			"ICE_MIRROR",
			_ref_defender
		);

	if (_ref_ice_mirror == -1){
		return false;
	}

	//----------//
	//FEEDBACK//
	//----------//
	scr_spawn_popup_scrolling(
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
	scr_armor_target(
		_ref_ice_mirror._val_status_magnitude,
		_ref_defender
	);

	return true;
}