//===============================================================================//
//
// CREATE: OBJ_BATTLE_ENEMY_CONTROLLER
// FUNCTION: Initializes enemy battle state.
//           Stores enemy Beast lists, temporary turn-processing queues,
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
//_ct_beasts = irandom_range(1,3);
_ct_beasts = 3;

_list_beasts = ds_list_create();
_list_beasts_alive = ds_list_create();
_list_beasts_graveyard = ds_list_create();

//-------------------//
//ENEMY LEVEL SCALING//
//-------------------//
_val_enemy_level_min = 3;
_val_enemy_level_max = 5;

//-------------//
//TURN QUEUES//
//-------------//
_list_casting_beasts = undefined;
_list_casting_minions = undefined;
_list_statuses = undefined;

_list_turn_start_items = undefined;
_list_turn_end_items = undefined;

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

_state_enemy = ENUM_ENEMY_STATE.INIT_BEASTS;

//-------------------//
//GET ENCOUNTER STATE//
//-------------------//
var _ct_encounter_pool = 0;
var _flag_forced_enemy = false;

if (
	variable_global_exists("arr_last_enemy_pool") &&
	is_array(global.arr_last_enemy_pool)
){
	_ct_encounter_pool = array_length(global.arr_last_enemy_pool);
}

if (
	variable_global_exists("stct_forced_enemy_unit") &&
	is_struct(global.stct_forced_enemy_unit)
){
	_flag_forced_enemy = true;
}

//----------------//
//DEBUG INITIALIZE//
//----------------//
scr_debug_log(
	"BATTLE",
	"ENEMY",
	self,
	"ENEMY BATTLE CONTROLLER INITIALIZED | TEAM SIZE: " + string(_ct_beasts) +
	" | LEVEL RANGE: " + string(_val_enemy_level_min) +
	"-" + string(_val_enemy_level_max) +
	" | ENCOUNTER POOL: " + string(_ct_encounter_pool) +
	" | FORCED SLOT 0: " + (_flag_forced_enemy ? "YES" : "NO"),
	"INIT",
	"OBJ_BATTLE_ENEMY_CONTROLLER:CREATE"
);

#endregion

#region METHODS

//—------------------------------------------------------------------------------//
// hscr_battle_enemy_get_random_living
// FUNCTION: Returns a random living Beast from the supplied list.
//           Optionally excludes one Beast from selection.
//—------------------------------------------------------------------------------//
hscr_battle_enemy_get_random_living = function(_list_targets,_ref_exclude=undefined){

	//----------------//
	//VALIDATE LIST//
	//----------------//
	if (!ds_exists(_list_targets,ds_type_list)){
		return undefined;
	}

	//----------------//
	//BUILD TARGETS//
	//----------------//
	var _arr_targets = [];

	for (var _it_target = 0; _it_target < ds_list_size(_list_targets); _it_target++){

		var _ref_target = ds_list_find_value(_list_targets,_it_target);

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

		array_push(_arr_targets,_ref_target);
	}

	//----------------//
	//NO VALID TARGET//
	//----------------//
	if (array_length(_arr_targets) <= 0){
		return undefined;
	}

	//-------------------//
	//GET RANDOM TARGET//
	//-------------------//
	return _arr_targets[irandom(array_length(_arr_targets) - 1)];
};

//—------------------------------------------------------------------------------//
// hscr_battle_enemy_get_hostile_target
// FUNCTION: Selects a hostile Card's primary target.
//
//           Priority:
//           1. Taunt, regardless of range or Blind.
//           2. Blind restrictions when no Taunt exists.
//           3. Normal Card range.
//
//           AoE secondary targets are handled by the Card script.
//           Global and Teamwide effects are not redirected by Taunt.
//—------------------------------------------------------------------------------//
hscr_battle_enemy_get_hostile_target = function(_ref_caster,_stct_card){

	//-----------------//
	//VALIDATE CASTER//
	//-----------------//
	if (!instance_exists(_ref_caster)){
		return undefined;
	}

	//---------------//
	//VALIDATE CARD//
	//---------------//
	if (!is_struct(_stct_card)){
		return undefined;
	}

	//----------------//
	//GET PLAYER TEAM//
	//----------------//
	if (!instance_exists(obj_battle_player_controller)){
		return undefined;
	}

	var _list_targets = obj_battle_player_controller._list_beasts_alive;

	if (!ds_exists(_list_targets,ds_type_list)){
		return undefined;
	}

	if (ds_list_size(_list_targets) <= 0){
		return undefined;
	}

	var _str_range = _stct_card._str_card_range;

	//===============//
	//GLOBAL TARGET//
	//===============//
	if (_str_range == "GLOBAL"){
		return "GLOBAL";
	}

	//=============//
	//SELF TARGET//
	//=============//
	if (_str_range == "SELF"){
		return _ref_caster;
	}

	//=======================//
	//CHECK HOSTILE TARGETING//
	//=======================//
	var _flag_hostile_target = scr_battle_is_hostile_card_target(_stct_card);

	if (_flag_hostile_target){

		//================//
		//TAUNT OVERRIDE//
		//================//
		var _ref_taunt_target = scr_status_get_taunt_target(_list_targets);

		if (
			instance_exists(_ref_taunt_target) &&
			_ref_taunt_target._str_list == "ALIVE" &&
			_ref_taunt_target._val_cur_hp > 0
		){
			return _ref_taunt_target;
		}

		//================//
		//BLIND OVERRIDE//
		//================//
		var _str_blind_mode = scr_cc_get_blind_attack_target_mode(
			_ref_caster,
			_stct_card
		);

		//-------------//
		//BLIND BLOCK//
		//-------------//
		if (_str_blind_mode == "BLOCK"){
			return undefined;
		}

		//-------------//
		//BLIND FRONT//
		//-------------//
		if (_str_blind_mode == "FRONT"){

			for (var _it_front = 0;_it_front < ds_list_size(_list_targets);_it_front++){

				var _ref_front = ds_list_find_value(_list_targets,_it_front);

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

	//================//
	//SELECT BY RANGE//
	//================//
	switch(_str_range){

		//=======//
		//MELEE//
		//=======//
		case "MELEE":

			for (var _it_front = 0;_it_front < ds_list_size(_list_targets);_it_front++){

				var _ref_front = ds_list_find_value(_list_targets,_it_front);

				if (
					instance_exists(_ref_front) &&
					_ref_front._str_list == "ALIVE" &&
					_ref_front._val_cur_hp > 0
				){
					return _ref_front;
				}
			}

		break;

		//========//
		//RANGED//
		//========//
		case "RANGED":
		case "ENEMY":

			return hscr_battle_enemy_get_random_living(_list_targets);

		break;

		//===========//
		//BACK/FLANK//
		//===========//
		case "BACK":
		case "FLANK":

			for (var _it_back = ds_list_size(_list_targets) - 1;_it_back >= 0;_it_back--){

				var _ref_back = ds_list_find_value(_list_targets,_it_back);

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
// FUNCTION: Selects a friendly target for Defense, Utility, Minion, and Buff
//           effects. Normally targets the caster 80% of the time and another
//           random living ally 20% of the time.
//           Defense may prioritize the front ally on the 20% ally roll.
//—------------------------------------------------------------------------------//
hscr_battle_enemy_get_friendly_target = function(_ref_caster,_stct_card,_flag_prefer_front=false){

	//-----------------//
	//VALIDATE CASTER//
	//-----------------//
	if (!instance_exists(_ref_caster)){
		return undefined;
	}

	//---------------//
	//VALIDATE CARD//
	//---------------//
	if (!is_struct(_stct_card)){
		return undefined;
	}

	if (!ds_exists(_list_beasts_alive,ds_type_list)){
		return undefined;
	}

	var _str_range = _stct_card._str_card_range;

	//---------------//
	//GLOBAL TARGET//
	//---------------//
	if (_str_range == "GLOBAL"){
		return "GLOBAL";
	}

	//-------------//
	//SELF TARGET//
	//-------------//
	if (_str_range == "SELF"){
		return _ref_caster;
	}

	//------------------//
	//ALLY-ONLY TARGET//
	//------------------//
	if (_str_range == "TEAM"){
		return hscr_battle_enemy_get_random_living(_list_beasts_alive,_ref_caster);
	}

	//================//
	//80% SELF TARGET//
	//================//
	if (random(1) >= 0.20){
		return _ref_caster;
	}

	//=======================//
	//20% OTHER ALLY TARGET//
	//=======================//

	//--------------------//
	//PREFER FRONT ALLY//
	//--------------------//
	if (_flag_prefer_front){

		for (var _it_front = 0; _it_front < ds_list_size(_list_beasts_alive); _it_front++){

			var _ref_front = ds_list_find_value(_list_beasts_alive,_it_front);

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

	//------------------//
	//GET RANDOM ALLY//
	//------------------//
	var _ref_ally = hscr_battle_enemy_get_random_living(
		_list_beasts_alive,
		_ref_caster
	);

	if (instance_exists(_ref_ally)){
		return _ref_ally;
	}

	//----------------//
	//FALLBACK SELF//
	//----------------//
	return _ref_caster;
};


//—------------------------------------------------------------------------------//
// hscr_battle_enemy_get_heal_target
// FUNCTION: Returns the living allied Beast with the lowest current HP.
//           Self-only healing Cards always target their caster.
//—------------------------------------------------------------------------------//
hscr_battle_enemy_get_heal_target = function(_ref_caster,_stct_card){

	//-----------------//
	//VALIDATE CASTER//
	//-----------------//
	if (!instance_exists(_ref_caster)){
		return undefined;
	}

	//---------------//
	//VALIDATE CARD//
	//---------------//
	if (!is_struct(_stct_card)){
		return undefined;
	}

	if (!ds_exists(_list_beasts_alive,ds_type_list)){
		return undefined;
	}

	var _str_range = _stct_card._str_card_range;

	//---------------//
	//GLOBAL TARGET//
	//---------------//
	if (_str_range == "GLOBAL"){
		return "GLOBAL";
	}

	//-------------//
	//SELF TARGET//
	//-------------//
	if (_str_range == "SELF"){
		return _ref_caster;
	}

	//------------------//
	//FIND LOWEST HP//
	//------------------//
	var _ref_lowest_hp = undefined;

	for (var _it_ally = 0; _it_ally < ds_list_size(_list_beasts_alive); _it_ally++){

		var _ref_ally = ds_list_find_value(_list_beasts_alive,_it_ally);

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
			_ref_ally._val_cur_hp < _ref_lowest_hp._val_cur_hp
		){
			_ref_lowest_hp = _ref_ally;
		}
	}

	return _ref_lowest_hp;
};

#endregion