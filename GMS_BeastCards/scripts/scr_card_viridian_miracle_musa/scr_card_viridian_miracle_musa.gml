//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_MIRACLE_MUSA
// FUNCTION: Resolves Miracle Musa.
//           Grants the caster MAG-scaled temporary Overhealth for 3 turns.
//
//===============================================================================//

function scr_card_viridian_miracle_musa(_stct_card,_ref_caster,_ref_target){

	//----------------------//
	//CALCULATE OVERHEALTH//
	//----------------------//
	var _val_mpow_stat =
		_ref_caster._ref_unit._val_beast_mpow_stat;

	var _val_mpow_mod =
		scr_get_beast_grade_modifier(_val_mpow_stat);

	var _val_overhealth =
		ceil(
			_stct_card._val_card_magnitude *
			_val_mpow_mod
		);

	//------------------//
	//APPLY OVERHEALTH//
	//------------------//
	scr_apply_buff_status(
		"OVERHEALTH",
		_val_overhealth,
		3
	);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_buff,0,false);
}