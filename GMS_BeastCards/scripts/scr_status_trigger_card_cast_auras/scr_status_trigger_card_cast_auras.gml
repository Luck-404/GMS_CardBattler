//===============================================================================//
//
// SCRIPT: SCR_STATUS_TRIGGER_CARD_CAST_AURAS
// FUNCTION: Triggers Team Auras responding to an allied qualifying Card cast.
//		   Reads the caster's Team Status registry directly.
//
// ARGUMENTS: _ref_caster - Beast that cast the qualifying Card.
//			_stct_card - Card struct that was cast.
// RETURNS: True when at least one Aura successfully triggers.
//
//===============================================================================//

function scr_status_trigger_card_cast_auras(_ref_caster,_stct_card){

	if (!instance_exists(_ref_caster)){
		return false;
	}

	if (!is_struct(_stct_card)){
		return false;
	}

	if (_stct_card._str_card_type != "ATTACK"){
		return false;
	}

	var _str_team = _ref_caster._str_team;

	scr_status_prune_team_status_sources(
		_str_team
	);

	var _list_statuses =
		scr_status_get_team_status_list(
			_str_team
		);

	if (
		_list_statuses == undefined ||
		!ds_exists(_list_statuses,ds_type_list)
	){
		return false;
	}

	var _flag_triggered = false;

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

		if (_ref_status._str_status_type != "AURA"){
			continue;
		}

		if (_ref_status._str_aura_scope != "TEAM"){
			continue;
		}

		if (_ref_status._str_aura_trigger != "ATTACK_CAST"){
			continue;
		}

		if (_ref_status._str_team != _str_team){
			continue;
		}

		if (_ref_status._scr_status == undefined){
			continue;
		}

		var _str_status_name =
			_ref_status._str_status_name;

		var _ref_status_source =
			_ref_status._ref_status_source;

		if (!instance_exists(_ref_status_source)){
			_ref_status_source =
				_ref_status._ref_host;
		}

		var _flag_aura_triggered =
			_ref_status._scr_status(
				"TRIGGER",
				_ref_status,
				undefined,
				_ref_caster
			);

		if (_flag_aura_triggered){

			_flag_triggered = true;

			scr_debug_log_battle_trigger(
				_str_status_name,
				_ref_status_source,
				_ref_caster,
				"",
				"SCR_STATUS_TRIGGER_CARD_CAST_AURAS"
			);
		}
	}

	return _flag_triggered;
}
