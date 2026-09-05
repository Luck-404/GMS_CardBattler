//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_ANCHOR_STONE
// FUNCTION: Resolves Anchor Stone.
//           Summons an Anchor Stone on the selected allied Beast.
//           While it remains active, all allied Beasts are Immovable.
//
//===============================================================================//

function scr_card_cerulean_anchor_stone(_stct_card,_ref_caster,_ref_target){

	//-------------------//
	//SUMMON ANCHOR STONE//
	//-------------------//
	scr_init_minion(
		"ANCHOR_STONE",
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
	audio_play_sound(snd_buff,0,false);
}