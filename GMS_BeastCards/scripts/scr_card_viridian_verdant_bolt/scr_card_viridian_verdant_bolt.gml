//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_VERDANT_BOLT
// FUNCTION: Resolves the Verdant Bolt card effect.
//           Deals magical damage to the target.
//           Plays the associated attack sound.
//
//===============================================================================//
function scr_card_viridian_verdant_bolt(_stct_card,_ref_caster,_ref_target){

	//------------//
	//DEAL DAMAGE//
	//------------//
	scr_damage_target(
		_stct_card._val_card_magnitude,
		_ref_target
	);
	
	//----------//
	//RANDOM DOT//
	//----------//
	var _dot = choose("BLEED","POISON","VENOM");
	scr_apply_dot_status(_dot);
	
	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_battle_sfx_neu_hit,0,false);
}