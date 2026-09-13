//===============================================================================//
//
// SCRIPT: SCR_DEBUG_LOG_BATTLE_TRIGGER
// FUNCTION: Logs a successfully resolved battle trigger.
//           Identifies the triggering Beast, optional affected Beast,
//           current Card source when available, and trigger-specific details.
//
// ARGUMENTS: _str_trigger_name is the triggered mechanic.
//            _ref_source is the Beast responsible for the trigger.
//            _ref_target is the affected Beast when applicable.
//            _str_details contains optional trigger-specific result data.
//            _str_origin identifies the helper that resolved the trigger.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_debug_log_battle_trigger(_str_trigger_name,_ref_source,_ref_target=undefined,_str_details="",_str_origin=""){

	//================//
	//BUILD SOURCE//
	//================//
	var _str_source = "SYSTEM";

	if (
		instance_exists(_ref_source) &&
		variable_instance_exists(_ref_source,"_ref_unit") &&
		is_struct(_ref_source._ref_unit)
	){
		_str_source =
			string_upper(_ref_source._str_team) + " " +
			string_upper(_ref_source._ref_unit._str_beast_name);
	}

	//================//
	//BUILD TARGET//
	//================//
	var _str_target = "";

	if (
		instance_exists(_ref_target) &&
		variable_instance_exists(_ref_target,"_ref_unit") &&
		is_struct(_ref_target._ref_unit)
	){
		_str_target =
			" | TARGET: " +
			string_upper(_ref_target._str_team) + " " +
			string_upper(_ref_target._ref_unit._str_beast_name);
	}

	//================//
	//BUILD CARD//
	//================//
	var _str_card = "";

	if (
		instance_exists(global.ref_cast_card) &&
		is_struct(global.ref_cast_card._ref_card)
	){
		_str_card =
			" | CARD: " +
			string_upper(global.ref_cast_card._ref_card._str_card_name);
	}

	//================//
	//BUILD DETAILS//
	//================//
	var _str_detail_text = "";

	if (_str_details != ""){
		_str_detail_text = " | " + _str_details;
	}

	//================//
	//WRITE TRIGGER LOG//
	//================//
	scr_debug_log(
		"BATTLE",
		"TRIGGER",
		_ref_source,
		_str_source +
		" TRIGGERED " +
		string_upper(_str_trigger_name) +
		_str_target +
		_str_card +
		_str_detail_text,
		"BATTLE",
		_str_origin
	);
}