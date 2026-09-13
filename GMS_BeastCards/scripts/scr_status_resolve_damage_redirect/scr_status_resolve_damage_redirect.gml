//===============================================================================//
//
// SCRIPT: SCR_STATUS_RESOLVE_DAMAGE_REDIRECT
// FUNCTION: Checks whether an incoming damage target has Redirect.
//           If Redirect is valid, consumes the Status and returns the linked
//           Beast as the new damage recipient.
//           Returns the original target if no valid Redirect exists.
//
//===============================================================================//

function scr_status_resolve_damage_redirect(_ref_target){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return _ref_target;
	}

	//====================//
	//CHECK FOR REDIRECT//
	//====================//
	var _ref_redirect_status = scr_status_check("REDIRECT",_ref_target);

	if (_ref_redirect_status == -1){
		return _ref_target;
	}

	if (!instance_exists(_ref_redirect_status)){
		return _ref_target;
	}

	//===================//
	//GET LINKED TARGET//
	//===================//
	if (!variable_instance_exists(_ref_redirect_status,"_ref_status_target")){

		if (_ref_redirect_status._scr_status != undefined){
			_ref_redirect_status._scr_status("DEATH",_ref_redirect_status);
		}
		else{
			scr_status_destroy(_ref_redirect_status);
		}

		return _ref_target;
	}

	var _ref_redirect_target = _ref_redirect_status._ref_status_target;

	//================//
	//INVALID LINK//
	//================//
	if (
		!instance_exists(_ref_redirect_target) ||
		_ref_redirect_target == _ref_target ||
		_ref_redirect_target._str_list != "ALIVE" ||
		_ref_redirect_target._val_cur_hp <= 0
	){

		if (_ref_redirect_status._scr_status != undefined){
			_ref_redirect_status._scr_status("DEATH",_ref_redirect_status);
		}
		else{
			scr_status_destroy(_ref_redirect_status);
		}

		return _ref_target;
	}

	//==========//
	//FEEDBACK//
	//==========//
	scr_gui_spawn_popup_scrolling(
		"TEXT",
		"REDIRECT",
		undefined,
		c_green,
		_ref_target.x + irandom_range(-32,32),
		_ref_target.y - 24 + irandom_range(-32,32)
	);

	scr_battle_vfx_blocked(_ref_target);

	//================//
	//CONSUME STATUS//
	//================//
	if (_ref_redirect_status._scr_status != undefined){
		_ref_redirect_status._scr_status("DEATH",_ref_redirect_status);
	}
	else{
		scr_status_destroy(_ref_redirect_status);
	}

	//==================//
	//RETURN NEW TARGET//
	//==================//
	return _ref_redirect_target;
}