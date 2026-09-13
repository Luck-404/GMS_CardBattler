//===============================================================================//
//
// SCRIPT: SCR_STATUS_APPLY_DEBUFF
// FUNCTION: Attempts to apply a Debuff Status to the current target.
//           Checks target CON resistance unless explicitly bypassed.
//           Handles shared Debuff feedback, presentation, and debug logging.
//
// ARGUMENTS: _str_status_name is the Debuff ID.
//            _val_lifetime optionally overrides supported Status duration.
//            _val_magnitude optionally overrides supported Status magnitude.
//            _flag_ignore_resistance bypasses CON resistance when true.
// RETURNS: The applied Debuff Status reference, or undefined if application fails.
//
//===============================================================================//

function scr_status_apply_debuff(_str_status_name,_val_lifetime=undefined,_val_magnitude=undefined,_flag_ignore_resistance=false){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	var _ref_target = global.ref_target_beast;

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

	//================//
	//RESIST CHECK//
	//================//
	if (scr_status_check_con_resistance(_ref_target,_flag_ignore_resistance,_str_status_name)){
		return undefined;
	}

	//================//
	//APPLY STATUS//
	//================//
	var _ref_status = undefined;
	var _str_popup = undefined;
	var _c_popup = c_maroon;

	switch (_str_status_name){

		//==========//
		//BLOODLET//
		//==========//
		case "BLOODLET":

			_ref_status = scr_status_debuff_bloodlet("APPLY",undefined,_val_lifetime);

			_str_popup = "+1 BLOODLET";
			_c_popup = c_maroon;

		break;

		//======//
		//CHAR//
		//======//
		case "CHAR":

			_ref_status = scr_status_debuff_char("APPLY",undefined,_val_lifetime);

			_str_popup = "+1 CHAR";
			_c_popup = c_red;

		break;

		//==========//
		//ANTIHEAL//
		//==========//
		case "ANTIHEAL":

			_ref_status = scr_status_debuff_antiheal("APPLY",undefined,_val_lifetime);

			_str_popup = "ANTIHEAL";

		break;

		//==============//
		//FROZEN CURSE//
		//==============//
		case "FROZEN_CURSE":

			_ref_status = scr_status_debuff_frozen_curse("APPLY",undefined,_val_lifetime);

			_str_popup = "FROZEN CURSE";

		break;

		//==========//
		//WHITEOUT//
		//==========//
		case "WHITEOUT":

			_ref_status = scr_status_debuff_whiteout("APPLY",undefined,_val_lifetime,_val_magnitude);

			_str_popup = "WHITEOUT";

		break;

		//======================//
		//BRITTLE CONSTITUTION//
		//======================//
		case "BRITTLE_CONSTITUTION":

			_ref_status = scr_status_debuff_brittle_constitution("APPLY",undefined,_val_lifetime);

			_str_popup = "BRITTLE CONSTITUTION";

		break;

		//=======//
		//FOCUS//
		//=======//
		case "FOCUS":

			_ref_status = scr_status_debuff_focus("APPLY",undefined,_val_lifetime);

			_str_popup = "FOCUS";

		break;

		//=========//
		//DRAINED//
		//=========//
		case "DRAINED":

			_ref_status = scr_status_debuff_drained("APPLY",undefined,_val_lifetime);

			_str_popup = "DRAINED";

		break;

		//============//
		//ARMORBREAK//
		//============//
		case "ARMORBREAK":

			_ref_status = scr_status_debuff_armorbreak("APPLY",undefined,_val_lifetime);

			_str_popup = "ARMORBREAK";

		break;

		//==================//
		//CRIPPLING VINES//
		//==================//
		case "CRIPPLING_VINES":

			_ref_status = scr_status_debuff_crippling_vines("APPLY",undefined,_val_lifetime);

			_str_popup = "CRIPPLING VINES";

		break;

		//==========//
		//WEAKNESS//
		//==========//
		case "WEAKNESS":

			_ref_status = scr_status_debuff_weakness("APPLY",undefined,_val_lifetime);

			_str_popup = "WEAKNESS";
			_c_popup = c_black;

		break;

		//========//
		//WITHER//
		//========//
		case "WITHER":

			_ref_status = scr_status_debuff_wither("APPLY",undefined,_val_lifetime);

			_str_popup = "WITHER";

		break;

		//============//
		//VULNERABLE//
		//============//
		case "VULNERABLE":

			_ref_status = scr_status_debuff_vulnerable("APPLY",undefined,_val_lifetime);

			_str_popup = "VULNERABLE";

		break;
	}

	//-------------------------//
	//VALIDATE APPLIED STATUS//
	//-------------------------//
	if (!instance_exists(_ref_status)){
		return undefined;
	}

	//================//
	//DEBUFF FEEDBACK//
	//================//
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

	//=====================//
	//DEBUFF PRESENTATION//
	//=====================//
	var _snd_sfx = snd_battle_debuff;

	//------------------------//
	//ONLY PLAY ONCE PER CAST//
	//------------------------//
	if (instance_exists(global.ref_cast_card)){

		if (global.ref_cast_card._flag_debuff_sfx_played){
			_snd_sfx = undefined;
		}
		else{
			global.ref_cast_card._flag_debuff_sfx_played = true;
		}
	}

	//--------------------//
	//PLAY GENERIC DEBUFF//
	//--------------------//
	scr_battle_vfx(
		_ref_target,
		spr_battle_vfx_debuff,
		undefined,
		undefined,
		0,
		0,
		1,
		0,
		_snd_sfx
	);

	//==================//
	//DEBUG APPLICATION//
	//==================//
	scr_debug_log_status_application(
		_ref_target,
		_ref_status,
		_ct_previous_stacks,
		_val_previous_lifetime,
		"SCR_STATUS_APPLY_DEBUFF"
	);

	return _ref_status;
}