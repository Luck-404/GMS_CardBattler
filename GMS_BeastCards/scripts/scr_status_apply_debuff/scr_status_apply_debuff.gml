//===============================================================================//
//
// SCRIPT: scr_status_apply_debuff
// FUNCTION: Attempts to apply a Debuff status to the current target.
//           Checks target resistance from CON before applying.
//           Accepts an optional lifetime override.
//           Spawns feedback popup text for successful applications.
//
//===============================================================================//
function scr_status_apply_debuff(
	_str_status_name,
	_val_lifetime=undefined,
	_val_magnitude=undefined
){
	
	//----------------//
	//VALIDATE TARGET//
	//----------------//
	var _ref_target =
		global.ref_target_beast;

	if (!instance_exists(_ref_target)){
		return undefined;
	}

	if (_ref_target._ref_unit == undefined){
		return undefined;
	}

	//--------------//
	//RESIST CHECK//
	//--------------//
	if (scr_status_check_con_resistance(_ref_target)){
		return undefined;
	}

	//--------------//
	//APPLY STATUS//
	//--------------//
	var _ref_status = undefined;

	switch(_str_status_name){
	//--------//
	//ANTIHEAL//
	//--------//
	case "ANTIHEAL":

		_ref_status =
			scr_status_debuff_antiheal(
				"APPLY",
				undefined,
				_val_lifetime
			);

		if (_ref_status != undefined){

			scr_gui_spawn_popup_scrolling(
				"TEXT",
				"ANTIHEAL",
				undefined,
				c_maroon,
				_ref_target.x + irandom_range(-32,32),
				_ref_target.y - 24 + irandom_range(-32,32)
			);
		}

	break;		
		
//-------------//
//FROZEN CURSE//
//-------------//
case "FROZEN_CURSE":

	_ref_status =
		scr_status_debuff_frozen_curse(
			"APPLY",
			undefined,
			_val_lifetime
		);

	if (_ref_status != undefined){

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"FROZEN CURSE",
			undefined,
			c_maroon,
			_ref_target.x + irandom_range(-32,32),
			_ref_target.y - 24 + irandom_range(-32,32)
		);
	}

break;
		
		
	//--------//
	//WHITEOUT//
	//--------//
	case "WHITEOUT":

		_ref_status =
			scr_status_debuff_whiteout(
				"APPLY",
				undefined,
				_val_lifetime,
				_val_magnitude
			);

		if (_ref_status != undefined){

			scr_gui_spawn_popup_scrolling(
				"TEXT",
				"WHITEOUT",
				undefined,
				c_maroon,
				_ref_target.x + irandom_range(-32,32),
				_ref_target.y - 24 + irandom_range(-32,32)
			);
		}

	break;	
		
	//----------------------//
	//BRITTLE CONSTITUTION//
	//----------------------//
	case "BRITTLE_CONSTITUTION":

		_ref_status =
			scr_status_debuff_brittle_constitution(
				"APPLY",
				undefined,
				_val_lifetime
			);

		if (_ref_status != undefined){

			scr_gui_spawn_popup_scrolling(
				"TEXT",
				"BRITTLE CONSTITUTION",
				undefined,
				c_maroon,
				_ref_target.x + irandom_range(-32,32),
				_ref_target.y - 24 + irandom_range(-32,32)
			);
		}

	break;	
		
//-----//
//FOCUS//
//-----//
case "FOCUS":

	_ref_status = scr_status_debuff_focus("APPLY",undefined,_val_lifetime);

	if (_ref_status != undefined){

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"FOCUS",
			undefined,
			c_maroon,
			_ref_target.x + irandom_range(-32,32),
			_ref_target.y - 24 + irandom_range(-32,32)
		);
	}

break;
		//--------//
		//DRAINED//
		//--------//
		case "DRAINED":

			_ref_status = scr_status_debuff_drained("APPLY",undefined,_val_lifetime);

			if (_ref_status != undefined){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"DRAINED",
					undefined,
					c_maroon,
					_ref_target.x + irandom_range(-32,32),
					_ref_target.y - 24 + irandom_range(-32,32)
				);
			}

		break;

		//------------//
		//ARMORBREAK//
		//------------//
		case "ARMORBREAK":

			_ref_status =
				scr_status_debuff_armorbreak(
					"APPLY",
					undefined,
					_val_lifetime
				);

			if (_ref_status != undefined){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"ARMORBREAK",
					undefined,
					c_maroon,
					_ref_target.x + irandom_range(-32,32),
					_ref_target.y - 24 + irandom_range(-32,32)
				);
			}

		break;

		//------------------//
		//CRIPPLING VINES//
		//------------------//
		case "CRIPPLING_VINES":

			_ref_status =
				scr_status_debuff_crippling_vines(
					"APPLY",
					undefined,
					_val_lifetime
				);

			if (_ref_status != undefined){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"CRIPPLING VINES",
					undefined,
					c_maroon,
					_ref_target.x + irandom_range(-32,32),
					_ref_target.y - 24 + irandom_range(-32,32)
				);
			}

		break;

		//----------//
		//WEAKNESS//
		//----------//
		case "WEAKNESS":

			_ref_status =
				scr_status_debuff_weakness(
					"APPLY",
					undefined,
					_val_lifetime
				);

			if (_ref_status != undefined){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"WEAKNESS",
					undefined,
					c_black,
					_ref_target.x + irandom_range(-32,32),
					_ref_target.y - 24 + irandom_range(-32,32)
				);
			}

		break;

		//--------//
		//WITHER//
		//--------//
		case "WITHER":

			_ref_status = scr_status_debuff_wither("APPLY",undefined,_val_lifetime);

			if (_ref_status != undefined){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"WITHER",
					undefined,
					c_maroon,
					_ref_target.x + irandom_range(-32,32),
					_ref_target.y - 24 + irandom_range(-32,32)
				);
			}

		break;

		//------------//
		//VULNERABLE//
		//------------//
		case "VULNERABLE":

			_ref_status =
				scr_status_debuff_vulnerable(
					"APPLY",
					undefined,
					_val_lifetime
				);

			if (_ref_status != undefined){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"VULNERABLE",
					undefined,
					c_maroon,
					_ref_target.x + irandom_range(-32,32),
					_ref_target.y - 24 + irandom_range(-32,32)
				);
			}

		break;
	}

	//=====================//
	//DEBUFF PRESENTATION//
	//=====================//
	if (
		_ref_status != undefined &&
		instance_exists(_ref_status)
	){

		//------------------//
		//SELECT DEBUFF SFX//
		//------------------//
		var _snd_sfx =
			snd_battle_debuff;

		//------------------------//
		//ONLY PLAY ONCE PER CAST//
		//------------------------//
		if (instance_exists(global.ref_cast_card)){

			if (
				global.ref_cast_card
					._flag_debuff_sfx_played
			){

				_snd_sfx =
					undefined;
			}
			else{

				global.ref_cast_card
					._flag_debuff_sfx_played =
					true;
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
	}

	return _ref_status;
}