//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_TIDAL_SLASH
// FUNCTION: Resolves the Tidal Slash card effect.
//           Deals linear physical damage to the selected target.
//           Deals 5 additional damage while Rain Weather is active.
//
//===============================================================================//

function scr_card_cerulean_tidal_slash(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//CALCULATE DAMAGE//
	//----------------//
	var _val_damage = _stct_card._val_card_magnitude;

	var _ref_rain = scr_check_for_status(
		"WEATHER: RAIN",
		global.list_statuses
	);

	if (_ref_rain != -1){
		_val_damage += 5;
	}

	//-----------//
	//DEAL DAMAGE//
	//-----------//
	scr_damage_target(_val_damage,_ref_target);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_attack,0,false);
}