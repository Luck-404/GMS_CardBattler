//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_PLAGUE_GARDEN
// FUNCTION: Resolves the Plague Garden Archetype card.
//           Applies a team-bound global Buff for 5 rounds.
//           Enemy Bleed, Poison, and Venom gains summon Sporelings.
//
//===============================================================================//

function scr_card_viridian_plague_garden(_stct_card,_ref_caster,_ref_target){

	//----------------------//
	//APPLY PLAGUE GARDEN//
	//----------------------//
	scr_apply_buff_status(
		"PLAGUE_GARDEN",
		0,
		5
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