//===============================================================================//
//
// SCRIPT: SCR_DEBUG_LOG_CLEANSE_RESULT
// FUNCTION: Logs one Status cleanse result from SCR_STATUS_CLEANSE.
//           Reports the Status type, cleanse mode, stack transition, and source.
//
// ARGUMENTS: _ref_target is the cleansed Beast.
//            _str_status_name and _str_status_type identify the Status.
//            _ct_stacks_before is the stack count before cleansing.
//            _ct_stacks_removed is the number removed.
//            _ct_stacks_remaining is the count after cleansing.
//            _str_mode identifies whole-Status or partial-stack cleansing.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_debug_log_cleanse_result(_ref_target,_str_status_name,_str_status_type,_ct_stacks_before,_ct_stacks_removed,_ct_stacks_remaining,_str_mode){

	//================//
	//VALIDATE TARGET//
	//================//
	if (!instance_exists(_ref_target)){
		return;
	}

	if (!is_struct(_ref_target._ref_unit)){
		return;
	}

	//================//
	//GET SOURCE//
	//================//
	var _str_source = "SYSTEM";

	if (
		instance_exists(global.ref_cast_card) &&
		is_struct(global.ref_cast_card._ref_card)
	){
		_str_source = string_upper(
			global.ref_cast_card._ref_card._str_card_name
		);
	}

	//================//
	//BUILD MESSAGE//
	//================//
	var _str_message =
		string_upper(_ref_target._str_team) + " " +
		string_upper(_ref_target._ref_unit._str_beast_name) +
		" (LVL " +
		string(_ref_target._ref_unit._val_beast_level) +
		") CLEANSED " +
		string_upper(_str_status_name) +
		" | TYPE: " +
		string_upper(_str_status_type) +
		" | MODE: " +
		string_upper(_str_mode) +
		" | STACKS: " +
		string(_ct_stacks_before) +
		" -> " +
		string(_ct_stacks_remaining) +
		" | REMOVED: " +
		string(_ct_stacks_removed) +
		" | SOURCE: " +
		_str_source;

	//================//
	//WRITE CLEANSE LOG//
	//================//
	scr_debug_log(
		"BATTLE",
		"CLEANSE",
		_ref_target,
		_str_message,
		"BATTLE",
		"SCR_STATUS_CLEANSE"
	);
}
