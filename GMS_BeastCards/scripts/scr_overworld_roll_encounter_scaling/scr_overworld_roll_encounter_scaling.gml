//===============================================================================//
//
// SCRIPT: SCR_OVERWORLD_ROLL_ENCOUNTER_SCALING
// FUNCTION: Creates the complete scaling data for a normal wild encounter.
//
//           Rolls:
//
//           - Encounter difficulty.
//           - Enemy count from active Party size.
//           - Small count pressure from Party + Ranch average Level.
//           - Zone Level range.
//           - Difficulty/player-biased enemy Level target.
//
//           The zone Level range always remains authoritative. Player scaling
//           cannot lower an encounter below the zone minimum or raise it above
//           the zone maximum.
//
// ARGUMENTS:
//           _rm_source - overworld room initiating the encounter.
//           _str_difficulty_override - optional EASY / MEDIUM / HARD override.
//                                      Undefined preserves the normal random roll.
//
// RETURNS: Complete encounter scaling struct.
//
//===============================================================================//

function scr_overworld_roll_encounter_scaling(
	_rm_source=undefined,
	_str_difficulty_override=undefined
){

	#region SOURCE ROOM

	if (_rm_source == undefined){
		_rm_source = room;
	}

	#endregion

	#region DIFFICULTY

	//================//
	//GET DIFFICULTY//
	//================//

	var _str_difficulty =
		"";

	if (
		_str_difficulty_override !=
		undefined
	){

		var _str_override =
			string_upper(
				string(
					_str_difficulty_override
				)
			);

		if (
			_str_override == "EASY" ||
			_str_override == "MEDIUM" ||
			_str_override == "HARD"
		){
			_str_difficulty =
				_str_override;
		}
	}

	//----------------//
	//NORMAL RANDOM ROLL//
	//----------------//
	if (_str_difficulty == ""){

		_str_difficulty =
			scr_encounter_roll_difficulty();
	}

	#endregion

	#region ENCOUNTER AMOUNT

	//================//
	//ROLL ENEMY COUNT//
	//================//

	var _stct_amount =
		scr_encounter_roll_beast_amount(
			_rm_source,
			_str_difficulty
		);

	#endregion

	#region LEVEL TARGET

	var _val_zone_min =
		_stct_amount._val_zone_level_min;

	var _val_zone_max =
		_stct_amount._val_zone_level_max;

	var _val_player_avg =
		_stct_amount._val_player_avg_level;

	//===================//
	//ZONE-SAFE PLAYER LEVEL//
	//===================//

	var _val_player_zone_anchor =
		clamp(
			round(
				_val_player_avg
			),
			_val_zone_min,
			_val_zone_max
		);

	//================//
	//DIFFICULTY OFFSET//
	//================//

	var _val_difficulty_level_offset = 0;

	switch (_str_difficulty){

		case "EASY":
			_val_difficulty_level_offset = -1;
		break;

		case "MEDIUM":
			_val_difficulty_level_offset = 0;
		break;

		case "HARD":
			_val_difficulty_level_offset = 1;
		break;
	}

	//================//
	//LEVEL TARGET//
	//================//

	var _val_enemy_level_target =
		clamp(
			_val_player_zone_anchor +
			_val_difficulty_level_offset,
			_val_zone_min,
			_val_zone_max
		);

	// Player-owned average only nudges individual enemy rolls toward this
	// target. Enemy Levels are still rolled from the complete zone range.
	var _val_player_level_pull_chance = 35;

	#endregion

	#region RESULT

	var _stct_result = {

		_str_difficulty :
			_str_difficulty,

		_ct_enemy_beasts :
			_stct_amount._ct_enemy_beasts,

		_ct_base_enemy_beasts :
			_stct_amount._ct_base_enemy_beasts,

		_ct_player_party :
			_stct_amount._ct_player_party,

		_val_player_avg_level :
			_val_player_avg,

		_val_zone_level_min :
			_val_zone_min,

		_val_zone_level_max :
			_val_zone_max,

		_val_zone_mid_level :
			_stct_amount._val_zone_mid_level,

		_val_enemy_level_target :
			_val_enemy_level_target,

		_val_player_level_pull_chance :
			_val_player_level_pull_chance,

		_val_level_adjustment :
			_stct_amount._val_level_adjustment,

		_val_difficulty_adjustment :
			_stct_amount._val_difficulty_adjustment,

		_str_source_room :
			_stct_amount._str_source_room
	};

	#endregion

	#region FUTURE SCALING

	//===============================================================================
	// FUTURE: STORY / MILESTONE SCALING
	//===============================================================================
	//
	// Later progression milestones may modify encounter pressure AFTER the normal
	// zone / Party / owned-Level result has been calculated.
	//
	// Examples:
	//
	// - Story chapter progression.
	// - Dungeon completion.
	// - Runestone activation.
	// - New Game+ or other postgame progression.
	//
	// Do not implement until milestone progression rules are finalized.
	//
	//===============================================================================//

	//===============================================================================
	// FUTURE: ELITE ENCOUNTERS
	//===============================================================================
	//
	// ELITE difficulty is intentionally disabled.
	//
	// Future Elite encounters should:
	//
	// - Use this same base encounter result.
	// - Convert enemy count into an encounter-slot budget.
	// - Allow Elite Beasts to consume one or multiple slots.
	// - Give Elite Beasts their additional Card / passive / starting effects.
	// - Remain more difficult than HARD encounters.
	// - Remain mechanically simpler than miniboss and boss battles.
	//
	//===============================================================================//

	#endregion

	#region DEBUG

	scr_debug_log(
		"BATTLE",
		"ENCOUNTER",
		undefined,
		"ENCOUNTER SCALING COMPLETE" +
		" | ROOM: " +
		_stct_result._str_source_room +
		" | DIFFICULTY: " +
		_stct_result._str_difficulty +
		" | PARTY: " +
		string(
			_stct_result._ct_player_party
		) +
		" | OWNED AVG: " +
		string_format(
			_stct_result._val_player_avg_level,
			0,
			1
		) +
		" | ENEMIES: " +
		string(
			_stct_result._ct_enemy_beasts
		) +
		" | ZONE LEVELS: " +
		string(
			_stct_result._val_zone_level_min
		) +
		"-" +
		string(
			_stct_result._val_zone_level_max
		) +
		" | LEVEL TARGET: " +
		string(
			_stct_result._val_enemy_level_target
		),
		"INIT",
		"SCR_OVERWORLD_ROLL_ENCOUNTER_SCALING"
	);

	#endregion

	return _stct_result;
}
