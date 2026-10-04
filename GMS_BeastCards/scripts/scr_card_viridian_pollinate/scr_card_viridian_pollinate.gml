//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_POLLINATE
// FUNCTION: Resolves Pollinate.
//           Applies Regeneration to the selected allied Beast and the allied
//           Beast immediately behind it for 3 rounds.
//
//           Healing calculation:
//           1. Calculate base healing from the affected Beast's Max HP using
//              the Card's percentage Magnitude.
//           2. Scale that base healing by the caster's MAGPOW multiplier.
//           3. Store the final value in Regeneration and heal that amount
//              immediately.
//
//           Example:
//           Target Max HP 100, Magnitude 5%, caster MAGPOW 300:
//           5 base healing * 3.0 MAGPOW = 15 healing.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_viridian_pollinate(_stct_card,_ref_caster,_ref_target){

	#region VALIDATION

	//================//
	//VALIDATE CASTER//
	//================//
	if (!instance_exists(_ref_caster)){
		return;
	}

	if (!is_struct(_ref_caster._ref_unit)){
		return;
	}

	//================//
	//VALIDATE TARGET//
	//================//
	if (!instance_exists(_ref_target)){
		return;
	}

	#endregion

	#region HEALING SCALE

	//================//
	//GET MAGPOW SCALE//
	//================//
	var _val_mpow_multiplier =
		scr_beast_get_power_multiplier(
			_ref_caster._ref_unit._val_beast_mpow_stat
		);

	#endregion

	#region TARGETS

	//====================//
	//GET AFFECTED TARGETS//
	//====================//
	var _arr_targets = [
		_ref_target,
		scr_battle_get_right_target(_ref_target)
	];

	#endregion

	#region POLLINATE

	//====================//
	//APPLY REGENERATION//
	//====================//
	for (
		var _it_target = 0;
		_it_target < array_length(_arr_targets);
		_it_target++
	){

		var _ref_affected_target =
			_arr_targets[_it_target];

		if (!instance_exists(_ref_affected_target)){
			continue;
		}

		if (_ref_affected_target._val_cur_hp <= 0){
			continue;
		}

		//======================//
		//CALCULATE BASE HEALING//
		//======================//
		var _val_base_healing =
			max(
				1,
				ceil(
					_ref_affected_target._val_max_hp *
					(_stct_card._val_card_magnitude / 100)
				)
			);

		//=====================//
		//APPLY MAGPOW SCALING//
		//=====================//
		var _val_healing =
			max(
				1,
				ceil(
					_val_base_healing *
					_val_mpow_multiplier
				)
			);

		//====================//
		//APPLY REGENERATION//
		//====================//
		scr_status_apply_buff(
			"REGENERATION",
			_ref_affected_target,
			_val_healing,
			3
		);

		//================//
		//IMMEDIATE HEAL//
		//================//
		scr_battle_heal_target(
			"FIXED",
			_val_healing,
			_ref_affected_target
		);
	}

	#endregion
}