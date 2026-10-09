//===============================================================================//
//
// SCRIPT: SCR_STATUS_TRIGGER_DAMAGE_AURAS
// FUNCTION: Triggers opposing Team Auras when a Beast takes qualifying damage.
//		   Reads the opposing Team Status registry directly.
//
// ARGUMENTS: _ref_damaged_beast - Beast that received damage.
//			_val_damage - qualifying Beast damage amount.
// RETURNS: True when at least one Aura successfully triggers.
//
//===============================================================================//

function scr_status_trigger_damage_auras(_ref_damaged_beast,_val_damage){

	if (!instance_exists(_ref_damaged_beast)){
		return false;
	}

	if (_val_damage <= 0){
		return false;
	}

	if (_ref_damaged_beast._val_cur_hp <= 0){
		return false;
	}

	var _str_aura_team =
		(_ref_damaged_beast._str_team == "PLAYER")
		? "ENEMY"
		: "PLAYER";

	scr_status_prune_team_status_sources(
		_str_aura_team
	);

	var _list_statuses =
		scr_status_get_team_status_list(
			_str_aura_team
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

		if (_ref_status._str_aura_trigger != "ENEMY_DAMAGED"){
			continue;
		}

		if (_ref_status._str_team != _str_aura_team){
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
				_ref_damaged_beast
			);

		if (_flag_aura_triggered){

			_flag_triggered = true;

			scr_debug_log_battle_trigger(
				_str_status_name,
				_ref_status_source,
				_ref_damaged_beast,
				"DAMAGE EVENT: " + string(_val_damage),
				"SCR_STATUS_TRIGGER_DAMAGE_AURAS"
			);
		}
	}

	return _flag_triggered;
}
