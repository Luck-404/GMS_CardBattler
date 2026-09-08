//===============================================================================//
//
// SCRIPT: scr_status_apply_aura
// FUNCTION: Applies an Aura status to the current target Beast.
//           Auras are host-bound persistent statuses.
//           Passes card-controlled magnitude into the Aura callback.
//
//===============================================================================//
function scr_status_apply_aura(_str_status_name,_val_magnitude=0){

	var _ref_target =
		global.ref_target_beast;

	if (!instance_exists(_ref_target)){
		return undefined;
	}

	var _ref_status =
		undefined;

	switch(_str_status_name){

		//----------//
		//ROUGH SEAS//
		//----------//
		case "ROUGH_SEAS":

			_ref_status =
				scr_status_aura_rough_seas(
					"APPLY",
					undefined,
					_val_magnitude
				);

			if (_ref_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"ROUGH SEAS",
					undefined,
					c_aqua,
					_ref_target.x + irandom_range(-32,32),
					_ref_target.y - 24 + irandom_range(-32,32)
				);
			}

		break;

		//---------------//
		//KRAKENS CHOSEN//
		//---------------//
		case "KRAKENS_CHOSEN":

			_ref_status =
				scr_status_aura_krakens_chosen(
					"APPLY",
					undefined,
					_val_magnitude
				);

			if (_ref_status != undefined){

				scr_spawn_popup_scrolling(
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

			_ref_status =
				scr_status_aura_frostform(
					"APPLY",
					undefined,
					_val_magnitude
				);

			if (_ref_status != undefined){

				scr_spawn_popup_scrolling(
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

			_ref_status =
				scr_status_aura_calm_seas(
					"APPLY",
					undefined,
					_val_magnitude
				);

			if (_ref_status != undefined){

				scr_spawn_popup_scrolling(
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

			_ref_status = scr_status_aura_honeyed_scent("APPLY",undefined,_val_magnitude);

			if (_ref_status != undefined){

				scr_spawn_popup_scrolling(
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

			_ref_status =
				scr_status_aura_burgeoning_bloom(
					"APPLY",
					undefined,
					_val_magnitude
				);

			if (_ref_status != undefined){

				scr_spawn_popup_scrolling(
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

		//------------------//
		//SELECT AURA VFX//
		//------------------//
		var _spr_vfx =
			spr_battle_vfx_aura;

		//-------------------//
		//SPECIAL AURA VFX//
		//-------------------//
		switch(_str_status_name){

			case "FROSTFORM":

				_spr_vfx =
					spr_battle_vfx_frostform;

			break;
		}

		//--------------------//
		//SELECT AURA SFX//
		//--------------------//
		var _snd_sfx =
			snd_battle_aura;

		//------------------------//
		//ONLY PLAY ONCE PER CAST//
		//------------------------//
		if (instance_exists(global.ref_cast_card)){

			if (
				global.ref_cast_card
					._flag_aura_sfx_played
			){

				_snd_sfx =
					undefined;
			}
			else{

				global.ref_cast_card
					._flag_aura_sfx_played =
					true;
			}
		}

		//----------------//
		//PLAY AURA SFX//
		//----------------//
		if (_snd_sfx != undefined){

			audio_play_sound(
				_snd_sfx,
				0,
				false
			);
		}

		//------------------------//
		//ENSURE PERSISTENT VFX//
		//------------------------//
		if (
			instance_exists(_ref_status._ref_host) &&
			!instance_exists(
				_ref_status._ref_persistent_vfx
			)
		){

			_ref_status._ref_persistent_vfx =
				scr_battle_vfx_persistent(
					_ref_status._ref_host,
					_spr_vfx,
					0,
					0,
					1
				);
		}
	}

	return _ref_status;
}