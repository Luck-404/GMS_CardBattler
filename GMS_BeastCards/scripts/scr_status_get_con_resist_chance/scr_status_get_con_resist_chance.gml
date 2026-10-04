//===============================================================================//
//
// SCRIPT: SCR_STATUS_GET_CON_RESIST_CHANCE
// FUNCTION: Returns a Beast's chance to resist a DoT, Debuff, or CC application.
//           Resistance is calculated directly from the target's effective CON.
//
//           0 CON   = 0% resistance.
//           300 CON = 50% resistance.
//           CON above 300 receives diminishing returns toward 100%.
//
// ARGUMENTS: _ref_target - Beast whose CON resistance chance is calculated.
// RETURNS: Final resistance chance as a percentage from 0 toward 100.
//
//===============================================================================//

function scr_status_get_con_resist_chance(_ref_target){

	#region VALIDATION

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return 0;
	}

	if (!is_struct(_ref_target._ref_unit)){
		return 0;
	}

	#endregion

	#region RESISTANCE

	//================//
	//GET CON STAT//
	//================//
	var _val_con_stat = max(
		0,
		_ref_target._ref_unit._val_beast_con_stat
	);

	//==========================//
	//CALCULATE RESIST CHANCE//
	//==========================//
	var _val_resist_chance =
		scr_beast_get_con_resistance(
			_val_con_stat
		);

	return clamp(
		_val_resist_chance,
		0,
		100
	);

	#endregion
}