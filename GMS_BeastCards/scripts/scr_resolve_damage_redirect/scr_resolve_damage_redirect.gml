//===============================================================================//
//
// SCRIPT: SCR_RESOLVE_DAMAGE_REDIRECT
// FUNCTION: Checks whether an incoming damage target has Redirect.
//           If Redirect is valid, consumes the status and returns the linked
//           Beast as the new damage recipient.
//           Returns the original target if no valid Redirect exists.
//
//===============================================================================//
function scr_resolve_damage_redirect(_ref_target){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return _ref_target;
	}

	//-------------------//
	//CHECK FOR REDIRECT//
	//-------------------//
	var _ref_redirect_status = scr_check_for_status("REDIRECT",_ref_target);

	if (_ref_redirect_status == -1){
		return _ref_target;
	}

	//-------------------//
	//GET LINKED TARGET//
	//-------------------//
	var _ref_redirect_target =
		_ref_redirect_status._ref_status_target;

	//----------------//
	//INVALID LINK//
	//----------------//
	if (
		!instance_exists(_ref_redirect_target) ||
		_ref_redirect_target == _ref_target ||
		_ref_redirect_target._str_list != "ALIVE" ||
		_ref_redirect_target._val_cur_hp <= 0
	){

		scr_destroy_status(_ref_redirect_status);

		return _ref_target;
	}

	//----------------//
	//TRIGGER FEEDBACK//
	//----------------//
	scr_spawn_popup_scrolling(
		"TEXT",
		"REDIRECT",
		undefined,
		c_green,
		_ref_target.x + irandom_range(-32,32),
		_ref_target.y - 24 + irandom_range(-32,32)
	);

	//----------------//
	//CONSUME STATUS//
	//----------------//
	scr_destroy_status(_ref_redirect_status);

	//----------------//
	//RETURN NEW TARGET//
	//----------------//
	return _ref_redirect_target;
}