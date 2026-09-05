//===============================================================================//
//
// SCRIPT: SCR_BATTLE_VFX_DAMAGE_HIT
// FUNCTION: Plays the generic direct-damage impact VFX.
//           Selects the sprite from the card's damage STAT.
//           Scales the hit VFX based on damage dealt.
//           Automatically staggers repeated hits against the same target.
//
//===============================================================================//

function scr_battle_vfx_damage_hit(_ref_target,_str_damage_stat,_val_damage,_stct_presentation=undefined){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return undefined;
	}

	//-----------------------//
	//SELECT HIT VFX AND SFX//
	//-----------------------//
	var _spr_vfx = undefined;
	var _snd_sfx = undefined;

	switch(_str_damage_stat){

		case "PHY":
			_spr_vfx = spr_battle_vfx_phy_hit;
			_snd_sfx = snd_battle_sfx_phy_hit;
		break;

		case "MAG":
			_spr_vfx = spr_battle_vfx_mag_hit;
			_snd_sfx = snd_battle_sfx_mag_hit;
		break;

		case "NEU":
			_spr_vfx = spr_battle_vfx_neu_hit;
			_snd_sfx = snd_battle_sfx_neu_hit;
		break;
	}

	if (_spr_vfx == undefined){
		return undefined;
	}

	//-----------------//
	//CALCULATE VFX SCALE//
	//-----------------//
	var _val_scale = 0.5;

	if (_val_damage >= 50){
		_val_scale = 1.25;
	}
	else if (_val_damage >= 30){
		_val_scale = 1.0;
	}
	else if (_val_damage >= 10){
		_val_scale = 0.75;
	}

	//----------------//
	//DEFAULT SETTINGS//
	//----------------//
	var _ct_start_delay = 0;

	var _val_random_x = 12;
	var _val_random_y = 8;

	//------------------------//
	//GET CURRENT CASTING CARD//
	//------------------------//
	var _ref_card = global.ref_cast_card;

	if (instance_exists(_ref_card)){

		if (!is_array(_ref_card._arr_vfx_hit_context)){
			_ref_card._arr_vfx_hit_context = [];
		}

		var _flag_target_found = false;

		//--------------------------------//
		//CHECK FOR PRIOR HIT ON THIS TARGET//
		//--------------------------------//
		for (
			var _it_hit = 0;
			_it_hit < array_length(_ref_card._arr_vfx_hit_context);
			_it_hit++
		){

			var _stct_hit = _ref_card._arr_vfx_hit_context[_it_hit];

			if (_stct_hit._ref_target != _ref_target){
				continue;
			}

			_ct_start_delay = _stct_hit._ct_next_delay;

			_stct_hit._ct_next_delay += irandom_range(3,5);

			_flag_target_found = true;

			break;
		}

		//----------------//
		//FIRST TARGET HIT//
		//----------------//
		if (!_flag_target_found){

			var _stct_new_hit = {
				_ref_target : _ref_target,
				_ct_next_delay : irandom_range(5,7)
			};

			array_push(_ref_card._arr_vfx_hit_context,_stct_new_hit);
		}
	}

	//----------------------//
	//PRESENTATION OVERRIDES//
	//----------------------//
	if (is_struct(_stct_presentation)){

		if (
			variable_struct_exists(
				_stct_presentation,
				"_spr_vfx_override"
			) &&
			_stct_presentation._spr_vfx_override != undefined
		){
			_spr_vfx =
				_stct_presentation._spr_vfx_override;
		}

		if (
			variable_struct_exists(
				_stct_presentation,
				"_snd_sfx_override"
			) &&
			_stct_presentation._snd_sfx_override != undefined
		){
			_snd_sfx =
				_stct_presentation._snd_sfx_override;
		}
	}

	//---------//
	//PLAY VFX//
	//---------//
	return scr_battle_vfx(
		_ref_target,
		_spr_vfx,
		undefined,
		undefined,
		_val_random_x,
		_val_random_y,
		_val_scale,
		_ct_start_delay,
		_snd_sfx
	);
}