//===============================================================================//
//
// SCRIPT: scr_card_viridian_verdant_swipes
// FUNCTION: Resolves the Rapid Strikes card effect.
//           Deals damage to the target three times.
//           Plays the associated animation and sound effects.
//
//===============================================================================//
function scr_card_viridian_verdant_swipes(_stct_card,_ref_caster,_ref_target){

	//----------------------//
	//DEAL DAMAGE (3 HITS)//
	//----------------------//
	repeat (3){

		scr_damage_target(_stct_card._val_card_magnitude,_ref_target);

		//----------------//
		//PLAY ANIMATION//
		//----------------//
	}
	
	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_battle_sfx_neu_hit,0,false);	
}