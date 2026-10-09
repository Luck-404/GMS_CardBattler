//===============================================================================//
//
// SCRIPT: SCR_OVERWORLD_SPAWN_WILD_BEAST_FROM_ZONE
// FUNCTION: Rolls a visible wild Beast spawn from an encounter zone.
//           Uses the zone's encounter pool.
//           Rolls and persists Elite encounter metadata at spawn time so the
//           visible Beast cannot reroll Elite identity when engaged.
//           Assigns the zone as the spawned Beast's home leash.
//
// ARGUMENTS: _ref_zone is the overworld encounter zone spawning the Beast.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_overworld_spawn_wild_beast_from_zone(_ref_zone){

	//================//
	//VALIDATE ZONE//
	//================//
	if (!instance_exists(_ref_zone)){
		return;
	}

	if (!variable_instance_exists(_ref_zone,"_arr_encounter_beasts")){
		return;
	}

	if (!is_array(_ref_zone._arr_encounter_beasts) || array_length(_ref_zone._arr_encounter_beasts) <= 0){
		return;
	}

	//================//
	//ROLL SPAWN//
	//================//
	if (irandom_range(1,100) > 30){
		return;
	}

	var _stct_unit = scr_beast_get_random(_ref_zone._arr_encounter_beasts);

	if (!is_struct(_stct_unit)){
		return;
	}

	//================//
	//ROLL ELITE//
	//================//
	var _stct_elite_roll =
		scr_overworld_roll_elite_encounter();

	if (is_struct(_stct_elite_roll)){
		_stct_unit._flag_elite =
			_stct_elite_roll._flag_elite;

		_stct_unit._str_elite_modifier =
			_stct_elite_roll._str_elite_modifier;

		_stct_unit._val_elite_risk_tier =
			_stct_elite_roll._val_elite_risk_tier;

		_stct_unit._val_elite_chance_percent =
			_stct_elite_roll._val_elite_chance_percent;

		_stct_unit._val_elite_roll =
			_stct_elite_roll._val_elite_roll;

		_stct_unit._str_elite_source_item_id =
			_stct_elite_roll._str_elite_source_item_id;

		_stct_unit._flag_elite_stats_applied = false;

		_stct_unit._arr_elite_card_ids = [];
		_stct_unit._str_elite_primary_card_id = "";
	}

	//================//
	//GET SPAWN POSITION//
	//================//
	var _val_spawn_x = _ref_zone.x + irandom_range(-96,96);
	var _val_spawn_y = _ref_zone.y + irandom_range(-96,96);

	//================//
	//CREATE WILD BEAST//
	//================//
	var _ref_beast = instance_create_layer(
		_val_spawn_x,
		_val_spawn_y,
		"ily_npcs",
		obj_overworld_beast
	);

	_ref_beast._str_team = "WILD";
	_ref_beast._stct_unit = _stct_unit;

	//================//
	//ASSIGN HOME ZONE//
	//================//
	_ref_beast._ref_home = _ref_zone;

	_ref_beast._val_home_x = _ref_zone.x;
	_ref_beast._val_home_y = _ref_zone.y;

	//================//
	//ASSIGN VISUALS//
	//================//
	_ref_beast._spr_beast = _stct_unit._spr_beast;
	_ref_beast._spr_shadow = scr_beast_get_type_shadow(_stct_unit._str_beast_color_type);

	//================//
	//DEBUG SPAWN//
	//================//
	scr_debug_log(
		"OVERWORLD",
		"WILD_BEAST",
		_ref_beast,
		"VISIBLE WILD BEAST SPAWNED" +
		" | BEAST: " +
		string_upper(
			_stct_unit._str_beast_name
		) +
		" | ELITE: " +
		(
			variable_struct_exists(
				_stct_unit,
				"_flag_elite"
			) &&
			_stct_unit._flag_elite
			? "YES (" +
				_stct_unit._str_elite_modifier +
				")"
			: "NO"
		) +
		" | ELITE ROLL: " +
		(
			variable_struct_exists(
				_stct_unit,
				"_val_elite_roll"
			)
			? string(
				_stct_unit._val_elite_roll
			) +
				"/100"
			: "N/A"
		) +
		" | ELITE CHANCE: " +
		(
			variable_struct_exists(
				_stct_unit,
				"_val_elite_chance_percent"
			)
			? string(
				_stct_unit
					._val_elite_chance_percent
			) +
				"%"
			: "N/A"
		),
		"INFO",
		"SCR_OVERWORLD_SPAWN_WILD_BEAST_FROM_ZONE"
	);
}


