//===============================================================================//
//
// SCRIPT: SCR_ENCOUNTER_ROLL_ENEMY_LEVEL
// FUNCTION: Rolls one enemy Beast Level from an encounter-scaling struct.
//
//           Zone range is always authoritative.
//
//           EASY:
//           Rolls twice and keeps the LOWER result.
//
//           MEDIUM:
//           Rolls normally across the zone.
//
//           HARD:
//           Rolls twice and keeps the HIGHER result.
//
//           After the zone roll, owned-Beast average Level has a small chance
//           to move the result ONE Level toward the encounter's target.
//
// ARGUMENTS:
//           _stct_encounter - encounter scaling struct.
//
// RETURNS:
//           Rolled enemy Level, or undefined when the encounter struct is invalid.
//
//===============================================================================//

function scr_encounter_roll_enemy_level(
	_stct_encounter
){

	#region VALIDATION

	if (!is_struct(_stct_encounter)){
		return undefined;
	}

	if (
		!variable_struct_exists(
			_stct_encounter,
			"_val_zone_level_min"
		) ||
		!variable_struct_exists(
			_stct_encounter,
			"_val_zone_level_max"
		)
	){
		return undefined;
	}

	#endregion

	#region VARIABLES

	var _val_zone_min =
		max(
			1,
			round(
				_stct_encounter
					._val_zone_level_min
			)
		);

	var _val_zone_max =
		max(
			_val_zone_min,
			round(
				_stct_encounter
					._val_zone_level_max
			)
		);

	var _str_difficulty = "MEDIUM";

	if (
		variable_struct_exists(
			_stct_encounter,
			"_str_difficulty"
		)
	){
		_str_difficulty =
			string_upper(
				_stct_encounter
					._str_difficulty
			);
	}

	var _val_target =
		round(
			(
				_val_zone_min +
				_val_zone_max
			) * 0.5
		);

	if (
		variable_struct_exists(
			_stct_encounter,
			"_val_enemy_level_target"
		)
	){
		_val_target =
			clamp(
				round(
					_stct_encounter
						._val_enemy_level_target
				),
				_val_zone_min,
				_val_zone_max
			);
	}

	var _val_pull_chance = 35;

	if (
		variable_struct_exists(
			_stct_encounter,
			"_val_player_level_pull_chance"
		)
	){
		_val_pull_chance =
			clamp(
				_stct_encounter
					._val_player_level_pull_chance,
				0,
				100
			);
	}

	#endregion

	#region ZONE ROLL

	var _val_roll_a =
		irandom_range(
			_val_zone_min,
			_val_zone_max
		);

	var _val_enemy_level =
		_val_roll_a;

	//================//
	//EASY//
	//================//

	if (_str_difficulty == "EASY"){

		var _val_roll_b =
			irandom_range(
				_val_zone_min,
				_val_zone_max
			);

		_val_enemy_level =
			min(
				_val_roll_a,
				_val_roll_b
			);
	}

	//================//
	//HARD//
	//================//

	else if (_str_difficulty == "HARD"){

		var _val_roll_b =
			irandom_range(
				_val_zone_min,
				_val_zone_max
			);

		_val_enemy_level =
			max(
				_val_roll_a,
				_val_roll_b
			);
	}

	// MEDIUM intentionally keeps the original single uniform zone roll.

	//===============================================================================
	// FUTURE: ELITE
	//===============================================================================
	//
	// else if (_str_difficulty == "ELITE"){
	//
	//     Elite Level generation can receive its own upper-zone or above-zone
	//     rules once Elite encounters are implemented.
	//
	// }
	//
	//===============================================================================//

	#endregion

	#region PLAYER LEVEL PULL

	//================//
	//SMALL OWNED-LEVEL INFLUENCE//
	//================//

	if (
		_val_enemy_level != _val_target &&
		irandom_range(1,100) <= _val_pull_chance
	){

		_val_enemy_level +=
			sign(
				_val_target -
				_val_enemy_level
			);
	}

	#endregion

	#region FINALIZE

	return
		clamp(
			round(
				_val_enemy_level
			),
			_val_zone_min,
			_val_zone_max
		);

	#endregion
}