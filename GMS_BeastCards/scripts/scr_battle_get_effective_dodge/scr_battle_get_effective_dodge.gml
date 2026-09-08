//===============================================================================//
//
// SCRIPT: scr_battle_get_effective_dodge
// FUNCTION: Returns the target's effective Dodge chance against a caster.
//           Returns 0 when the target's Dodge is disabled.
//           Returns 0 when the caster has an Ignore Dodge status.
//
//===============================================================================//

function scr_battle_get_effective_dodge(_ref_caster,_ref_target){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return 0;
	}

	if (!is_struct(_ref_target._ref_unit)){
		return 0;
	}

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

		for (var _it_status = 0; _it_status < ds_list_size(_ref_caster._list_statuses); _it_status++){

			var _ref_status =
				ds_list_find_value(
					_ref_caster._list_statuses,
					_it_status
				);

			if (!instance_exists(_ref_status)){
				continue;
			}

			if (_ref_status._flag_status_ignore_dodge){
				return 0;
			}
		}
	}

	//-------------//
	//NORMAL DODGE//
	//-------------//
	return clamp(
		_ref_target._ref_unit._val_beast_dod_stat +
		_ref_target._val_dodge_bonus,
		0,
		100
	);
}