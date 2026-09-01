//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_TIDAL_BREAK
// FUNCTION: Resolves the Tidal Break card effect.
//           Deals linear physical damage to the selected target.
//           Applies 2 Stormstruck if the attack breaks the target's Armor.
//
//===============================================================================//

function scr_card_cerulean_tidal_break(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//STORE OLD ARMOR//
	//----------------//
	var _val_armor_before = _ref_target._val_armor;

	//------------//
	//DEAL DAMAGE//
	//------------//
	scr_damage_target(_stct_card._val_card_magnitude,_ref_target);

	//-----------------//
	//CHECK ARMOR BREAK//
	//-----------------//
	if (
		instance_exists(_ref_target) &&
		_ref_target._val_cur_hp > 0 &&
		_val_armor_before > 0 &&
		_ref_target._val_armor <= 0
	){

		//-------------------//
		//APPLY STORMSTRUCK//
		//-------------------//
		repeat (2){
			scr_apply_dot_status("STORMSTRUCK");
		}
	}

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_attack,0,false);
}