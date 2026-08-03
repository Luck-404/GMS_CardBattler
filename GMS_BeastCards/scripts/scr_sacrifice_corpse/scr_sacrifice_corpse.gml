//===============================================================================//
//
// SCRIPT: SCR_SACRIFICE_CORPSE
// FUNCTION: Consumes a selected dead Beast as a corpse resource.
//           Leaves the corpse instance in the graveyard for stable positioning.
//           Prevents the corpse from being used again.
//
//===============================================================================//

function scr_sacrifice_corpse(_ref_corpse){

	if (!instance_exists(_ref_corpse)){
		return false;
	}

	if (_ref_corpse._str_list != "DEAD"){
		return false;
	}

	if (_ref_corpse._val_cur_hp > 0){
		return false;
	}

	if (_ref_corpse._flag_captured){
		return false;
	}

	if (_ref_corpse._flag_corpse_consumed){
		return false;
	}

	//----------------//
	//CONSUME CORPSE//
	//----------------//
	_ref_corpse._flag_corpse_consumed = true;

	scr_spawn_popup_scrolling(
		"TEXT",
		"CORPSE RECYCLED",
		undefined,
		c_green,
		_ref_corpse.x,
		_ref_corpse.y - 48
	);

	return true;
}