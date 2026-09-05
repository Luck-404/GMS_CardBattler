//===============================================================================//
//
// CLEANUP: OBJ_BATTLE_PLAYER_CONTROLLER
// FUNCTION: Cleans up battle-owned global status data.
//           Destroys remaining global status instances.
//           Destroys the global battle-status list before leaving battle.
//
//===============================================================================//

//-----------------------//
//CLEAN UP GLOBAL STATUSES//
//-----------------------//
if (
	variable_global_exists("list_statuses") &&
	ds_exists(global.list_statuses,ds_type_list)
){

	//------------------------//
	//DESTROY STATUS INSTANCES//
	//------------------------//
	for (
		var _it_status =
			ds_list_size(global.list_statuses) - 1;
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
		-1;
}