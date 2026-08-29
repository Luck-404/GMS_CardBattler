//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_NATURES_WRATH
// FUNCTION: Resolves the Nature's Wrath card effect.
//           Deals additional damage for each Poison stack on the target.
//           POISONFLOW consumes up to 2 Poison and heals the caster.
//
//===============================================================================//

function scr_card_viridian_natures_wrath(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//CALCULATE DAMAGE//
	//----------------//
	var _val_damage = _stct_card._val_card_magnitude;

	var _ref_poison = scr_check_for_status("POISON",_ref_target);

	if (_ref_poison != -1){
		_val_damage += _ref_poison._ct_status_stacks;
	}

	//------------//
	//DEAL DAMAGE//
	//------------//
	scr_damage_target(_val_damage,_ref_target);

	//------------//
	//POISONFLOW//
	//------------//
	if (
		instance_exists(_ref_target) &&
		instance_exists(_ref_caster)
	){
		var _ct_poison_consumed = scr_trigger_poisonflow(_ref_target,2);

		if (_ct_poison_consumed > 0){
			scr_heal_target(_ct_poison_consumed * 2,_ref_caster);
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