//===============================================================================//
//
// SCRIPT: SCR_GET_CON_RESIST_CHANCE
// FUNCTION: Returns a Beast's chance to resist a DoT, Debuff, or CC application.
//           Resistance scales from the target's CON grade modifier.
//
//===============================================================================//
function scr_get_con_resist_chance(_ref_target){

	if (!instance_exists(_ref_target)){
		return 0;
	}

	if (_ref_target._ref_unit == undefined){
		return 0;
	}

	var _val_con_stat =
		_ref_target._ref_unit._val_beast_con_stat;

	var _val_con_modifier =
		scr_get_beast_grade_modifier(_val_con_stat);

	var _val_resist_chance =
		round(
			10 *
			_val_con_modifier
		);

	return clamp(_val_resist_chance,1,100);
}
