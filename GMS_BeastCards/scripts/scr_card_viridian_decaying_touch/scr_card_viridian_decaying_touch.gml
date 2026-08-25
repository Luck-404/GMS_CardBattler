//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_DECAYING_TOUCH
// FUNCTION: Resolves the Decaying Touch card effect.
//           Applies Wither for three rounds.
//           Increases Wither duration to five rounds if the target is Poisoned.
//
//===============================================================================//
function scr_card_viridian_decaying_touch(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return;
	}

	//----------------//
	//BASE DURATION//
	//----------------//
	var _val_wither_lifetime = 3;

	//----------------//
	//CHECK POISON//
	//----------------//
	var _ref_poison = scr_check_for_status("POISON",_ref_target);

	if (_ref_poison != -1){
		_val_wither_lifetime = 5;
	}

	//--------------//
	//APPLY WITHER//
	//--------------//
	scr_apply_debuff_status("WITHER",_val_wither_lifetime);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_debuff,0,false);
}