//===============================================================================//
//
// SCRIPT: SCR_REWARD_CALCULATE_BATTLE_GRADE
// FUNCTION: Calculates the post-battle reward score from battle duration,
//           final Party HP, encounter difficulty, and actual team-Level disparity.
//
//           The player-facing result is a raw 0-100 score.
//           Reward bonuses preserve the previous five-step scaling internally,
//           but no star grade is created or returned.
//
// ARGUMENTS: _ref_player_controller - Player battle controller.
//            _ref_enemy_controller - Enemy battle controller.
//            _val_elapsed_seconds - Gameplay duration after START BATTLE.
// RETURNS: Complete battle-score struct used by reward resolution and result GUI.
//
//===============================================================================//

function scr_reward_calculate_battle_grade(
	_ref_player_controller,
	_ref_enemy_controller,
	_val_elapsed_seconds
){

	#region VARIABLES

	_val_elapsed_seconds =
		max(
			0,
			_val_elapsed_seconds
		);

	var _val_hp_total = 0;
	var _val_hp_max_total = 0;

	var _val_time_score = 0;
	var _val_hp_score = 0;
	var _val_difficulty_score = 0;
	var _val_disparity_score = 0;

	var _str_difficulty = "MEDIUM";

	#endregion

	#region FINAL PARTY HP

	if (
		instance_exists(_ref_player_controller) &&
		ds_exists(
			_ref_player_controller._list_beasts,
			ds_type_list
		)
	){

		for (
			var _it_beast = 0;
			_it_beast <
				ds_list_size(
					_ref_player_controller._list_beasts
				);
			_it_beast++
		){

			var _ref_beast =
				ds_list_find_value(
					_ref_player_controller._list_beasts,
					_it_beast
				);

			if (!instance_exists(_ref_beast)){
				continue;
			}

			var _val_max_hp =
				max(
					1,
					_ref_beast._val_max_hp
				);

			_val_hp_max_total +=
				_val_max_hp;

			_val_hp_total +=
				clamp(
					_ref_beast._val_cur_hp,
					0,
					_val_max_hp
				);
		}
	}

	var _val_hp_ratio = 0;

	if (_val_hp_max_total > 0){

		_val_hp_ratio =
			clamp(
				_val_hp_total /
					_val_hp_max_total,
				0,
				1
			);
	}

	#endregion

	#region TIME SCORE

	if (_val_elapsed_seconds <= 0){

		_val_time_score = 0;
	}
	else if (_val_elapsed_seconds <= 45){

		_val_time_score = 40;
	}
	else if (_val_elapsed_seconds <= 75){

		_val_time_score = 35;
	}
	else if (_val_elapsed_seconds <= 120){

		_val_time_score = 30;
	}
	else if (_val_elapsed_seconds <= 180){

		_val_time_score = 22;
	}
	else if (_val_elapsed_seconds <= 300){

		_val_time_score = 12;
	}
	else{

		_val_time_score = 5;
	}

	#endregion

	#region HP SCORE

	if (_val_hp_ratio >= 0.90){

		_val_hp_score = 40;
	}
	else if (_val_hp_ratio >= 0.80){

		_val_hp_score = 35;
	}
	else if (_val_hp_ratio >= 0.65){

		_val_hp_score = 28;
	}
	else if (_val_hp_ratio >= 0.50){

		_val_hp_score = 20;
	}
	else if (_val_hp_ratio >= 0.25){

		_val_hp_score = 10;
	}

	#endregion

	#region DIFFICULTY SCORE

	if (
		instance_exists(_ref_enemy_controller) &&
		variable_instance_exists(
			_ref_enemy_controller,
			"_str_encounter_difficulty"
		)
	){

		_str_difficulty =
			string_upper(
				string(
					_ref_enemy_controller
						._str_encounter_difficulty
				)
			);
	}
	else if (
		variable_global_exists(
			"stct_encounter_scaling"
		) &&
		is_struct(
			global.stct_encounter_scaling
		) &&
		variable_struct_exists(
			global.stct_encounter_scaling,
			"_str_difficulty"
		)
	){

		_str_difficulty =
			string_upper(
				string(
					global.stct_encounter_scaling
						._str_difficulty
				)
			);
	}

	switch (_str_difficulty){

		case "EASY":

			_val_difficulty_score = 0;

		break;

		case "MEDIUM":

			_val_difficulty_score = 5;

		break;

		case "HARD":

			_val_difficulty_score = 10;

		break;

		case "ELITE":

			_val_difficulty_score = 15;

		break;

		default:

			_val_difficulty_score = 5;
			_str_difficulty = "MEDIUM";

		break;
	}

	#endregion

	#region LEVEL DISPARITY

	var _val_player_avg_level =
		scr_battle_get_team_average_level(
			"PLAYER"
		);

	var _val_enemy_avg_level =
		scr_battle_get_team_average_level(
			"ENEMY"
		);

	var _val_level_disparity =
		_val_enemy_avg_level -
		_val_player_avg_level;

	if (_val_level_disparity >= 5){

		_val_disparity_score = 5;
	}
	else if (_val_level_disparity >= 3){

		_val_disparity_score = 4;
	}
	else if (_val_level_disparity >= 1){

		_val_disparity_score = 2;
	}

	#endregion

	#region FINAL SCORE

	var _val_score =
		clamp(
			_val_time_score +
			_val_hp_score +
			_val_difficulty_score +
			_val_disparity_score,
			0,
			100
		);

	#endregion

	#region REWARD SCALING

	/*
		Preserve the previous five reward bands without exposing
		a star grade to the player.

		SCORE 0-29   = Reward Tier 1
		SCORE 30-49  = Reward Tier 2
		SCORE 50-64  = Reward Tier 3
		SCORE 65-79  = Reward Tier 4
		SCORE 80-100 = Reward Tier 5

		This means switching the GUI from stars to SCORE is purely
		presentational and does not rebalance existing reward bonuses.
	*/

	var _ct_reward_tier = 1;

	if (_val_score >= 80){

		_ct_reward_tier = 5;
	}
	else if (_val_score >= 65){

		_ct_reward_tier = 4;
	}
	else if (_val_score >= 50){

		_ct_reward_tier = 3;
	}
	else if (_val_score >= 30){

		_ct_reward_tier = 2;
	}

	var _stct_config =
		scr_reward_get_battle_roll_config();

	var _val_optional_chance_bonus =
		max(
			0,
			(_ct_reward_tier - 1) *
				_stct_config._val_grade_chance_per_star
		);

	var _val_gold_multiplier =
		1 +
		max(
			0,
			(_ct_reward_tier - 1) *
				_stct_config._val_gold_bonus_per_star
		);

	#endregion

	#region RESULT

	return {
		_val_score : _val_score,

		_val_elapsed_seconds :
			_val_elapsed_seconds,

		_val_hp_ratio :
			_val_hp_ratio,

		_str_difficulty :
			_str_difficulty,

		_val_player_avg_level :
			_val_player_avg_level,

		_val_enemy_avg_level :
			_val_enemy_avg_level,

		_val_level_disparity :
			_val_level_disparity,

		_val_time_score :
			_val_time_score,

		_val_hp_score :
			_val_hp_score,

		_val_difficulty_score :
			_val_difficulty_score,

		_val_disparity_score :
			_val_disparity_score,

		_val_optional_chance_bonus :
			_val_optional_chance_bonus,

		_val_gold_multiplier :
			_val_gold_multiplier
	};

	#endregion
}