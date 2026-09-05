//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_COLD_SNAP
// FUNCTION: Resolves the Cold Snap card effect.
//           Deals linear magical damage to the selected target.
//           Freezes the surviving target if it has Frostbite.
//
//===============================================================================//

function scr_card_cerulean_cold_snap(_stct_card,_ref_caster,_ref_target){

	//------------//
	//DEAL DAMAGE//
	//------------//
	scr_damage_target(_stct_card._val_card_magnitude,_ref_target);

	//----------------//
	//CHECK FROSTBITE//
	//----------------//
	if (
		instance_exists(_ref_target) &&
		_ref_target._val_cur_hp > 0
	){

		var _ref_frostbite = scr_check_for_status("FROSTBITE",_ref_target);

		if (_ref_frostbite != -1){

			//------------//
			//APPLY FROZEN//
			//------------//
			scr_apply_cc_status("FROZEN");
		}
	}

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_battle_sfx_neu_hit,0,false);
}