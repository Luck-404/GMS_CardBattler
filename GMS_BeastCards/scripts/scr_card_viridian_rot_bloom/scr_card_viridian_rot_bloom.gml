//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_ROT_BLOOM
// FUNCTION: Resolves the Rot Bloom card effect.
//           Damages the selected target and adjacent living Beasts.
//           Deals 1 additional damage for each Poison stack on each target.
//
//===============================================================================//

function scr_card_viridian_rot_bloom(_stct_card,_ref_caster,_ref_target){

	//--------------------//
	//GET AOE-3 TARGETS//
	//--------------------//
	var _arr_targets = [
		scr_get_left_target(_ref_target),
		_ref_target,
		scr_get_right_target(_ref_target)
	];

	//----------------//
	//DAMAGE TARGETS//
	//----------------//
	for (
		var _it_target = 0;
		_it_target < array_length(_arr_targets);
		_it_target++
	){

		var _ref_affected_target = _arr_targets[_it_target];

		if (!instance_exists(_ref_affected_target)){
			continue;
		}

		//-------------------//
		//GET POISON STACKS//
		//-------------------//
		var _ct_poison_stacks = 0;

		var _ref_poison = scr_check_for_status(
			"POISON",
			_ref_affected_target
		);

		if (_ref_poison != -1){
			_ct_poison_stacks = _ref_poison._ct_status_stacks;
		}

		//------------------//
		//CALCULATE DAMAGE//
		//------------------//
		var _val_damage =
			_stct_card._val_card_magnitude +
			_ct_poison_stacks;

		//------------//
		//DEAL DAMAGE//
		//------------//
		scr_damage_target(
			_val_damage,
			_ref_affected_target
		);

		//----------------//
		//PLAY ANIMATION//
		//----------------//
	}

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_battle_sfx_neu_hit,0,false);
}