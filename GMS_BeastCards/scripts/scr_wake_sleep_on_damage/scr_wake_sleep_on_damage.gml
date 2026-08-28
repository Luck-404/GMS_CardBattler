//===============================================================================//
//
// SCRIPT: SCR_WAKE_SLEEP_ON_DAMAGE
// FUNCTION: Immediately removes Sleep after a Beast takes direct damage.
//           Intended for direct-damage helpers only.
//           DoT damage does not call this helper.
//
//===============================================================================//
function scr_wake_sleep_on_damage(_ref_target){

	if (!instance_exists(_ref_target)){
		return false;
	}

	var _ref_sleep = scr_check_for_status("SLEEP",_ref_target);

	if (_ref_sleep == -1){
		return false;
	}

	//----------------//
	//WAKE FEEDBACK//
	//----------------//
	if (_ref_target._val_cur_hp > 0){

		scr_spawn_popup_scrolling(
			"TEXT",
			"WOKE UP",
			undefined,
			c_white,
			_ref_target.x + irandom_range(-32,32),
			_ref_target.y - 24 + irandom_range(-32,32)
		);
	}

	//----------------//
	//REMOVE SLEEP//
	//----------------//
	if (_ref_sleep._scr_status != undefined){
		_ref_sleep._scr_status("DEATH",_ref_sleep);
	}
	else{
		scr_destroy_status(_ref_sleep);
	}

	return true;
}