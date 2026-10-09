//===============================================================================//
//
// SCRIPT: SCR_STATUS_DESTROY
// FUNCTION: Removes an exact Status instance from every authoritative container
//           that can own it, destroys the Status, and refreshes affected icon
//           layouts.
//
//           Supports host-bound Beast Statuses, PLAYER / ENEMY Team Statuses,
//           dedicated Weather / Event references.
//
// ARGUMENTS: _ref_status is the exact Status instance to remove and destroy.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_status_destroy(_ref_status){

	//-----------------//
	//VALIDATE STATUS//
	//-----------------//
	if (!instance_exists(_ref_status)){
		return;
	}

	var _ref_host = _ref_status._ref_host;

	var _flag_host_removed = false;
	var _flag_player_removed = false;
	var _flag_enemy_removed = false;
	var _flag_weather_removed = false;
	var _flag_event_removed = false;

	//====================//
	//HOST-BOUND REGISTRY//
	//====================//
	if (
		instance_exists(_ref_host) &&
		ds_exists(_ref_host._list_statuses,ds_type_list)
	){

		var _it_host_status =
			ds_list_find_index(
				_ref_host._list_statuses,
				_ref_status
			);

		if (_it_host_status != -1){
			ds_list_delete(
				_ref_host._list_statuses,
				_it_host_status
			);

			_flag_host_removed = true;
		}

		scr_status_prune_list(
			_ref_host._list_statuses
		);
	}

	//======================//
	//PLAYER TEAM REGISTRY//
	//======================//
	var _list_player_statuses =
		scr_status_get_team_status_list("PLAYER");

	if (
	_list_player_statuses != undefined &&
	ds_exists(_list_player_statuses,ds_type_list)
){

		var _it_player =
			ds_list_find_index(
				_list_player_statuses,
				_ref_status
			);

		if (_it_player != -1){
			ds_list_delete(
				_list_player_statuses,
				_it_player
			);

			_flag_player_removed = true;
		}

		scr_status_prune_list(
			_list_player_statuses
		);
	}

	//=====================//
	//ENEMY TEAM REGISTRY//
	//=====================//
	var _list_enemy_statuses =
		scr_status_get_team_status_list("ENEMY");

	if (
	_list_enemy_statuses != undefined &&
	ds_exists(_list_enemy_statuses,ds_type_list)
){

		var _it_enemy =
			ds_list_find_index(
				_list_enemy_statuses,
				_ref_status
			);

		if (_it_enemy != -1){
			ds_list_delete(
				_list_enemy_statuses,
				_it_enemy
			);

			_flag_enemy_removed = true;
		}

		scr_status_prune_list(
			_list_enemy_statuses
		);
	}

	//====================//
	//WEATHER / EVENT REFS//
	//====================//
	if (
		variable_global_exists("ref_status_weather") &&
		global.ref_status_weather == _ref_status
	){
		global.ref_status_weather = undefined;
		_flag_weather_removed = true;
	}

	if (
		variable_global_exists("ref_status_event") &&
		global.ref_status_event == _ref_status
	){
		global.ref_status_event = undefined;
		_flag_event_removed = true;
	}

	//================//
	//DESTROY STATUS//
	//================//
	instance_destroy(_ref_status);

	//====================//
	//REFRESH PRESENTATION//
	//====================//
	if (_flag_host_removed && instance_exists(_ref_host)){
		scr_status_reposition(_ref_host);
	}


	if (_flag_player_removed){
		scr_status_reposition("PLAYER");
	}

	if (_flag_enemy_removed){
		scr_status_reposition("ENEMY");
	}

	if (_flag_weather_removed){
		scr_status_reposition("WEATHER");
	}

	if (_flag_event_removed){
		scr_status_reposition("EVENT");
	}
}