//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_WINTERS_BITE
// FUNCTION: Resolves the Winter's Bite card effect.
//           Deals linear physical damage to the selected target.
//           ICEBREAKER consumes Frozen and doubles this card's direct damage.
//
//===============================================================================//

function scr_card_cerulean_winters_bite(_stct_card,_ref_caster,_ref_target){

	//-------------------//
	//CHECK ICEBREAKER//
	//-------------------//
	var _val_icebreaker_multiplier = scr_trigger_icebreaker(_ref_target);

	//----------------//
	//CALCULATE DAMAGE//
	//----------------//
	var _val_damage =
		_stct_card._val_card_magnitude *
		_val_icebreaker_multiplier;

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
	audio_play_sound(snd_attack,0,false);
}