//===============================================================================//
//
// SCRIPT: SCR_STATUS_PRUNE_TEAM_STATUS_SOURCES
// FUNCTION: Removes source-bound Team Statuses whose owning source Beast is no
//		   longer a living member of that Status's team.
//
//		   Team Statuses that are not source-bound are preserved.
//		   Source-bound Statuses resolve their normal DEATH callback so owned
//		   stat modifiers, persistent VFX, and other cleanup remain balanced.
//
// ARGUMENTS: _str_team - PLAYER or ENEMY.
// RETURNS: Number of Team Statuses removed.
//
//===============================================================================//

function scr_status_prune_team_status_sources(_str_team){

	var _str_team_upper =
		string_upper(
			string(_str_team)
		);

	if (
		_str_team_upper != "PLAYER" &&
		_str_team_upper != "ENEMY"
	){
		return 0;
	}

	var _list_statuses =
		scr_status_get_team_status_list(
			_str_team_upper
		);

	if (
		_list_statuses == undefined ||
		!ds_exists(_list_statuses,ds_type_list)
	){
		return 0;
	}

	var _ct_removed = 0;

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

		if (!instance_exists(_ref_status)){
			continue;
		}

		if (
			!variable_instance_exists(
				_ref_status,
				"_str_status_scope"
			) ||
			_ref_status._str_status_scope != "TEAM"
		){
			continue;
		}

		if (
			!variable_instance_exists(
				_ref_status,
				"_flag_status_source_bound"
			) ||
			!_ref_status._flag_status_source_bound
		){
			continue;
		}

		var _ref_source = undefined;

		if (
			variable_instance_exists(
				_ref_status,
				"_ref_status_source"
			)
		){
			_ref_source =
				_ref_status._ref_status_source;
		}

		if (
			!instance_exists(_ref_source) &&
			instance_exists(_ref_status._ref_host)
		){
			_ref_source =
				_ref_status._ref_host;
		}

		var _flag_source_alive =
			instance_exists(_ref_source) &&
			_ref_source._str_team == _str_team_upper &&
			_ref_source._str_list == "ALIVE" &&
			_ref_source._val_cur_hp > 0;

		if (_flag_source_alive){
			continue;
		}

		if (_ref_status._scr_status != undefined){
			_ref_status._scr_status(
				"DEATH",
				_ref_status
			);
		}
		else{
			scr_status_destroy(
				_ref_status
			);
		}

		_ct_removed++;
	}

	scr_status_prune_list(
		_list_statuses
	);

	return _ct_removed;
}
