//===============================================================================//
//
// SCRIPT: SCR_STATUS_GET_CON_RESIST_CHANCE
// FUNCTION: Returns a Beast's chance to resist a DoT, Debuff, or CC application.
//           Resistance scales from the target's CON grade modifier.
//
// ARGUMENTS: _ref_target is the Beast whose CON resistance chance is calculated.
// RETURNS: The final resistance chance as a percentage from 1 to 100.
//
//===============================================================================//

function scr_status_get_con_resist_chance(_ref_target){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return 0;
	}

	if (!is_struct(_ref_target._ref_unit)){
		return 0;
	}

	//==========================//
	//CALCULATE RESIST CHANCE//
	//==========================//
	var _val_con_stat = _ref_target._ref_unit._val_beast_con_stat;
	var _val_con_modifier = scr_beast_get_grade_modifier(_val_con_stat);
	var _val_resist_chance = round(10 * _val_con_modifier);

	return clamp(_val_resist_chance,1,100);
}