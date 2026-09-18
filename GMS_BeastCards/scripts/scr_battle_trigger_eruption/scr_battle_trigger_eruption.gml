//===============================================================================//
//
// SCRIPT: SCR_BATTLE_TRIGGER_ERUPTION
// FUNCTION: Checks whether a target meets a supplied Burn threshold.
//           Burn is not consumed.
//           The trigger may resolve even if the triggering hit reduced the
//           target to 0 HP, provided its Burn Status still exists.
//
// ARGUMENTS: _ref_target is the Beast checked for Burn.
//            _ct_threshold is the required Burn stack count.
// RETURNS: True if ERUPTION triggers; otherwise false.
//
//===============================================================================//

function scr_battle_trigger_eruption(_ref_target,_ct_threshold){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return false;
	}

	_ct_threshold = max(
		1,
		floor(_ct_threshold)
	);

	//================//
	//GET BURN//
	//================//
	var _ref_burn = scr_status_check(
		"BURN",
		_ref_target
	);

	if (
		_ref_burn == -1 ||
		!instance_exists(_ref_burn)
	){
		return false;
	}

	//================//
	//CHECK THRESHOLD//
	//================//
	if (_ref_burn._ct_status_stacks < _ct_threshold){
		return false;
	}

	//================//
	//ERUPTION VFX//
	//================//
	scr_battle_vfx_eruption(_ref_target);

	//================//
	//ERUPTION POPUP//
	//================//
	scr_gui_spawn_popup_scrolling(
		"TEXT",
		"ERUPTION",
		undefined,
		c_red,
		_ref_target.x,
		_ref_target.y - 48
	);

	//================//
	//DEBUG ERUPTION//
	//================//
	scr_debug_log_battle_trigger(
		"ERUPTION",
		global.ref_caster_beast,
		_ref_target,
		"BURN: " +
		string(_ref_burn._ct_status_stacks) +
		" | THRESHOLD: " +
		string(_ct_threshold) +
		" | BURN CONSUMED: 0",
		"SCR_BATTLE_TRIGGER_ERUPTION"
	);

	return true;
}