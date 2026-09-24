//===============================================================================//
//
// SCRIPT: SCR_STATUS_APPLY_CC
// FUNCTION: Attempts to apply a Crowd Control Status to the supplied target.
//           Checks CC immunity and CON resistance before applying.
//           Plays shared CC feedback and logs successful applications.
//
// ARGUMENTS: _str_status_name is the CC ID; _ref_target is the affected Beast; _val_lifetime and _flag_ignore_resistance retain their existing purposes.
//
// RETURNS: Applied Status instance, or undefined if the application fails.
//
//===============================================================================//

function scr_status_apply_cc(_str_status_name,_ref_target,_val_lifetime=undefined,_flag_ignore_resistance=false){

	//----------------//
	//VALIDATE TARGET//
	//----------------//

	if (!instance_exists(_ref_target)){
		return undefined;
	}

	if (!is_struct(_ref_target._ref_unit)){
		return undefined;
	}

	//========================//
	//SNAPSHOT EXISTING STATUS//
	//========================//
	var _ref_existing_status = scr_status_check(_str_status_name,_ref_target);

	var _ct_previous_stacks = 0;
	var _val_previous_lifetime = undefined;

	if (_ref_existing_status != -1 && instance_exists(_ref_existing_status)){
		_ct_previous_stacks = _ref_existing_status._ct_status_stacks;
		_val_previous_lifetime = _ref_existing_status._val_status_lifetime;
	}

	//===================//
	//CHECK CC IMMUNITY//
	//===================//
	if (scr_cc_has_immunity(_ref_target)){

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"IMMUNE",
			undefined,
			c_aqua,
			_ref_target.x + irandom_range(-32,32),
			_ref_target.y - 24 + irandom_range(-32,32)
		);

		scr_debug_log(
			"BATTLE",
			"IMMUNE",
			_ref_target,
			string_upper(_ref_target._str_team) + " " +
			string_upper(_ref_target._ref_unit._str_beast_name) +
			" (LVL " + string(_ref_target._ref_unit._val_beast_level) + ")" +
			" IS IMMUNE TO " + string_upper(_str_status_name),
			"BATTLE",
			"SCR_STATUS_APPLY_CC"
		);

		return undefined;
	}

	//================//
	//RESIST CHECK//
	//================//
	if (
		scr_status_check_con_resistance(
			_ref_target,
			_flag_ignore_resistance,
			_str_status_name
		)
	){
		return undefined;
	}

	//================//
	//APPLY STATUS//
	//================//
	var _ref_status = undefined;
	var _str_popup = undefined;
	var _c_popup = c_black;

	switch (_str_status_name){

	//==========//
	//CONFUSED//
	//==========//
	case "CONFUSED":

		_ref_status = scr_status_cc_confused("APPLY", undefined, _val_lifetime, _ref_target);

		_str_popup = "CONFUSED";
		_c_popup = c_maroon;

	break;

		//========//
		//BANISH//
		//========//
		case "BANISH":

			_ref_status = scr_status_cc_banish("APPLY", undefined, _val_lifetime, _ref_target);

			_str_popup = "BANISHED";
			_c_popup = c_aqua;

		break;

		//==========//
		//FROZEN//
		//==========//
		case "FROZEN":

			_ref_status = scr_status_cc_frozen("APPLY", undefined, _val_lifetime, _ref_target);

			_str_popup = "FROZEN";
			_c_popup = c_aqua;

		break;

		//=========//
		//SLEEP//
		//=========//
		case "SLEEP":

			_ref_status = scr_status_cc_sleep("APPLY", undefined, _val_lifetime, _ref_target);

			_str_popup = "ASLEEP";

		break;

		//=========//
		//BLIND//
		//=========//
		case "BLIND":

			_ref_status = scr_status_cc_blind("APPLY", undefined, _val_lifetime, _ref_target);

			_str_popup = "BLINDED";

		break;

		//========//
		//STUN//
		//========//
		case "STUN":

			_ref_status = scr_status_cc_stun("APPLY", undefined, _val_lifetime, _ref_target);

			_str_popup = "STUNNED";

		break;
	}

	//-------------------//
	//VALIDATE APPLIED CC//
	//-------------------//
	if (!instance_exists(_ref_status)){
		return undefined;
	}

	//==========//
	//FEEDBACK//
	//==========//
	if (_str_popup != undefined){

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			_str_popup,
			undefined,
			_c_popup,
			_ref_target.x + irandom_range(-32,32),
			_ref_target.y - 24 + irandom_range(-32,32)
		);
	}

	//================//
	//CC PRESENTATION//
	//================//
	var _snd_sfx = snd_battle_cc;

	//------------------------//
	//ONLY PLAY ONCE PER CAST//
	//------------------------//
	if (instance_exists(global.ref_cast_card)){

		if (global.ref_cast_card._flag_cc_sfx_played){
			_snd_sfx = undefined;
		}
		else{
			global.ref_cast_card._flag_cc_sfx_played = true;
		}
	}

	//----------//
	//PLAY SFX//
	//----------//
	if (_snd_sfx != undefined){
		scr_battle_play_sfx(_snd_sfx);
	}

	//==================//
	//DEBUG APPLICATION//
	//==================//
	scr_debug_log_status_application(
		_ref_target,
		_ref_status,
		_ct_previous_stacks,
		_val_previous_lifetime,
		"SCR_STATUS_APPLY_CC"
	);

	return _ref_status;
}