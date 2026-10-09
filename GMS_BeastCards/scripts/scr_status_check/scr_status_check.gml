//===============================================================================//
//
// SCRIPT: SCR_STATUS_CHECK
// FUNCTION: Searches for a Status by ID/name.
//           Supports host-bound Beast Statuses, supplied Status DS lists,
//           PLAYER / ENEMY Team Status registries, Weather, and Event.
//
// ARGUMENTS: _str_id is the Status ID/name to find.
//            _ref_owner may be a battle Beast, Status DS list, PLAYER, ENEMY,
//            WEATHER, or EVENT.
// RETURNS: The matching Status instance, or -1 if no valid match is found.
//
//===============================================================================//

function scr_status_check(_str_id,_ref_owner){

	var _str_status_id =
		string_upper(
			string(_str_id)
		);

	var _str_owner = "";

	if (is_string(_ref_owner)){
		_str_owner =
			string_upper(
				string(_ref_owner)
			);
	}

	//========================//
	//DIRECT SHARED REFERENCES//
	//========================//
	if (_str_owner == "WEATHER"){

		if (
			variable_global_exists("ref_status_weather") &&
			instance_exists(global.ref_status_weather) &&
			string_upper(global.ref_status_weather._str_status_name) ==
				_str_status_id
		){
			return global.ref_status_weather;
		}

		return -1;
	}

	if (_str_owner == "EVENT"){

		if (
			variable_global_exists("ref_status_event") &&
			instance_exists(global.ref_status_event) &&
			string_upper(global.ref_status_event._str_status_name) ==
				_str_status_id
		){
			return global.ref_status_event;
		}

		return -1;
	}

	//====================//
	//GET STATUS LIST//
	//====================//
	var _list_statuses = undefined;

	if (_str_owner == "PLAYER" || _str_owner == "ENEMY"){
		_list_statuses =
			scr_status_get_team_status_list(
				_str_owner
			);
	}
	else if (
		is_real(_ref_owner) &&
		ds_exists(_ref_owner,ds_type_list)
	){
		_list_statuses = _ref_owner;
	}
	else if (instance_exists(_ref_owner)){

		if (
			variable_instance_exists(_ref_owner,"_list_statuses") &&
			ds_exists(_ref_owner._list_statuses,ds_type_list)
		){
			_list_statuses = _ref_owner._list_statuses;
		}
	}

	if (
		_list_statuses == undefined ||
		!ds_exists(_list_statuses,ds_type_list)
	){
		return -1;
	}

	//================//
	//SEARCH STATUS//
	//================//
	for (
		var _it_status = 0;
		_it_status < ds_list_size(_list_statuses);
		_it_status++
	){

		var _ref_status =
			ds_list_find_value(
				_list_statuses,
				_it_status
			);

		if (!instance_exists(_ref_status)){
			continue;
		}

		if (
			string_upper(_ref_status._str_status_name) ==
			_str_status_id
		){
			return _ref_status;
		}
	}

	return -1;
}
