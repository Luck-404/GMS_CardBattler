//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_DEPTH_CHARGE
// FUNCTION: Resolves the Depth Charge card effect.
//           Deals linear magical damage to the selected target.
//           Deals 25% additional damage while Cerulean Weather is active.
//
//===============================================================================//

function scr_card_cerulean_depth_charge(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//GET BASE DAMAGE//
	//----------------//
	var _val_damage = _stct_card._val_card_magnitude;

	//-----------------------//
	//CHECK CERULEAN WEATHER//
	//-----------------------//
	if (scr_check_cerulean_weather()){
		_val_damage *= 1.25;
	}

	//------------//
	//DEAL DAMAGE//
	//------------//
	scr_damage_target(_val_damage,_ref_target);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_battle_sfx_neu_hit,0,false);
}