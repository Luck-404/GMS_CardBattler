//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_ENDLESS_BLOOM
// FUNCTION: Resolves the Endless Bloom Archetype card.
//           Creates a global team-bound Buff for 6 rounds.
//           Defeated allied Minions are replaced by Dormant Seeds that
//           inherit their accumulated HP and Magnitude bonuses.
//
//===============================================================================//

function scr_card_viridian_endless_bloom(_stct_card,_ref_caster,_ref_target){

	//--------------------//
	//APPLY ENDLESS BLOOM//
	//--------------------//
	scr_apply_buff_status(
		"ENDLESS_BLOOM",
		0,
		6
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