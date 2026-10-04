//===============================================================================//
//
// CLEANUP: OBJ_BATTLE_PLAYER_CONTROLLER
// FUNCTION: Cleans up player battle-owned data structures.
//           Destroys remaining global Status instances and releases global,
//           Beast-tracking and Card-pile lists.
//           Releases temporary processing arrays.
//
//===============================================================================//

#region GLOBAL STATUSES

//-------------------------//
//CLEAN UP GLOBAL STATUSES//
//-------------------------//
if (
	variable_global_exists("list_statuses") &&
	global.list_statuses != undefined &&
	ds_exists(
		global.list_statuses,
		ds_type_list
	)
){

	//------------------------//
	//DESTROY STATUS INSTANCES//
	//------------------------//
	for (
		var _it_status =
			ds_list_size(
				global.list_statuses
			) - 1;
		_it_status >= 0;
		_it_status--
	){

		var _ref_status =
			ds_list_find_value(
				global.list_statuses,
				_it_status
			);

		if (instance_exists(_ref_status)){
			instance_destroy(_ref_status);
		}
	}

	//-------------------//
	//DESTROY STATUS LIST//
	//-------------------//
	ds_list_destroy(
		global.list_statuses
	);

	global.list_statuses =
		undefined;
}

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