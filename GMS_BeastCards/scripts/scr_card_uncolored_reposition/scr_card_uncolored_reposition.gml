//===============================================================================//
//
// SCRIPT: SCR_CARD_UNCOLORED_REPOSITION
// FUNCTION: Resolves the Reposition card effect.
//           Swaps the positions of the caster and target.
//           Repositions attached minions and statuses.
//           Plays the associated animation, sound, and popup effects.
//
//===============================================================================//
function scr_card_uncolored_reposition(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//SWAP POSITIONS//
	//----------------//
	scr_reposition_target(_stct_card,_ref_caster,_ref_target);
	
	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_beast_summon,0,false);


}