//===============================================================================//
//
// SCRIPT: SCR_DEBUG_LOG
// FUNCTION: Writes a standardized debug entry to GameMaker Output.
//           Adds timestamps, origin tags, source tags, and visual prefixes.
//           Session logfile output remains disabled until external playtesting.
//
// ARGUMENTS: _str_system is the owning system. _str_sender is its subsystem.
//            _ref_sender is an optional source reference. _str_message is text.
//            _str_type controls the visual prefix. _str_origin identifies caller.
// RETURNS: The fully formatted log entry string.
//
//===============================================================================//

function scr_debug_log(_str_system,_str_sender,_ref_sender,_str_message,_str_type="INFO",_str_origin=""){

	/*
	//================//
	//SESSION LOGFILE//
	//================//
	static _str_log_path = "";

	if (_str_log_path == ""){

		var _val_now = date_current_datetime();

		var _val_year = date_get_year(_val_now);
		var _val_month = date_get_month(_val_now);
		var _val_day = date_get_day(_val_now);
		var _val_hour = date_get_hour(_val_now);
		var _val_minute = date_get_minute(_val_now);
		var _val_second = date_get_second(_val_now);

		var _str_month = (_val_month < 10 ? "0" : "") + string(_val_month);
		var _str_day = (_val_day < 10 ? "0" : "") + string(_val_day);
		var _str_hour = (_val_hour < 10 ? "0" : "") + string(_val_hour);
		var _str_minute = (_val_minute < 10 ? "0" : "") + string(_val_minute);
		var _str_second = (_val_second < 10 ? "0" : "") + string(_val_second);

		var _str_session_time =
			string(_val_year) + "-" +
			_str_month + "-" +
			_str_day + "_" +
			_str_hour + "-" +
			_str_minute + "-" +
			_str_second;

		var _str_log_directory = working_directory + "logs/";

		if (!directory_exists(_str_log_directory)){
			directory_create(_str_log_directory);
		}

		_str_log_path = _str_log_directory + "beastcards_" + _str_session_time + ".log";
	}
	*/

	//================//
	//NORMALIZE INPUT//
	//================//
	_str_system = string_upper(string(_str_system));
	_str_sender = string_upper(string(_str_sender));
	_str_message = string(_str_message);
	_str_type = string_upper(string(_str_type));
	_str_origin = string_upper(string(_str_origin));

	//================//
	//GET SENDER NAME//
	//================//
	var _str_sender_name = "";

	if (is_struct(_ref_sender)){

		if (variable_struct_exists(_ref_sender,"_str_card_name")){
			_str_sender_name = string(_ref_sender._str_card_name);
		}
		else if (variable_struct_exists(_ref_sender,"_str_beast_name")){
			_str_sender_name = string(_ref_sender._str_beast_name);
		}
		else if (variable_struct_exists(_ref_sender,"_str_item_name")){
			_str_sender_name = string(_ref_sender._str_item_name);
		}
		else if (variable_struct_exists(_ref_sender,"_str_name")){
			_str_sender_name = string(_ref_sender._str_name);
		}
	}
	else if (instance_exists(_ref_sender)){

		if (variable_instance_exists(_ref_sender,"_str_card_name")){
			_str_sender_name = string(_ref_sender._str_card_name);
		}
		else if (
			variable_instance_exists(_ref_sender,"_stct_unit") &&
			is_struct(_ref_sender._stct_unit) &&
			variable_struct_exists(_ref_sender._stct_unit,"_str_beast_name")
		){
			_str_sender_name = string(_ref_sender._stct_unit._str_beast_name);
		}
		else if (
			variable_instance_exists(_ref_sender,"_ref_unit") &&
			is_struct(_ref_sender._ref_unit) &&
			variable_struct_exists(_ref_sender._ref_unit,"_str_beast_name")
		){
			_str_sender_name = string(_ref_sender._ref_unit._str_beast_name);
		}
		else if (variable_instance_exists(_ref_sender,"_str_name")){
			_str_sender_name = string(_ref_sender._str_name);
		}
	}

	//================//
	//BUILD SOURCE TAG//
	//================//
	var _str_source = _str_system;

	if (_str_sender != ""){
		_str_source += ":" + _str_sender;
	}

	if (_str_sender_name != ""){
		_str_source += ":" + string_upper(_str_sender_name);
	}

	//================//
	//BUILD PREFIX//
	//================//
	var _str_prefix = "";

	switch (_str_type){

		case "INIT":
			_str_prefix = "### ";
		break;

		case "ERROR":
			_str_prefix = "!!! ";
		break;

		case "WARNING":
			_str_prefix = "!! ";
		break;

		case "BATTLE":
			_str_prefix = "⚔⚔⚔ ";
		break;

		case "TRANSITION":
			_str_prefix = ">>> ";
		break;

		case "MUSIC":
			_str_prefix = "♪♪♪ ";
		break;

		case "REWARD":
			_str_prefix = "+++ ";
		break;
	}

	//================//
	//BUILD TIMESTAMP//
	//================//
	var _val_now = date_current_datetime();

	var _val_hour = date_get_hour(_val_now);
	var _val_minute = date_get_minute(_val_now);
	var _val_second = date_get_second(_val_now);

	var _str_hour = (_val_hour < 10 ? "0" : "") + string(_val_hour);
	var _str_minute = (_val_minute < 10 ? "0" : "") + string(_val_minute);
	var _str_second = (_val_second < 10 ? "0" : "") + string(_val_second);

	var _str_timestamp = _str_hour + ":" + _str_minute + ":" + _str_second;

	//================//
	//BUILD ORIGIN TAG//
	//================//
	var _str_origin_tag = "";

	if (_str_origin != ""){
		_str_origin_tag = "[" + _str_origin + "] ";
	}

	//================//
	//BUILD LOG ENTRY//
	//================//
	var _str_log_entry =
		_str_prefix +
		"[" + _str_timestamp + "] " +
		_str_origin_tag +
		"[" + _str_source + "] " +
		_str_message;

	/*
	//================//
	//WRITE TO LOGFILE//
	//================//
	var _file_log = file_text_open_append(_str_log_path);

	if (_file_log != -1){
		file_text_write_string(_file_log,_str_log_entry);
		file_text_writeln(_file_log);
		file_text_close(_file_log);
	}
	*/

	//================//
	//WRITE TO OUTPUT//
	//================//
	show_debug_message(_str_log_entry);

	/*
	//================//
	//FUTURE SCROLL LOG//
	//================//
	scr_gui_log_add_entry(
		_str_system,
		_str_sender,
		_ref_sender,
		_str_message,
		_str_log_entry
	);
	*/

	return _str_log_entry;
}