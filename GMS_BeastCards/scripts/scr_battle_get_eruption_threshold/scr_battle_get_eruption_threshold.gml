//===============================================================================//
//
// SCRIPT: SCR_BATTLE_GET_ERUPTION_THRESHOLD
// FUNCTION: Returns the effective ERUPTION threshold for the resolving team.
//           Inferno Eternal reduces only its owning team's thresholds.
//           Thresholds cannot fall below 1.
//
// ARGUMENTS: _ct_threshold is the base ERUPTION threshold.
//            _ref_source may be a Beast or PLAYER/ENEMY Team string. When omitted,
//            GLOBAL.REF_CASTER_BEAST supplies the active cast Team.
// RETURNS: Effective threshold, minimum 1.
//
//===============================================================================//

function scr_battle_get_eruption_threshold(_ct_threshold,_ref_source=undefined){

	_ct_threshold = max(
		1,
		floor(_ct_threshold)
	);

	var _str_team = "";

	if (instance_exists(_ref_source)){
		_str_team = _ref_source._str_team;
	}
	else if (is_string(_ref_source)){
		var _str_source_team = string_upper(string(_ref_source));

		if (_str_source_team == "PLAYER" || _str_source_team == "ENEMY"){
			_str_team = _str_source_team;
		}
	}

	if (_str_team == "" && instance_exists(global.ref_caster_beast)){
		_str_team = global.ref_caster_beast._str_team;
	}

	if (_str_team != "PLAYER" && _str_team != "ENEMY"){
		return _ct_threshold;
	}

	var _ref_inferno = scr_status_check(
		"INFERNO_ETERNAL",
		_str_team
	);

	if (
		_ref_inferno == -1 ||
		!instance_exists(_ref_inferno)
	){
		return _ct_threshold;
	}

	return max(
		1,
		_ct_threshold - _ref_inferno._val_status_magnitude
	);
}
