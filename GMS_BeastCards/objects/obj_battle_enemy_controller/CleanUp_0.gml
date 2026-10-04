//===============================================================================//
//
// CLEANUP: OBJ_BATTLE_ENEMY_CONTROLLER
// FUNCTION: Cleans up enemy battle-owned data structures.
//           Releases persistent Beast-tracking DS lists and temporary
//           turn-processing arrays when the battle ends.
//
//===============================================================================//

#region BEAST LISTS

//--------------------//
//DESTROY BEAST LISTS//
//--------------------//
if (
	ds_exists(
		_list_beasts,
		ds_type_list
	)
){

	ds_list_destroy(
		_list_beasts
	);

	_list_beasts =
		undefined;
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

#region TEMPORARY ARRAYS

//------------------------//
//RELEASE TEMPORARY ARRAYS//
//------------------------//
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

#endregion