//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_ICE_LANCE
// FUNCTION: Resolves the Ice Lance card effect.
//           Deals armor-piercing magical damage to the selected target.
//
//===============================================================================//

function scr_card_cerulean_ice_lance(_stct_card,_ref_caster,_ref_target){

	//--------------------//
	//DEAL PIERCING DAMAGE//
	//--------------------//
	scr_damage_target_armor_pierce(_stct_card._val_card_magnitude,_ref_target);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_attack,0,false);
}