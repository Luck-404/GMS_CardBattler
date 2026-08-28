//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_POTENT_FRUIT
// FUNCTION: Resolves the Potent Fruit card effect.
//           Applies one stack of Boost to the caster for 2 rounds.
//           Each Boost stack increases damage dealt by 25%.
//
//===============================================================================//
function scr_card_viridian_potent_fruit(_stct_card,_ref_caster,_ref_target){

	//------------//
	//APPLY BOOST//
	//------------//
	scr_apply_buff_status("BOOST",25,2);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_buff,0,false);
}