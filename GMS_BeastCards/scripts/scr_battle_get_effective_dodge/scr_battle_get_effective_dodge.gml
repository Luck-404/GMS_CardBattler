//===============================================================================//
//
// SCRIPT: SCR_BATTLE_GET_EFFECTIVE_DODGE
// FUNCTION: Returns a target battle Beast's effective Dodge chance.
//           Returns 0 when the target's Dodge is disabled or when the
//           opposing caster has an active Ignore Dodge effect.
//
// INPUTS:   _ref_caster - Battle Beast attempting to affect the target.
//           _ref_target - Battle Beast whose effective Dodge is being checked.
// USES:     Target Dodge stat/bonuses, Dodge-disable state, and caster Statuses.
//
//===============================================================================//

function scr_battle_get_effective_dodge(_ref_caster,_ref_target){

	#region VALIDATION

	//-----------------//
	//VALIDATE TARGET//
	//-----------------//
	if (!instance_exists(_ref_target)){
		return 0;
	}

	if (!is_struct(_ref_target._ref_unit)){
		return 0;
	}

	#endregion

	#region DODGE OVERRIDES

	//----------------------//
	//TARGET DODGE DISABLED//
	//----------------------//
	if (_ref_target._ct_dodge_disabled > 0){
		return 0;
	}

	//--------------------//
	//CASTER IGNORES DODGE//
	//--------------------//
	if (instance_exists(_ref_caster)){

		var _list_statuses = _ref_caster._list_statuses;
		var _ct_statuses = ds_list_size(_list_statuses);

		for (var _it_status = 0; _it_status < _ct_statuses; _it_status++){

			var _ref_status = ds_list_find_value(_list_statuses,_it_status);

			if (!instance_exists(_ref_status)){
				continue;
			}

			if (_ref_status._flag_status_ignore_dodge){
				return 0;
			}
		}
	}

	#endregion

	#region EFFECTIVE DODGE

	//-------------//
	//NORMAL DODGE//
	//-------------//
	var _stct_target_unit = _ref_target._ref_unit;

	return clamp(
		_stct_target_unit._val_beast_dod_stat +
		_ref_target._val_dodge_bonus,
		0,
		100
	);

	#endregion
}