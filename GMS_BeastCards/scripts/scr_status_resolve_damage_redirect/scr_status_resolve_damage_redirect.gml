//===============================================================================//
//
// SCRIPT: SCR_STATUS_RESOLVE_DAMAGE_REDIRECT
// FUNCTION: Checks whether an incoming damage target has Redirect.
//           If Redirect is valid, consumes the linked Statuses and returns the
//           guarding Beast as the new damage recipient.
//           Grants any trigger-based Rage stored by the Redirect.
//           Returns the original target if no valid Redirect exists.
//
// ARGUMENTS: _ref_target is the Beast originally receiving the damage.
// RETURNS: Effective Beast that should receive the damage.
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

		scr_status_buff_redirect("DEATH",_ref_redirect_status);

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

		scr_status_buff_redirect("DEATH",_ref_redirect_status);

		return _ref_target;
	}

	//===================//
	//GET TRIGGER PAYOFF//
	//===================//
	var _ct_rage_gain = 0;

	if (variable_instance_exists(_ref_redirect_status,"_ct_redirect_rage_gain")){
		_ct_rage_gain = max(0,floor(_ref_redirect_status._ct_redirect_rage_gain));
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
	//CONSUME LINK//
	//================//
	scr_status_buff_redirect("DEATH",_ref_redirect_status);

	//================//
	//GAIN RAGE//
	//================//
	if (_ct_rage_gain > 0){
		scr_status_gain_rage(_ref_redirect_target,_ct_rage_gain);
	}

	//==================//
	//RETURN NEW TARGET//
	//==================//
	return _ref_redirect_target;
}