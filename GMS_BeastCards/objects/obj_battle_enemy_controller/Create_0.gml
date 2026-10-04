//===============================================================================//
//
// CREATE: OBJ_BATTLE_ENEMY_CONTROLLER
// FUNCTION: Initializes enemy battle state.
//           Stores enemy Beast lists, temporary turn-processing arrays,
//           enemy level range, state flags, and the enemy state machine.
//
//===============================================================================//

//---------//
//VARIABLES//
//---------//
#region VARIABLES

//--------//
//BEASTS//
//--------//
_ct_beasts = 3;

_list_beasts = ds_list_create();
_list_beasts_alive = ds_list_create();
_list_beasts_graveyard = ds_list_create();

//-------------------//
//ENCOUNTER SCALING//
//-------------------//
_stct_encounter_scaling = undefined;

_val_enemy_level_min = 5;
_val_enemy_level_max = 10;

_str_encounter_difficulty = "MEDIUM";

//-------------//
//TURN QUEUES//
//-------------//
_arr_casting_beasts = [];
_it_casting_beast = 0;

_arr_casting_minions = [];
_it_casting_minion = 0;

_arr_statuses = [];
_it_status_queue = 0;

_arr_turn_start_items = [];
_it_turn_start_item = 0;

_arr_turn_end_items = [];
_it_turn_end_item = 0;

//------------------//
//PROCESSING FLAGS//
//------------------//
_flag_statuses_init = false;
_flag_cast_init = false;
_flag_minions_init = false;

//------------------//
//TURN START ITEMS//
//------------------//
_flag_turn_start_items_init = false;
_flag_turn_start_items_complete = false;

//----------------//
//TURN END ITEMS//
//----------------//
_flag_turn_end_items_init = false;
_flag_turn_end_items_complete = false;

#endregion

//----//
//INIT//
//----//
#region INIT

//-------------//
//ENEMY STATE//
//-------------//
enum ENUM_ENEMY_STATE{
	INIT_BEASTS,
	INIT_CARDS,
	WAIT,
	TURN_START,
	TRIGGER_MINIONS,
	CAST_CARDS,
	NEW_CARDS,
	TURN_END
}

_state_enemy =
	ENUM_ENEMY_STATE.INIT_BEASTS;

//===================//
//GET SCALING RESULT//
//===================//
if (
	variable_global_exists("stct_encounter_scaling") &&
	is_struct(global.stct_encounter_scaling)
){

	_stct_encounter_scaling =
		global.stct_encounter_scaling;

	if (
		variable_struct_exists(
			_stct_encounter_scaling,
			"_ct_enemy_beasts"
		)
	){

		_ct_beasts =
			clamp(
				round(
					_stct_encounter_scaling
						._ct_enemy_beasts
				),
				1,
				5
			);
	}

	if (
		variable_struct_exists(
			_stct_encounter_scaling,
			"_val_zone_level_min"
		)
	){

		_val_enemy_level_min =
			max(
				1,
				round(
					_stct_encounter_scaling
						._val_zone_level_min
				)
			);
	}

	if (
		variable_struct_exists(
			_stct_encounter_scaling,
			"_val_zone_level_max"
		)
	){

		_val_enemy_level_max =
			max(
				_val_enemy_level_min,
				round(
					_stct_encounter_scaling
						._val_zone_level_max
				)
			);
	}

	if (
		variable_struct_exists(
			_stct_encounter_scaling,
			"_str_difficulty"
		)
	){

		_str_encounter_difficulty =
			string_upper(
				_stct_encounter_scaling
					._str_difficulty
			);
	}

	global.stct_encounter_scaling =
		undefined;
}

var _ct_encounter_pool = 0;
var _flag_forced_enemy = false;

if (
	variable_global_exists("arr_last_enemy_pool") &&
	is_array(global.arr_last_enemy_pool)
){

	_ct_encounter_pool =
		array_length(
			global.arr_last_enemy_pool
		);
}

if (
	variable_global_exists("stct_forced_enemy_unit") &&
	is_struct(global.stct_forced_enemy_unit)
){
	_flag_forced_enemy = true;
}

scr_debug_log(
	"BATTLE",
	"ENEMY",
	self,
	"ENEMY BATTLE CONTROLLER INITIALIZED | TEAM SIZE: " +
	string(_ct_beasts) +
	" | DIFFICULTY: " +
	_str_encounter_difficulty +
	" | LEVEL RANGE: " +
	string(_val_enemy_level_min) +
	"-" +
	string(_val_enemy_level_max) +
	" | ENCOUNTER POOL: " +
	string(_ct_encounter_pool) +
	" | FORCED SLOT 0: " +
	(_flag_forced_enemy ? "YES" : "NO") +
	" | SCALING ROLL: " +
	(is_struct(_stct_encounter_scaling) ? "YES" : "NO"),
	"INIT",
	"OBJ_BATTLE_ENEMY_CONTROLLER:CREATE"
);

#endregion

#region METHODS

//—------------------------------------------------------------------------------//
// hscr_battle_enemy_get_random_living
//—------------------------------------------------------------------------------//
hscr_battle_enemy_get_random_living = function(_list_targets,_ref_exclude=undefined){

	if (!ds_exists(_list_targets,ds_type_list)){
		return undefined;
	}

	var _arr_targets = [];

	for (
		var _it_target = 0;
		_it_target < ds_list_size(_list_targets);
		_it_target++
	){

		var _ref_target =
			ds_list_find_value(
				_list_targets,
				_it_target
			);

		if (!instance_exists(_ref_target)){
			continue;
		}

		if (_ref_target == _ref_exclude){
			continue;
		}

		if (
			_ref_target._str_list != "ALIVE" ||
			_ref_target._val_cur_hp <= 0
		){
			continue;
		}

		array_push(
			_arr_targets,
			_ref_target
		);
	}

	if (array_length(_arr_targets) <= 0){
		return undefined;
	}

	return _arr_targets[
		irandom(
			array_length(_arr_targets) - 1
		)
	];
};

//—------------------------------------------------------------------------------//
// hscr_battle_enemy_get_hostile_target
//—------------------------------------------------------------------------------//
hscr_battle_enemy_get_hostile_target = function(_ref_caster,_stct_card){

	if (!instance_exists(_ref_caster)){
		return undefined;
	}

	if (!is_struct(_stct_card)){
		return undefined;
	}

	if (!instance_exists(obj_battle_player_controller)){
		return undefined;
	}

	var _list_targets =
		obj_battle_player_controller
			._list_beasts_alive;

	if (!ds_exists(_list_targets,ds_type_list)){
		return undefined;
	}

	if (ds_list_size(_list_targets) <= 0){
		return undefined;
	}

	var _str_range =
		_stct_card._str_card_range;

	if (_str_range == "GLOBAL"){
		return "GLOBAL";
	}

	if (_str_range == "SELF"){
		return _ref_caster;
	}

	var _flag_hostile_target =
		scr_battle_is_hostile_card_target(
			_stct_card
		);

	if (_flag_hostile_target){

		var _ref_taunt_target =
			scr_status_get_taunt_target(
				_list_targets
			);

		if (
			instance_exists(_ref_taunt_target) &&
			_ref_taunt_target._str_list == "ALIVE" &&
			_ref_taunt_target._val_cur_hp > 0
		){
			return _ref_taunt_target;
		}

		var _str_blind_mode =
			scr_cc_get_blind_attack_target_mode(
				_ref_caster,
				_stct_card
			);

		if (_str_blind_mode == "BLOCK"){
			return undefined;
		}

		if (_str_blind_mode == "FRONT"){

			for (
				var _it_front = 0;
				_it_front < ds_list_size(_list_targets);
				_it_front++
			){

				var _ref_front =
					ds_list_find_value(
						_list_targets,
						_it_front
					);

				if (
					instance_exists(_ref_front) &&
					_ref_front._str_list == "ALIVE" &&
					_ref_front._val_cur_hp > 0
				){
					return _ref_front;
				}
			}

			return undefined;
		}
	}

	switch(_str_range){

		case "MELEE":

			for (
				var _it_front = 0;
				_it_front < ds_list_size(_list_targets);
				_it_front++
			){

				var _ref_front =
					ds_list_find_value(
						_list_targets,
						_it_front
					);

				if (
					instance_exists(_ref_front) &&
					_ref_front._str_list == "ALIVE" &&
					_ref_front._val_cur_hp > 0
				){
					return _ref_front;
				}
			}

		break;

		case "RANGED":
		case "ENEMY":

			return hscr_battle_enemy_get_random_living(
				_list_targets
			);

		break;

		case "BACK":
		case "FLANK":

			for (
				var _it_back =
					ds_list_size(_list_targets) - 1;
				_it_back >= 0;
				_it_back--
			){

				var _ref_back =
					ds_list_find_value(
						_list_targets,
						_it_back
					);

				if (
					instance_exists(_ref_back) &&
					_ref_back._str_list == "ALIVE" &&
					_ref_back._val_cur_hp > 0
				){
					return _ref_back;
				}
			}

		break;
	}

	return undefined;
};

//—------------------------------------------------------------------------------//
// hscr_battle_enemy_get_friendly_target
//—------------------------------------------------------------------------------//
hscr_battle_enemy_get_friendly_target = function(_ref_caster,_stct_card,_flag_prefer_front=false){

	if (!instance_exists(_ref_caster)){
		return undefined;
	}

	if (!is_struct(_stct_card)){
		return undefined;
	}

	if (!ds_exists(_list_beasts_alive,ds_type_list)){
		return undefined;
	}

	var _str_range =
		_stct_card._str_card_range;

	if (_str_range == "GLOBAL"){
		return "GLOBAL";
	}

	if (_str_range == "SELF"){
		return _ref_caster;
	}

	if (_str_range == "TEAM"){

		return hscr_battle_enemy_get_random_living(
			_list_beasts_alive,
			_ref_caster
		);
	}

	if (random(1) >= 0.20){
		return _ref_caster;
	}

	if (_flag_prefer_front){

		for (
			var _it_front = 0;
			_it_front < ds_list_size(_list_beasts_alive);
			_it_front++
		){

			var _ref_front =
				ds_list_find_value(
					_list_beasts_alive,
					_it_front
				);

			if (
				!instance_exists(_ref_front) ||
				_ref_front._str_list != "ALIVE" ||
				_ref_front._val_cur_hp <= 0
			){
				continue;
			}

			if (_ref_front != _ref_caster){
				return _ref_front;
			}

			break;
		}
	}

	var _ref_ally =
		hscr_battle_enemy_get_random_living(
			_list_beasts_alive,
			_ref_caster
		);

	if (instance_exists(_ref_ally)){
		return _ref_ally;
	}

	return _ref_caster;
};

//—------------------------------------------------------------------------------//
// hscr_battle_enemy_get_heal_target
//—------------------------------------------------------------------------------//
hscr_battle_enemy_get_heal_target = function(_ref_caster,_stct_card){

	if (!instance_exists(_ref_caster)){
		return undefined;
	}

	if (!is_struct(_stct_card)){
		return undefined;
	}

	if (!ds_exists(_list_beasts_alive,ds_type_list)){
		return undefined;
	}

	var _str_range =
		_stct_card._str_card_range;

	if (_str_range == "GLOBAL"){
		return "GLOBAL";
	}

	if (_str_range == "SELF"){
		return _ref_caster;
	}

	var _ref_lowest_hp =
		undefined;

	for (
		var _it_ally = 0;
		_it_ally < ds_list_size(_list_beasts_alive);
		_it_ally++
	){

		var _ref_ally =
			ds_list_find_value(
				_list_beasts_alive,
				_it_ally
			);

		if (!instance_exists(_ref_ally)){
			continue;
		}

		if (
			_ref_ally._str_list != "ALIVE" ||
			_ref_ally._val_cur_hp <= 0
		){
			continue;
		}

		if (
			_str_range == "TEAM" &&
			_ref_ally == _ref_caster
		){
			continue;
		}

		if (
			!instance_exists(_ref_lowest_hp) ||
			_ref_ally._val_cur_hp <
				_ref_lowest_hp._val_cur_hp
		){

			_ref_lowest_hp =
				_ref_ally;
		}
	}

	return _ref_lowest_hp;
};

#endregion