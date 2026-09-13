//===============================================================================//
//
// SCRIPT: SCR_DEBUG_LOG_CLEANSE_RESULT
// FUNCTION: Logs a completed Status cleanse.
//           Reports the affected Beast, Status type, stacks removed,
//           remaining stacks, and current Card source when available.
//
// ARGUMENTS: _ref_target is the cleansed Beast.
//            _str_status_name and _str_status_type identify the Status.
//            _ct_stacks_removed is the number of stacks removed.
//            _ct_stacks_remaining is the number remaining after cleansing.
//            _str_origin identifies the cleanse helper that resolved it.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_debug_log_cleanse_result(_ref_target,_str_status_name,_str_status_type,_ct_stacks_removed,_ct_stacks_remaining,_str_origin){

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
		_str_source = string_upper(global.ref_cast_card._ref_card._str_card_name);
	}

	//================//
	//BUILD MESSAGE//
	//================//
	var _str_message =
		string_upper(_ref_target._str_team) + " " +
		string_upper(_ref_target._ref_unit._str_beast_name) +
		" (LVL " + string(_ref_target._ref_unit._val_beast_level) + ")" +
		" CLEANSED ";

	if (_ct_stacks_remaining <= 0){

		_str_message +=
			string_upper(_str_status_name) +
			" | TYPE: " + string_upper(_str_status_type) +
			" | STACKS REMOVED: " + string(_ct_stacks_removed);
	}
	else{

		_str_message +=
			string(_ct_stacks_removed) +
			(_ct_stacks_removed == 1 ? " STACK" : " STACKS") +
			" OF " + string_upper(_str_status_name) +
			" | TYPE: " + string_upper(_str_status_type) +
			" | REMAINING: " + string(_ct_stacks_remaining);
	}

	_str_message += " | SOURCE: " + _str_source;

	//================//
	//WRITE CLEANSE LOG//
	//================//
	scr_debug_log(
		"BATTLE",
		"CLEANSE",
		_ref_target,
		_str_message,
		"BATTLE",
		_str_origin
	);
}