//===============================================================================//
//
// SCRIPT: SCR_STATUS_TRIGGER_CHAR_CONVERSION
// FUNCTION: Checks Burn after it finishes triggering.
//           If Burn meets the current Char threshold, applies exactly 1 Char.
//           Burn is not consumed.
//           Char threshold applications bypass a second CON resistance check.
//
// ARGUMENTS:   _ref_target - Beast whose Burn is checked.
//           _ct_vfx_delay - Optional delay before Char trigger presentation.
// RETURNS: True if Char triggered; otherwise false.
//
//===============================================================================//

function scr_status_trigger_char_conversion(_ref_target,_ct_vfx_delay=0){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return false;
	}

	if (_ref_target._val_cur_hp <= 0){
		return false;
	}

	//================//
	//GET BURN//
	//================//
	var _ref_burn = scr_status_check("BURN",_ref_target);

	if (_ref_burn == -1 || !instance_exists(_ref_burn)){
		return false;
	}

	//================//
	//CHECK THRESHOLD//
	//================//
	var _ct_threshold = scr_status_get_char_threshold();

	if (_ref_burn._ct_status_stacks < _ct_threshold){
		return false;
	}

	//================//
	//APPLY CHAR//
	//================//
	var _ref_char = scr_status_debuff_char("APPLY", undefined, undefined, _ref_target);


	if (!instance_exists(_ref_char)){
		return false;
	}

	//================//
	//TRIGGER FEEDBACK//
	//================//
	scr_battle_vfx_char(_ref_target,_ct_vfx_delay);

	scr_gui_spawn_popup_scrolling(
		"TEXT",
		"CHAR",
		undefined,
		c_red,
		_ref_target.x,
		_ref_target.y - 48
	);

	//================//
	//DEBUG TRIGGER//
	//================//
	scr_debug_log_battle_trigger(
		"CHAR",
		global.ref_caster_beast,
		_ref_target,
		"BURN: " + string(_ref_burn._ct_status_stacks) +
		" | THRESHOLD: " + string(_ct_threshold) +
		" | CHAR STACKS: " + string(_ref_char._ct_status_stacks) +
		" | BURN CONSUMED: 0",
		"SCR_STATUS_TRIGGER_CHAR_CONVERSION"
	);

	return true;
}