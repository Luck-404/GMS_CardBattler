//===============================================================================//
//
// CLEANUP: OBJ_BATTLE_PLAYER_CONTROLLER
// FUNCTION: Cleans up player battle-owned data structures.
//           Destroys remaining global Status instances and releases global,
//           Beast-tracking, Card-pile, and temporary processing lists.
//
//===============================================================================//

#region GLOBAL STATUSES

//-------------------------//
//CLEAN UP GLOBAL STATUSES//
//-------------------------//
if (
	variable_global_exists("list_statuses") &&
	ds_exists(global.list_statuses,ds_type_list)
){

	//------------------------//
	//DESTROY STATUS INSTANCES//
	//------------------------//
	for (var _it_status = ds_list_size(global.list_statuses) - 1; _it_status >= 0; _it_status--){

		var _ref_status = ds_list_find_value(global.list_statuses,_it_status);

		if (instance_exists(_ref_status)){
			instance_destroy(_ref_status);
		}
	}

	//-------------------//
	//DESTROY STATUS LIST//
	//-------------------//
	ds_list_destroy(global.list_statuses);

	global.list_statuses = -1;
}

#endregion

#region BEAST LISTS

//--------------------//
//DESTROY BEAST LISTS//
//--------------------//
if (ds_exists(_list_beasts,ds_type_list)){
	ds_list_destroy(_list_beasts);
}

if (ds_exists(_list_beasts_alive,ds_type_list)){
	ds_list_destroy(_list_beasts_alive);
}

if (ds_exists(_list_beasts_graveyard,ds_type_list)){
	ds_list_destroy(_list_beasts_graveyard);
}

#endregion

#region CARD LISTS

//-------------------//
//DESTROY CARD LISTS//
//-------------------//
if (ds_exists(_list_battle_deck,ds_type_list)){
	ds_list_destroy(_list_battle_deck);
}

if (ds_exists(_list_battle_hand,ds_type_list)){
	ds_list_destroy(_list_battle_hand);
}

if (ds_exists(_list_battle_discard,ds_type_list)){
	ds_list_destroy(_list_battle_discard);
}

if (ds_exists(_list_battle_exhaust,ds_type_list)){
	ds_list_destroy(_list_battle_exhaust);
}

#endregion

#region TEMPORARY LISTS

//-----------------------//
//DESTROY TEMPORARY LISTS//
//-----------------------//
if (_list_casting_minions != undefined && ds_exists(_list_casting_minions,ds_type_list)){
	ds_list_destroy(_list_casting_minions);
}

if (_list_statuses != undefined && ds_exists(_list_statuses,ds_type_list)){
	ds_list_destroy(_list_statuses);
}

if (_list_turn_start_items != undefined && ds_exists(_list_turn_start_items,ds_type_list)){
	ds_list_destroy(_list_turn_start_items);
}

if (_list_turn_end_items != undefined && ds_exists(_list_turn_end_items,ds_type_list)){
	ds_list_destroy(_list_turn_end_items);
}

#endregion