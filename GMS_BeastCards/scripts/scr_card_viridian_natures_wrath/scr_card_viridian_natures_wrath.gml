//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_NATURES_WRATH
// FUNCTION: Resolves the Nature's Wrath card effect.
//           Deals linear magical damage to the selected target.
//           Deals 1 additional damage per Poison stack on the target.
//
//===============================================================================//

function scr_card_viridian_natures_wrath(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//CALCULATE DAMAGE//
	//----------------//
	var _val_damage = _stct_card._val_card_magnitude;

	var _ref_poison = scr_check_for_status(
		"POISON",
		_ref_target
	);

	if (_ref_poison != -1){
		_val_damage += _ref_poison._ct_status_stacks;
	}

	//------------//
	//DEAL DAMAGE//
	//------------//
	scr_damage_target(
		_val_damage,
		_ref_target
	);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_attack,0,false);
}