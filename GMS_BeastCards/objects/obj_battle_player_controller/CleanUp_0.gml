//===============================================================================//
//
// CLEANUP: OBJ_BATTLE_PLAYER_CONTROLLER
// FUNCTION: Cleans up player battle-owned data structures.
//           Destroys Team Status registries and Weather/Event references, then releases
//           Beast-tracking and Card-pile lists and temporary processing arrays.
//
//===============================================================================//

#region SHARED STATUS REGISTRIES

//========================//
//DESTROY STATUS INSTANCES//
//========================//
var _arr_shared_status_lists = [];

if (
	variable_global_exists("list_statuses_player") &&
	ds_exists(global.list_statuses_player,ds_type_list)
){
	array_push(
		_arr_shared_status_lists,
		global.list_statuses_player
	);
}

if (
	variable_global_exists("list_statuses_enemy") &&
	ds_exists(global.list_statuses_enemy,ds_type_list)
){
	array_push(
		_arr_shared_status_lists,
		global.list_statuses_enemy
	);
}

for (
	var _it_list = 0;
	_it_list < array_length(_arr_shared_status_lists);
	_it_list++
){

	var _list_statuses =
		_arr_shared_status_lists[_it_list];

	for (
		var _it_status = ds_list_size(_list_statuses) - 1;
		_it_status >= 0;
		_it_status--
	){

		var _ref_status =
			ds_list_find_value(
				_list_statuses,
				_it_status
			);

		if (instance_exists(_ref_status)){
			instance_destroy(_ref_status);
		}
	}
}

//==========================//
//DESTROY WEATHER / EVENT//
//==========================//
if (
	variable_global_exists("ref_status_weather") &&
	instance_exists(global.ref_status_weather)
){
	instance_destroy(global.ref_status_weather);
}

if (
	variable_global_exists("ref_status_event") &&
	instance_exists(global.ref_status_event)
){
	instance_destroy(global.ref_status_event);
}

global.ref_status_weather = undefined;
global.ref_status_event = undefined;

//======================//
//DESTROY STATUS LISTS//
//======================//
if (
	variable_global_exists("list_statuses_player") &&
	ds_exists(global.list_statuses_player,ds_type_list)
){
	ds_list_destroy(global.list_statuses_player);
}

global.list_statuses_player = undefined;

if (
	variable_global_exists("list_statuses_enemy") &&
	ds_exists(global.list_statuses_enemy,ds_type_list)
){
	ds_list_destroy(global.list_statuses_enemy);
}

global.list_statuses_enemy = undefined;

_arr_shared_status_lists = [];

#endregion

#region BEAST LISTS

//--------------------//
//DESTROY BEAST LISTS//
//--------------------//
if (ds_exists(_list_beasts,ds_type_list)){

	ds_list_destroy(_list_beasts);
	_list_beasts = undefined;
}

if (
	ds_exists(
		_list_beasts_alive,
		ds_type_list
	)
){

	ds_list_destroy(
		_list_beasts_alive
	);

	_list_beasts_alive =
		undefined;
}

if (
	ds_exists(
		_list_beasts_graveyard,
		ds_type_list
	)
){

	ds_list_destroy(
		_list_beasts_graveyard
	);

	_list_beasts_graveyard =
		undefined;
}

#endregion

#region CARD LISTS

//-------------------//
//DESTROY CARD LISTS//
//-------------------//
if (
	ds_exists(
		_list_battle_deck,
		ds_type_list
	)
){

	ds_list_destroy(
		_list_battle_deck
	);

	_list_battle_deck =
		undefined;
}

if (
	ds_exists(
		_list_battle_hand,
		ds_type_list
	)
){

	ds_list_destroy(
		_list_battle_hand
	);

	_list_battle_hand =
		undefined;
}

if (
	ds_exists(
		_list_battle_discard,
		ds_type_list
	)
){

	ds_list_destroy(
		_list_battle_discard
	);

	_list_battle_discard =
		undefined;
}

if (
	ds_exists(
		_list_battle_exhaust,
		ds_type_list
	)
){

	ds_list_destroy(
		_list_battle_exhaust
	);

	_list_battle_exhaust =
		undefined;
}

#endregion

#region TEMPORARY ARRAYS

//------------------------//
//RELEASE TEMPORARY ARRAYS//
//------------------------//
_arr_casting_minions = [];
_it_casting_minion = 0;

_arr_statuses = [];
_it_status_queue = 0;

_arr_turn_start_items = [];
_it_turn_start_item = 0;

_arr_turn_end_items = [];
_it_turn_end_item = 0;

#endregion