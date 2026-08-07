//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_SERPENT_SUMMON
// FUNCTION: Resolves Serpent Summon.
//           Summons three Serpent minions on the caster.
//           Each Serpent attacks a random enemy and applies Venom each round.
//
//===============================================================================//
function scr_card_viridian_serpent_summon(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//SUMMON SERPENTS//
	//----------------//
	repeat (3){
		scr_init_minion("SERPENT",_stct_card,_ref_caster,_ref_caster);
	}

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_buff,0,false);
}