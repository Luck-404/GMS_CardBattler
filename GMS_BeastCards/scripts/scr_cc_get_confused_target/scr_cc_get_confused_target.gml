
//===============================================================================//
//
// SCRIPT: SCR_CC_GET_CONFUSED_TARGET
// FUNCTION: Randomizes hostile Beast targeting while the caster is Confused.
//           On a successful Confuse roll, selects a DIFFERENT random living
//           Beast from either team, including the caster and allied Beasts.
//           The original target is excluded from the random pool.
//
//           Applies to cards originally targeting a hostile Beast,
//           regardless of Card Type or Effect Type.
//
//           Excludes Self, Global, Teamwide, Card, and Corpse targeting.
//           If no alternative living Beast exists, keeps the original target.
//
// RETURNS: The original or randomly selected Beast target.
//
//===============================================================================//

function scr_cc_get_confused_target(_ref_caster,_ref_target,_stct_card){

	#region VALIDATION

	//----------------//
	//VALIDATE CASTER//
	//----------------//
	if (!is_handle(_ref_caster) && !is_real(_ref_caster)){
		return _ref_target;
	}

	if (!instance_exists(_ref_caster)){
		return _ref_target;
	}

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	// Instance IDs can be handles rather than real numbers.
	// Reject strings such as "GLOBAL".

	if (!is_handle(_ref_target) && !is_real(_ref_target)){
		return _ref_target;
	}

	if (!instance_exists(_ref_target)){
		return _ref_target;
	}

	//---------------//
	//VALIDATE CARD//
	//---------------//
	if (!is_struct(_stct_card)){
		return _ref_target;
	}

	if (
		!is_struct(_ref_caster._ref_unit) ||
		!is_struct(_ref_target._ref_unit)
	){
		return _ref_target;
	}

	//=======================//
	//HOSTILE TARGETS ONLY//
	//=======================//
	if (_ref_target._str_team == _ref_caster._str_team){
		return _ref_target;
	}

	if (
		_ref_target._str_list != "ALIVE" ||
		_ref_target._val_cur_hp <= 0
	){
		return _ref_target;
	}

	#endregion

	#region TARGETING EXCLUSIONS

	//=====================//
	//EXCLUDE SPECIAL RANGE//
	//=====================//
	if (
		_stct_card._str_card_range == "SELF" ||
		_stct_card._str_card_range == "GLOBAL" ||
		_stct_card._str_card_range == "TEAM" ||
		_stct_card._str_card_range == "ENEMY_CARD" ||
		_stct_card._str_card_range == "CORPSE" ||
		_stct_card._str_card_range == "CORPSE_OPTIONAL"
	){
		return _ref_target;
	}

	//=========================//
	//EXCLUDE NON-SINGLE CENTER//
	//=========================//
	if (
		_stct_card._str_card_target_count == "SELF" ||
		_stct_card._str_card_target_count == "TEAMWIDE" ||
		_stct_card._str_card_target_count == "GLOBAL"
	){
		return _ref_target;
	}

	#endregion

	#region CONFUSED STATUS

	//================//
	//CHECK CONFUSED//
	//================//
	var _ref_confused = scr_status_check(
		"CONFUSED",
		_ref_caster
	);

	if (_ref_confused == -1){
		return _ref_target;
	}

	if (!instance_exists(_ref_confused)){
		return _ref_target;
	}

	if (_ref_confused._val_status_lifetime <= 0){
		return _ref_target;
	}

	#endregion

	#region CONFUSE ROLL

	//================//
	//ROLL 1-100//
	//================//
	var _val_roll = irandom_range(1,100);

	var _val_chance = clamp(
		_ref_confused._val_status_magnitude,
		0,
		100
	);

	//=====================//
	//NORMAL TARGET RESULT//
	//=====================//
	if (_val_roll > _val_chance){

		scr_debug_log(
			"BATTLE",
			"CONFUSED",
			_ref_caster,
			"CONFUSE ROLL: " +
				string(_val_roll) +
				"/100 | CHANCE: " +
				string(_val_chance) +
				"% | NORMAL TARGET | CARD: " +
				string_upper(_stct_card._str_card_name),
			"BATTLE",
			"SCR_CC_GET_CONFUSED_TARGET"
		);

		return _ref_target;
	}

	#endregion

	#region RANDOM TARGET POOL

	//======================//
	//COLLECT BOTH TEAMS//
	//======================//
	var _arr_team_lists = [];

	if (instance_exists(obj_battle_player_controller)){

		array_push(
			_arr_team_lists,
			obj_battle_player_controller._list_beasts_alive
		);
	}

	if (instance_exists(obj_battle_enemy_controller)){

		array_push(
			_arr_team_lists,
			obj_battle_enemy_controller._list_beasts_alive
		);
	}

	var _arr_targets = [];

	//====================//
	//COLLECT ALL BEASTS//
	//====================//
	for (
		var _it_team = 0;
		_it_team < array_length(_arr_team_lists);
		_it_team++
	){

		var _list_beasts = _arr_team_lists[_it_team];

		if (!ds_exists(_list_beasts,ds_type_list)){
			continue;
		}

		for (
			var _it_beast = 0;
			_it_beast < ds_list_size(_list_beasts);
			_it_beast++
		){

			var _ref_beast = ds_list_find_value(
				_list_beasts,
				_it_beast
			);

			if (!instance_exists(_ref_beast)){
				continue;
			}

			if (
				_ref_beast._str_list != "ALIVE" ||
				_ref_beast._val_cur_hp <= 0
			){
				continue;
			}

			if (!is_struct(_ref_beast._ref_unit)){
				continue;
			}

			//================================//
			//EXCLUDE THE ORIGINAL TARGET//
			//================================//
			// A successful Confuse roll must change the target.
			// The caster and other allies remain eligible.

			if (_ref_beast == _ref_target){
				continue;
			}

			array_push(
				_arr_targets,
				_ref_beast
			);
		}
	}

	//=======================//
	//NO ALTERNATIVE TARGETS//
	//=======================//
	if (array_length(_arr_targets) <= 0){

		scr_debug_log(
			"BATTLE",
			"CONFUSED",
			_ref_caster,
			"CONFUSE ROLL: " +
				string(_val_roll) +
				"/100 | CHANCE: " +
				string(_val_chance) +
				"% | NO ALTERNATIVE TARGET | CARD: " +
				string_upper(_stct_card._str_card_name),
			"BATTLE",
			"SCR_CC_GET_CONFUSED_TARGET"
		);

		return _ref_target;
	}

	#endregion

	#region REDIRECT

	//=====================//
	//PICK RANDOM BEAST//
	//=====================//
	var _ref_new_target = _arr_targets[
		irandom(array_length(_arr_targets) - 1)
	];

	//==========//
	//FEEDBACK//
	//==========//
	scr_gui_spawn_popup_scrolling(
		"TEXT",
		"CONFUSED!",
		undefined,
		c_maroon,
		_ref_caster.x,
		_ref_caster.y - 48
	);

	//================//
	//DEBUG RESULT//
	//================//
	scr_debug_log(
		"BATTLE",
		"CONFUSED",
		_ref_caster,
		"CONFUSE ROLL: " +
			string(_val_roll) +
			"/100 | REDIRECTED " +
			string_upper(_stct_card._str_card_name) +
			" | " +
			string_upper(_ref_target._ref_unit._str_beast_name) +
			" -> " +
			string_upper(_ref_new_target._ref_unit._str_beast_name) +
			" | TEAM: " +
			string_upper(_ref_new_target._str_team),
		"BATTLE",
		"SCR_CC_GET_CONFUSED_TARGET"
	);

	return _ref_new_target;

	#endregion
}