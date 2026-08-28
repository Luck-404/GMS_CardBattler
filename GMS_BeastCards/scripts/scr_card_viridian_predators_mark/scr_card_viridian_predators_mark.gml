//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_PREDATORS_MARK
// FUNCTION: Resolves the Predator's Mark card effect.
//           Applies Vulnerable to the selected Beast.
//           Extends the application by 1 round if the target has
//           Bleed, Poison, or Venom.
//
//===============================================================================//
function scr_card_viridian_predators_mark(_stct_card,_ref_caster,_ref_target){

	//-----------------------//
	//SET VULNERABLE DURATION//
	//-----------------------//
	var _val_vulnerable_lifetime = 3;

	//----------------------//
	//CHECK VIRIDIAN DOTS//
	//----------------------//
	var _flag_has_dot =
		scr_check_for_status("BLEED",_ref_target) != -1 ||
		scr_check_for_status("POISON",_ref_target) != -1 ||
		scr_check_for_status("VENOM",_ref_target) != -1;

	if (_flag_has_dot){
		_val_vulnerable_lifetime++;
	}

	//----------------//
	//APPLY VULNERABLE//
	//----------------//
	scr_apply_debuff_status(
		"VULNERABLE",
		_val_vulnerable_lifetime
	);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_debuff,0,false);
}