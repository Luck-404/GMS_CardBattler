//===============================================================================//
//
// SCRIPT: SCR_DEBUG_LOG_TRAP_TRIGGER
// FUNCTION: Logs a successfully activated battle Trap.
//           Reports Trap ownership, affected Beast, trigger rule, source Card,
//           and optional Trap-specific effect details.
//
// ARGUMENTS: _ref_trap is the Trap before it is consumed.
//            _ref_target is the Beast affected by the Trap when applicable.
//            _str_details contains optional Trap-specific result information.
//            _str_origin identifies the Trap callback that resolved it.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_debug_log_trap_trigger(_ref_trap,_ref_target=undefined,_str_details="",_str_origin=""){

	//================//
	//VALIDATE TRAP//
	//================//
	if (!instance_exists(_ref_trap)){
		return;
	}

	//================//
	//GET TRAP DATA//
	//================//
	var _str_trap_name = string_upper(_ref_trap._str_trap_name);
	var _str_owner_team = string_upper(_ref_trap._str_owner_team);

	var _str_owner_name = "UNKNOWN";

	if (
		instance_exists(_ref_trap._ref_owner) &&
		is_struct(_ref_trap._ref_owner._ref_unit)
	){
		_str_owner_name = string_upper(
			_ref_trap._ref_owner._ref_unit._str_beast_name
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
	else if (_ref_trap._str_trap_scope == "TEAM"){
		_str_target =
			" | TARGET TEAM: " +
			string_upper(_ref_trap._str_target_team);
	}

	//================//
	//GET SOURCE CARD//
	//================//
	var _str_source_card = "";

	if (
		instance_exists(_ref_trap._ref_source_card) &&
		is_struct(_ref_trap._ref_source_card._ref_card)
	){
		_str_source_card =
			" | CARD: " +
			string_upper(_ref_trap._ref_source_card._ref_card._str_card_name);
	}

	//================//
	//BUILD DETAILS//
	//================//
	var _str_detail_text = "";

	if (_str_details != ""){
		_str_detail_text = " | " + _str_details;
	}

	//================//
	//WRITE TRAP LOG//
	//================//
	scr_debug_log(
		"BATTLE",
		"TRAP",
		_ref_trap._ref_owner,
		_str_owner_team + " " +
		_str_owner_name +
		"'S " +
		_str_trap_name +
		" TRIGGERED" +
		_str_target +
		_str_source_card +
		" | TRIGGER: " +
		string_upper(_ref_trap._str_trigger_type) +
		"/" +
		string_upper(_ref_trap._str_trigger_phase) +
		_str_detail_text,
		"BATTLE",
		_str_origin
	);
}