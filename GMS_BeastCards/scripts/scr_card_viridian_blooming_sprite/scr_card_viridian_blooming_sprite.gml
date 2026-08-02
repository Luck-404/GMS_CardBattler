//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_BLOOMING_SPRITE
// FUNCTION: Resolves the Blooming Sprite card effect.
//           Summons a Blooming Sprite for the selected allied Beast.
//
//===============================================================================//

function scr_card_viridian_blooming_sprite(_stct_card,_ref_caster,_ref_target){

	//----------------------//
	//SUMMON BLOOMING SPRITE//
	//----------------------//
	scr_init_minion(
		"BLOOMING_SPRITE",
		_stct_card,
		_ref_caster,
		_ref_target
	);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(
		snd_buff,
		0,
		false
	);
}