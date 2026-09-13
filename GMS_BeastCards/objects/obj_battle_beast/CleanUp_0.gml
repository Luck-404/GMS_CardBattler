//===============================================================================//
//
// CLEANUP: OBJ_BATTLE_BEAST
// FUNCTION: Destroys attached battle instances and releases Beast-owned lists.
//           Cleans Minions, Statuses, Traps, and the Beast Card deck.
//
//===============================================================================//

#region MINIONS

//----------------//
//DESTROY MINIONS//
//----------------//
if (ds_exists(_list_minions,ds_type_list)){

	for (var _it_minion = ds_list_size(_list_minions) - 1; _it_minion >= 0; _it_minion--){

		var _ref_minion = ds_list_find_value(_list_minions,_it_minion);

		if (instance_exists(_ref_minion)){
			instance_destroy(_ref_minion);
		}
	}

	ds_list_destroy(_list_minions);
}

#endregion

#region STATUSES

//------------------//
//DESTROY STATUSES//
//------------------//
if (ds_exists(_list_statuses,ds_type_list)){

	for (var _it_status = ds_list_size(_list_statuses) - 1; _it_status >= 0; _it_status--){

		var _ref_status = ds_list_find_value(_list_statuses,_it_status);

		if (instance_exists(_ref_status)){
			instance_destroy(_ref_status);
		}
	}

	ds_list_destroy(_list_statuses);
}

#endregion

#region TRAPS

//---------------//
//DESTROY TRAPS//
//---------------//
if (ds_exists(_list_traps,ds_type_list)){

	for (var _it_trap = ds_list_size(_list_traps) - 1; _it_trap >= 0; _it_trap--){

		var _ref_trap = ds_list_find_value(_list_traps,_it_trap);

		if (instance_exists(_ref_trap)){
			instance_destroy(_ref_trap);
		}
	}

	ds_list_destroy(_list_traps);
}

#endregion

#region CARDS

//-------------//
//DESTROY DECK//
//-------------//
if (ds_exists(_list_deck,ds_type_list)){
	ds_list_destroy(_list_deck);
}

#endregion