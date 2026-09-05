//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_RAZOR_FIN
// FUNCTION: Resolves the Razor Fin card effect.
//           Deals linear physical damage to the selected target.
//           Applies one Bleed stack if the target survives.
//
//===============================================================================//

function scr_card_cerulean_razor_fin(_stct_card,_ref_caster,_ref_target){

	//------------//
	//DEAL DAMAGE//
	//------------//
	scr_damage_target(
		_stct_card._val_card_magnitude,
		_ref_target
	);

	//-------------//
	//APPLY BLEED//
	//-------------//
	if (
		instance_exists(_ref_target) &&
		_ref_target._val_cur_hp > 0
	){
		scr_apply_dot_status("BLEED");
	}

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_battle_sfx_neu_hit,0,false);
}