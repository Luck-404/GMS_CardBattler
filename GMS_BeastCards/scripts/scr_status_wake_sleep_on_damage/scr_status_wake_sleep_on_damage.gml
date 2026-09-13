//===============================================================================//
//
// SCRIPT: SCR_STATUS_WAKE_SLEEP_ON_DAMAGE
// FUNCTION: Immediately removes Sleep after a Beast takes direct damage.
//           Intended for direct-damage helpers only; DoT damage does not wake
//           Sleep.
//
// ARGUMENTS: _ref_target is the Beast that received direct damage.
// RETURNS: True when Sleep was found and removed; otherwise false.
//
//===============================================================================//

function scr_status_wake_sleep_on_damage(_ref_target){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return false;
	}

	//================//
	//CHECK SLEEP//
	//================//
	var _ref_sleep = scr_status_check("SLEEP",_ref_target);

	if (_ref_sleep == -1){
		return false;
	}

	if (!instance_exists(_ref_sleep)){
		return false;
	}

	//================//
	//WAKE FEEDBACK//
	//================//
	if (_ref_target._val_cur_hp > 0){

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"WOKE UP",
			undefined,
			c_white,
			_ref_target.x + irandom_range(-32,32),
			_ref_target.y - 24 + irandom_range(-32,32)
		);
	}

	//================//
	//REMOVE SLEEP//
	//================//
	if (_ref_sleep._scr_status != undefined){
		_ref_sleep._scr_status("DEATH",_ref_sleep);
	}
	else{
		scr_status_destroy(_ref_sleep);
	}

	return true;
}