//===============================================================================//
//
// SCRIPT: SCR_STATUS_APPLY_AURA
// FUNCTION: Applies an Aura Status to a Beast or to that Beast's Team registry.
//		   SELF Auras remain host-bound. Team Auras register once in the
//		   PLAYER / ENEMY Team Status list while retaining their source Beast
//		   when their mechanics require one.
//
// ARGUMENTS: _str_status_name - Aura ID.
//			_ref_target - Host/source/representative Beast used by the Aura.
//			_val_magnitude - Optional Aura strength.
// RETURNS: Applied Status instance, or undefined if application fails.
//
//===============================================================================//

function scr_status_apply_aura(_str_status_name,_ref_target,_val_magnitude=0){

	//-----------------//
	//VALIDATE TARGET//
	//-----------------//
	if (!instance_exists(_ref_target)){
		return undefined;
	}

	var _str_status_upper =
		string_upper(
			string(_str_status_name)
		);

	var _flag_team_aura = false;

	switch(_str_status_upper){
		case "CALM_SEAS":
		case "HONEYED_SCENT":
		case "HUNGERING_FLAMES":
		case "ROUGH_SEAS":
			_flag_team_aura = true;
		break;
	}

	//========================//
	//SNAPSHOT EXISTING STATUS//
	//========================//
	var _ref_existing_status = -1;

	if (_flag_team_aura){

		scr_status_prune_team_status_sources(
			_ref_target._str_team
		);

		_ref_existing_status =
			scr_status_check(
				_str_status_upper,
				_ref_target._str_team
			);
	}
	else{
		_ref_existing_status =
			scr_status_check(
				_str_status_upper,
				_ref_target
			);
	}

	var _ct_previous_stacks = 0;
	var _val_previous_lifetime = undefined;

	if (
		_ref_existing_status != -1 &&
		instance_exists(_ref_existing_status)
	){
		_ct_previous_stacks =
			_ref_existing_status._ct_status_stacks;

		_val_previous_lifetime =
			_ref_existing_status._val_status_lifetime;
	}

	var _ref_status = undefined;

	//================//
	//APPLY AURA//
	//================//
	switch (_str_status_upper){

		//==================//
		//HUNGERING FLAMES//
		//==================//
		case "HUNGERING_FLAMES":

			_ref_status = scr_status_aura_hungering_flames(
				"APPLY",
				undefined,
				_val_magnitude,
				undefined,
				_ref_target
			);

			if (instance_exists(_ref_status)){
				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"HUNGERING FLAMES",
					undefined,
					c_red,
					_ref_target.x + irandom_range(-32,32),
					_ref_target.y - 24 + irandom_range(-32,32)
				);
			}

		break;

		//==========//
		//3RD DEGREE//
		//==========//
		case "3RD_DEGREE":

			_ref_status = scr_status_aura_3rd_degree(
				"APPLY",
				undefined,
				_val_magnitude,
				_ref_target
			);

			if (instance_exists(_ref_status)){
				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"3RD DEGREE",
					undefined,
					c_red,
					_ref_target.x,
					_ref_target.y - 48
				);
			}

		break;

		//----------//
		//ROUGH SEAS//
		//----------//
		case "ROUGH_SEAS":

			_ref_status = scr_status_aura_rough_seas(
				"APPLY",
				undefined,
				_val_magnitude,
				undefined,
				_ref_target
			);

			if (instance_exists(_ref_status)){
				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"ROUGH SEAS",
					undefined,
					c_aqua,
					_ref_target.x + irandom_range(-32,32),
					_ref_target.y - 24 + irandom_range(-32,32)
				);
			}

		break;

		//----------------//
		//KRAKENS CHOSEN//
		//----------------//
		case "KRAKENS_CHOSEN":

			_ref_status = scr_status_aura_krakens_chosen(
				"APPLY",
				undefined,
				_val_magnitude,
				undefined,
				_ref_target
			);

			if (instance_exists(_ref_status)){
				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"KRAKENS CHOSEN",
					undefined,
					c_aqua,
					_ref_target.x + irandom_range(-32,32),
					_ref_target.y - 24 + irandom_range(-32,32)
				);
			}

		break;

		//----------//
		//FROSTFORM//
		//----------//
		case "FROSTFORM":

			_ref_status = scr_status_aura_frostform(
				"APPLY",
				undefined,
				_val_magnitude,
				undefined,
				_ref_target
			);

			if (instance_exists(_ref_status)){
				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"FROSTFORM",
					undefined,
					c_aqua,
					_ref_target.x + irandom_range(-32,32),
					_ref_target.y - 24 + irandom_range(-32,32)
				);
			}

		break;

		//----------//
		//CALM SEAS//
		//----------//
		case "CALM_SEAS":

			_ref_status = scr_status_aura_calm_seas(
				"APPLY",
				undefined,
				_val_magnitude,
				_ref_target
			);

			if (instance_exists(_ref_status)){
				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"CALM SEAS",
					undefined,
					c_aqua,
					_ref_target.x + irandom_range(-32,32),
					_ref_target.y - 24 + irandom_range(-32,32)
				);
			}

		break;

		//---------------//
		//HONEYED SCENT//
		//---------------//
		case "HONEYED_SCENT":

			_ref_status = scr_status_aura_honeyed_scent(
				"APPLY",
				undefined,
				_val_magnitude,
				undefined,
				_ref_target
			);

			if (instance_exists(_ref_status)){
				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"HONEYED SCENT",
					undefined,
					c_green,
					_ref_target.x + irandom_range(-32,32),
					_ref_target.y - 24 + irandom_range(-32,32)
				);
			}

		break;

		//------------------//
		//BURGEONING BLOOM//
		//------------------//
		case "BURGEONING_BLOOM":

			_ref_status = scr_status_aura_burgeoning_bloom(
				"APPLY",
				undefined,
				_val_magnitude,
				undefined,
				_ref_target
			);

			if (instance_exists(_ref_status)){
				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"BURGEONING BLOOM",
					undefined,
					c_green,
					_ref_target.x + irandom_range(-32,32),
					_ref_target.y - 24 + irandom_range(-32,32)
				);
			}

		break;
	}

	//===================//
	//AURA PRESENTATION//
	//===================//
	if (instance_exists(_ref_status)){

		var _spr_vfx = spr_battle_vfx_aura;

		if (_str_status_upper == "FROSTFORM"){
			_spr_vfx = spr_battle_vfx_frostform;
		}

		var _snd_sfx = snd_battle_aura;

		if (instance_exists(global.ref_cast_card)){

			if (global.ref_cast_card._flag_aura_sfx_played){
				_snd_sfx = undefined;
			}
			else{
				global.ref_cast_card._flag_aura_sfx_played = true;
			}
		}

		if (_snd_sfx != undefined){
			scr_battle_play_sfx(_snd_sfx);
		}

		var _ref_vfx_host = _ref_status._ref_host;

		if (
			!instance_exists(_ref_vfx_host) &&
			variable_instance_exists(
				_ref_status,
				"_ref_status_source"
			) &&
			instance_exists(_ref_status._ref_status_source)
		){
			_ref_vfx_host =
				_ref_status._ref_status_source;
		}

		if (
			instance_exists(_ref_vfx_host) &&
			!instance_exists(_ref_status._ref_persistent_vfx)
		){
			_ref_status._ref_persistent_vfx =
				scr_battle_vfx_persistent(
					_ref_vfx_host,
					_spr_vfx,
					0,
					0,
					1
				);
		}
	}

	//==================//
	//DEBUG APPLICATION//
	//==================//
	if (instance_exists(_ref_status)){

		var _ref_log_target = _ref_target;

		if (instance_exists(_ref_status._ref_host)){
			_ref_log_target = _ref_status._ref_host;
		}
		else if (
			variable_instance_exists(
				_ref_status,
				"_ref_status_source"
			) &&
			instance_exists(_ref_status._ref_status_source)
		){
			_ref_log_target =
				_ref_status._ref_status_source;
		}

		if (instance_exists(_ref_log_target)){
			scr_debug_log_status_application(
				_ref_log_target,
				_ref_status,
				_ct_previous_stacks,
				_val_previous_lifetime,
				"SCR_STATUS_APPLY_AURA"
			);
		}
	}

	return _ref_status;
}
