//===============================================================================//
//
// SCRIPT: SCR_ENCOUNTER_ROLL_BEAST_AMOUNT
// FUNCTION: Rolls how many enemy Beasts should appear in a normal encounter.
//
// PRIMARY WEIGHT:
//           Number of Beasts in the player's active Party.
//
// SECONDARY WEIGHT:
//           Average Level of every player-owned Beast across Party + Ranch.
//
// DIFFICULTY:
//           EASY   -> biases count downward and limits encounters to 3 enemies.
//           MEDIUM -> preserves the normal Party-based result.
//           HARD   -> never finishes below active Party size and may gain +1.
//
// CURRENT ENCOUNTER LIMIT:
//           1-5 enemy Beasts.
//
// FUTURE:
//           ELITE will use an enemy-slot budget rather than ordinary count
//           modification. Elite logic is intentionally disabled.
//
// ARGUMENTS:
//           _rm_source       - overworld room initiating the encounter.
//           _str_difficulty  - EASY, MEDIUM, or HARD.
//
// RETURNS: Encounter-count result struct.
//
//===============================================================================//

function scr_encounter_roll_beast_amount(
	_rm_source=undefined,
	_str_difficulty="MEDIUM"
){

	#region PLAYER PARTY

	//================//
	//COUNT PARTY//
	//================//

	var _ct_player_party = 0;

	if (
		variable_global_exists("list_player_party") &&
		ds_exists(global.list_player_party,ds_type_list)
	){

		for (
			var _it_beast = 0;
			_it_beast < ds_list_size(global.list_player_party);
			_it_beast++
		){

			var _stct_beast =
				ds_list_find_value(
					global.list_player_party,
					_it_beast
				);

			if (!is_struct(_stct_beast)){
				continue;
			}

			_ct_player_party++;
		}
	}

	//================//
	//SAFE PARTY COUNT//
	//================//

	_ct_player_party =
		clamp(
			_ct_player_party,
			1,
			5
		);

	#endregion

	#region ACCOUNT LEVEL

	//================//
	//AVERAGE OWNED LEVEL//
	//================//

	var _val_player_avg_level =
		scr_encounter_get_player_average_level();

	#endregion

	#region ZONE LEVEL

	//================//
	//GET ZONE RANGE//
	//================//

	var _stct_zone =
		scr_encounter_get_zone_level_range(
			_rm_source
		);

	var _val_zone_min =
		_stct_zone._val_level_min;

	var _val_zone_max =
		_stct_zone._val_level_max;

	var _val_zone_mid =
		(
			_val_zone_min +
			_val_zone_max
		) * 0.5;

	#endregion

	#region DIFFICULTY

	//================//
	//VALIDATE DIFFICULTY//
	//================//

	_str_difficulty =
		string_upper(
			_str_difficulty
		);

	if (
		_str_difficulty != "EASY" &&
		_str_difficulty != "MEDIUM" &&
		_str_difficulty != "HARD"
	){
		_str_difficulty = "MEDIUM";
	}

	#endregion

	#region BASE ENCOUNTER POOL

	var _arr_amount_pool = [];

	var _ct_party_range_min = 1;
	var _ct_party_range_max = 3;

	//================//
	//ONE PARTY BEAST//
	//================//

	if (_ct_player_party == 1){

		_arr_amount_pool = [
			1,
			2,
			2,
			2,
			3
		];

		_ct_party_range_min = 1;
		_ct_party_range_max = 3;
	}

	//================//
	//TWO PARTY BEASTS//
	//================//

	else if (_ct_player_party == 2){

		_arr_amount_pool = [
			1,
			2,
			2,
			3,
			3
		];

		_ct_party_range_min = 1;
		_ct_party_range_max = 3;
	}

	//==================//
	//THREE PARTY BEASTS//
	//==================//

	else if (_ct_player_party == 3){

		_arr_amount_pool = [
			2,
			3,
			3,
			4,
			4,
			5
		];

		_ct_party_range_min = 2;
		_ct_party_range_max = 5;
	}

	//=================//
	//FOUR PARTY BEASTS//
	//=================//

	else if (_ct_player_party == 4){

		_arr_amount_pool = [
			3,
			3,
			4,
			4,
			5,
			5
		];

		_ct_party_range_min = 3;
		_ct_party_range_max = 5;
	}

	//=================//
	//FIVE PARTY BEASTS//
	//=================//

	else{

		_arr_amount_pool = [
			3,
			4,
			4,
			5,
			5,
			5
		];

		_ct_party_range_min = 3;
		_ct_party_range_max = 5;
	}

	#endregion

	#region BASE ROLL

	//================//
	//ROLL ENEMY COUNT//
	//================//

	var _ct_enemy_beasts =
		_arr_amount_pool[
			irandom(
				array_length(
					_arr_amount_pool
				) - 1
			)
		];

	var _ct_base_enemy_beasts =
		_ct_enemy_beasts;

	#endregion

	#region OWNED LEVEL PRESSURE

	//================//
	//COMPARE TO ZONE//
	//================//

	var _val_level_difference =
		_val_player_avg_level -
		_val_zone_mid;

	var _val_level_adjustment = 0;

	//================//
	//HIGH LEVEL PLAYER//
	//================//

	if (_val_level_difference >= 5){

		if (irandom_range(1,100) <= 25){
			_val_level_adjustment = 1;
		}
	}

	//================//
	//LOW LEVEL PLAYER//
	//================//

	else if (_val_level_difference <= -5){

		if (irandom_range(1,100) <= 25){
			_val_level_adjustment = -1;
		}
	}

	//================//
	//APPLY PRESSURE//
	//================//

	_ct_enemy_beasts +=
		_val_level_adjustment;

	#endregion

	#region DIFFICULTY COUNT

	var _ct_before_difficulty =
		_ct_enemy_beasts;

	//================//
	//EASY//
	//================//

	if (_str_difficulty == "EASY"){

		// Easy usually removes one enemy from the normal result.
		if (irandom_range(1,100) <= 65){
			_ct_enemy_beasts--;
		}

		// Preserve some Party-size influence while keeping EASY encounters
		// within the intended 1-3 enemy range.
		var _ct_easy_min =
			max(
				1,
				_ct_party_range_min - 1
			);

		var _ct_easy_max =
			min(
				3,
				_ct_party_range_max
			);

		_ct_enemy_beasts =
			clamp(
				_ct_enemy_beasts,
				_ct_easy_min,
				_ct_easy_max
			);
	}

	//================//
	//MEDIUM//
	//================//

	else if (_str_difficulty == "MEDIUM"){

		// Medium uses the normal Party-driven encounter range.
		_ct_enemy_beasts =
			clamp(
				_ct_enemy_beasts,
				_ct_party_range_min,
				_ct_party_range_max
			);
	}

	//================//
	//HARD//
	//================//

	else if (_str_difficulty == "HARD"){

		// Hard encounters should contain at least as many enemies as the
		// active Party whenever the normal Party range permits it.
		var _ct_hard_min =
			min(
				5,
				max(
					_ct_party_range_min,
					_ct_player_party
				)
			);

		_ct_enemy_beasts =
			max(
				_ct_enemy_beasts,
				_ct_hard_min
			);

		// Hard encounters have an additional chance to add one enemy.
		if (
			_ct_enemy_beasts < _ct_party_range_max &&
			irandom_range(1,100) <= 60
		){
			_ct_enemy_beasts++;
		}

		_ct_enemy_beasts =
			clamp(
				_ct_enemy_beasts,
				_ct_hard_min,
				_ct_party_range_max
			);
	}

	var _val_difficulty_adjustment =
		_ct_enemy_beasts -
		_ct_before_difficulty;

	//===============================================================================
	// FUTURE: ELITE ENCOUNTER SLOT BUDGET
	//===============================================================================
	//
	// else if (_str_difficulty == "ELITE"){
	//
	//     Do NOT simply increase _ct_enemy_beasts.
	//
	//     Future Elite enemies will consume one or multiple encounter slots.
	//
	//     Example:
	//
	//     Ordinary Beast = 1 slot
	//     Minor Elite    = 2 slots
	//     Major Elite    = 3 slots
	//
	//     Build the encounter by spending the rolled slot budget until no
	//     additional legal enemy can fit.
	//
	// }
	//
	//===============================================================================//

	#endregion

	#region FINALIZE

	//================//
	//ENCOUNTER LIMIT//
	//================//

	_ct_enemy_beasts =
		clamp(
			_ct_enemy_beasts,
			1,
			5
		);

	//================//
	//SOURCE ROOM//
	//================//

	var _str_source_room = "UNKNOWN";

	if (_rm_source != undefined){

		_str_source_room =
			string_upper(
				room_get_name(
					_rm_source
				)
			);
	}

	//================//
	//BUILD RESULT//
	//================//

	var _stct_result = {

		_ct_enemy_beasts :
			_ct_enemy_beasts,

		_ct_base_enemy_beasts :
			_ct_base_enemy_beasts,

		_ct_player_party :
			_ct_player_party,

		_ct_party_range_min :
			_ct_party_range_min,

		_ct_party_range_max :
			_ct_party_range_max,

		_val_player_avg_level :
			_val_player_avg_level,

		_val_zone_level_min :
			_val_zone_min,

		_val_zone_level_max :
			_val_zone_max,

		_val_zone_mid_level :
			_val_zone_mid,

		_val_level_adjustment :
			_val_level_adjustment,

		_val_difficulty_adjustment :
			_val_difficulty_adjustment,

		_str_difficulty :
			_str_difficulty,

		_str_source_room :
			_str_source_room
	};

	#endregion

	#region DEBUG

	scr_debug_log(
		"BATTLE",
		"ENCOUNTER",
		undefined,
		"ENCOUNTER SIZE ROLLED" +
		" | ROOM: " +
		_str_source_room +
		" | DIFFICULTY: " +
		_str_difficulty +
		" | PARTY: " +
		string(_ct_player_party) +
		" | OWNED AVG LVL: " +
		string_format(
			_val_player_avg_level,
			0,
			1
		) +
		" | ZONE: " +
		string(_val_zone_min) +
		"-" +
		string(_val_zone_max) +
		" | BASE ENEMIES: " +
		string(_ct_base_enemy_beasts) +
		" | LEVEL ADJUST: " +
		string(_val_level_adjustment) +
		" | DIFFICULTY ADJUST: " +
		string(_val_difficulty_adjustment) +
		" | FINAL ENEMIES: " +
		string(_ct_enemy_beasts),
		"INIT",
		"SCR_ENCOUNTER_ROLL_BEAST_AMOUNT"
	);

	#endregion

	return _stct_result;
}