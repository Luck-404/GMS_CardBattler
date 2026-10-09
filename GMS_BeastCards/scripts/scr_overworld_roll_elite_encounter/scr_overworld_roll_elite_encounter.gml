//===============================================================================//
//
// SCRIPT: SCR_OVERWORLD_ROLL_ELITE_ENCOUNTER
// FUNCTION: Rolls whether one natural encounter source becomes Elite.
//
//           Base chance is 4% (1/25). Party ENCOUNTER Held Items may replace
//           that chance through SCR_OVERWORLD_GET_ELITE_ENCOUNTER_MODIFIERS.
//
//           A successful roll immediately chooses and stores one Elite modifier.
//           Callers must persist this result instead of rerolling later.
//
// ARGUMENTS: None.
// RETURNS: Elite encounter roll metadata struct.
//
//===============================================================================//

function scr_overworld_roll_elite_encounter(){
	#region MODIFIERS

	var _stct_modifiers =
		scr_overworld_get_elite_encounter_modifiers();

	if (!is_struct(_stct_modifiers)){
		_stct_modifiers = {
			_val_base_elite_chance_percent : 4,
			_val_elite_chance_bonus : 0,
			_val_elite_chance_percent : 4,
			_val_elite_risk_tier : 0,
			_str_elite_source_item_id : "BASE",
			_str_elite_source_item_name : "BASE"
		};
	}

	#endregion

	#region ROLL

	var _val_elite_roll =
		irandom_range(
			1,
			100
		);

	var _flag_elite =
		_val_elite_roll <=
			_stct_modifiers
				._val_elite_chance_percent;

	var _str_elite_modifier = "";

	if (_flag_elite){
		_str_elite_modifier =
			scr_battle_elite_roll_modifier();
	}

	if (
		_flag_elite &&
		scr_battle_elite_get_info(
			_str_elite_modifier
		) ==
		undefined
	){
		_flag_elite = false;
		_str_elite_modifier = "";
	}

	#endregion

	#region RESULT

	var _stct_result = {
		_flag_elite : _flag_elite,
		_str_elite_modifier : _str_elite_modifier,
		_val_elite_risk_tier :
			(_flag_elite
				? _stct_modifiers._val_elite_risk_tier
				: 0),
		_val_elite_chance_percent :
			_stct_modifiers._val_elite_chance_percent,
		_val_elite_roll : _val_elite_roll,
		_str_elite_source_item_id :
			_stct_modifiers._str_elite_source_item_id,
		_str_elite_source_item_name :
			_stct_modifiers._str_elite_source_item_name
	};

	#endregion

	#region DEBUG

	scr_debug_log(
		"OVERWORLD",
		"ELITE",
		undefined,
		"ELITE ENCOUNTER ROLL" +
		" | ROLL: " +
		string(
			_val_elite_roll
		) +
		"/100" +
		" | CHANCE: " +
		string(
			_stct_modifiers
				._val_elite_chance_percent
		) +
		"%" +
		" | RESULT: " +
		(_flag_elite ? "ELITE" : "NORMAL") +
		" | SOURCE: " +
		_stct_modifiers
			._str_elite_source_item_id +
		" | RISK TIER: " +
		string(
			_flag_elite
			? _stct_modifiers
				._val_elite_risk_tier
			: 0
		) +
		(
			_flag_elite
			? " | MODIFIER: " +
				_str_elite_modifier
			: ""
		),
		"INFO",
		"SCR_OVERWORLD_ROLL_ELITE_ENCOUNTER"
	);

	#endregion

	return _stct_result;
}
