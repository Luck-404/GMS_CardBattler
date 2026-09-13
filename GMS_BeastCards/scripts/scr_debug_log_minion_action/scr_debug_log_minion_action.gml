//===============================================================================//
//
// SCRIPT: SCR_DEBUG_LOG_MINION_ACTION
// FUNCTION: Logs a successfully initiated Minion action.
//           Identifies the Minion, host, target, and action-specific details.
//
// ARGUMENTS: _ref_minion is the acting Minion.
//            _str_action identifies the Minion action.
//            _ref_target is the affected Beast when applicable.
//            _str_details contains optional action-specific data.
//            _str_origin identifies the resolving Minion helper.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_debug_log_minion_action(_ref_minion,_str_action,_ref_target=undefined,_str_details="",_str_origin=""){

	//================//
	//VALIDATE MINION//
	//================//
	if (!instance_exists(_ref_minion)){
		return;
	}

	//================//
	//GET MINION DATA//
	//================//
	var _str_team = string_upper(_ref_minion._str_team);
	var _str_minion_name = string_upper(_ref_minion._str_name);

	var _str_host = "UNKNOWN";

	if (
		instance_exists(_ref_minion._ref_host) &&
		is_struct(_ref_minion._ref_host._ref_unit)
	){
		_str_host = string_upper(
			_ref_minion._ref_host._ref_unit._str_beast_name
		);
	}

	//================//
	//GET TARGET DATA//
	//================//
	var _str_target = "";

	if (
		instance_exists(_ref_target) &&
		is_struct(_ref_target._ref_unit)
	){

		_str_target =
			" | TARGET: " +
			string_upper(_ref_target._str_team) + " " +
			string_upper(_ref_target._ref_unit._str_beast_name);
	}

	//================//
	//BUILD DETAILS//
	//================//
	var _str_detail_text = "";

	if (_str_details != ""){
		_str_detail_text = " | " + _str_details;
	}

	//================//
	//WRITE ACTION LOG//
	//================//
	scr_debug_log(
		"MINIONS",
		"ACTION",
		_ref_minion,
		_str_team + " " +
		_str_minion_name +
		" " +
		string_upper(_str_action) +
		" | HOST: " + _str_host +
		_str_target +
		_str_detail_text,
		"BATTLE",
		_str_origin
	);
}