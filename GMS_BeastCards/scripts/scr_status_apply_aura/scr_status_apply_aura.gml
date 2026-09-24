//===============================================================================//
//
// SCRIPT: SCR_STATUS_APPLY_AURA
// FUNCTION: Applies an Aura Status to the supplied target Beast.
//           Auras are host-bound persistent Statuses.
//           Passes card-controlled Magnitude into the Aura callback.
//           Handles shared Aura popup, VFX, SFX, and application logging.
//
// ARGUMENTS: _str_status_name is the Aura ID; _ref_target is the host Beast; _val_magnitude is the optional strength.
//
// RETURNS: Applied Status instance, or undefined if the application fails.
//
//===============================================================================//

function scr_status_apply_aura(_str_status_name,_ref_target,_val_magnitude=0){

	//-----------------//
	//VALIDATE TARGET//
	//-----------------//

	if (!instance_exists(_ref_target)){
		return undefined;
	}

	//========================//
	//SNAPSHOT EXISTING STATUS//
	//========================//
	var _ref_existing_status = -1;
	var _list_team = undefined;

	if (_ref_target._str_team == "PLAYER" && instance_exists(obj_battle_player_controller)){
		_list_team = obj_battle_player_controller._list_beasts;
	}
	else if (_ref_target._str_team == "ENEMY" && instance_exists(obj_battle_enemy_controller)){
		_list_team = obj_battle_enemy_controller._list_beasts;
	}

	if (_list_team != undefined && ds_exists(_list_team,ds_type_list)){

		for (var _it_beast = 0;_it_beast < ds_list_size(_list_team);_it_beast++){

			var _ref_beast = ds_list_find_value(_list_team,_it_beast);

			if (!instance_exists(_ref_beast)){
				continue;
			}

			_ref_existing_status = scr_status_check(_str_status_name,_ref_beast);

			if (_ref_existing_status != -1){
				break;
			}
		}
	}

	if (_ref_existing_status == -1){
		_ref_existing_status = scr_status_check(_str_status_name,_ref_target);
	}

	var _ct_previous_stacks = 0;
	var _val_previous_lifetime = undefined;

	if (_ref_existing_status != -1 && instance_exists(_ref_existing_status)){
		_ct_previous_stacks = _ref_existing_status._ct_status_stacks;
		_val_previous_lifetime = _ref_existing_status._val_status_lifetime;
	}

	var _ref_status = undefined;

	//================//
	//APPLY AURA//
	//================//
	switch (_str_status_name){
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

			_ref_status = scr_status_aura_3rd_degree("APPLY", undefined, _val_magnitude, _ref_target);

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

			if (_ref_status != undefined){

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

			if (_ref_status != undefined){

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

			if (_ref_status != undefined){

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

			_ref_status = scr_status_aura_calm_seas("APPLY", undefined, _val_magnitude, _ref_target);

			if (_ref_status != undefined){

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

			if (_ref_status != undefined){

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

			if (_ref_status != undefined){

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
	if (
		_ref_status != undefined &&
		instance_exists(_ref_status)
	){

		//-----------------//
		//SELECT AURA VFX//
		//-----------------//
		var _spr_vfx = spr_battle_vfx_aura;

		//------------------//
		//SPECIAL AURA VFX//
		//------------------//
		switch (_str_status_name){

			case "FROSTFORM":

				_spr_vfx = spr_battle_vfx_frostform;

			break;
		}

		//-----------------//
		//SELECT AURA SFX//
		//-----------------//
		var _snd_sfx = snd_battle_aura;

		//------------------------//
		//ONLY PLAY ONCE PER CAST//
		//------------------------//
		if (instance_exists(global.ref_cast_card)){

			if (global.ref_cast_card._flag_aura_sfx_played){
				_snd_sfx = undefined;
			}
			else{
				global.ref_cast_card._flag_aura_sfx_played = true;
			}
		}

		//---------------//
		//PLAY AURA SFX//
		//---------------//
		if (_snd_sfx != undefined){
			scr_battle_play_sfx(_snd_sfx);
		}

		//-----------------------//
		//ENSURE PERSISTENT VFX//
		//-----------------------//
		if (
			instance_exists(_ref_status._ref_host) &&
			!instance_exists(_ref_status._ref_persistent_vfx)
		){

			_ref_status._ref_persistent_vfx = scr_battle_vfx_persistent(
				_ref_status._ref_host,
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