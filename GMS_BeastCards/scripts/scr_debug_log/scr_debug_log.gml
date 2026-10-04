//===============================================================================//
//
// SCRIPT: SCR_DEBUG_LOG
// FUNCTION: Writes a standardized debug entry to GameMaker Output and the
//           current external session logfile.
//           Adds timestamps, origin tags, source tags, and visual prefixes.
//           Creates one logfile per game session and retains only the latest 10.
//
// ARGUMENTS: _str_system is the owning system. _str_sender is its subsystem.
//            _ref_sender is an optional source reference. _str_message is text.
//            _str_type controls the visual prefix. _str_origin identifies caller.
// RETURNS: The fully formatted log entry string.
//
//===============================================================================//

function scr_debug_log(_str_system,_str_sender,_ref_sender,_str_message,_str_type="INFO",_str_origin=""){

	//================//
	//LOGFILE STATE//
	//================//
	static _flag_log_initialized = false;
	static _flag_log_available = false;
	static _flag_log_has_entry = false;
	static _flag_log_write_failure_reported = false;

	static _str_log_directory =
		"G:/BEASTCARDS_LOGFILES/";

	static _str_log_path = "";

	//================//
	//INITIALIZE LOGFILE//
	//================//
	if (!_flag_log_initialized){

		_flag_log_initialized = true;

		//================//
		//CREATE DIRECTORY//
		//================//
		if (!directory_exists(_str_log_directory)){

			directory_create(
				_str_log_directory
			);
		}

		//================//
		//DIRECTORY READY//
		//================//
		if (directory_exists(_str_log_directory)){

			//================//
			//PRUNE OLD LOGS//
			//================//
			var _arr_log_files = [];

			var _str_found_file =
				file_find_first(
					_str_log_directory +
					"BEASTCARDS_*.txt",
					0
				);

			while (_str_found_file != ""){

				var _str_found_name =
					filename_name(
						_str_found_file
					);

				/*
					Do not count the temporary plaintext
					encoding-test file as a session log.
				*/

				if (
					_str_found_name !=
					"BEASTCARDS_PLAINTEXT_TEST.txt"
				){

					array_push(
						_arr_log_files,
						_str_found_name
					);
				}

				_str_found_file =
					file_find_next();
			}

			file_find_close();

			//================//
			//SORT OLD LOGS//
			//================//
			array_sort(
				_arr_log_files,
				true
			);

			/*
				Keep at most nine previous session logs.

				The current session logfile will become
				the tenth once its first actual entry is
				written.
			*/

			var _ct_logs_to_delete =
				max(
					0,
					array_length(
						_arr_log_files
					) - 9
				);

			for (
				var _it_log = 0;
				_it_log < _ct_logs_to_delete;
				_it_log++
			){

				var _str_old_log_path =
					_str_log_directory +
					_arr_log_files[_it_log];

				if (
					file_exists(
						_str_old_log_path
					)
				){

					file_delete(
						_str_old_log_path
					);
				}
			}

			//================//
			//SESSION FILENAME//
			//================//
			var _val_session_now =
				date_current_datetime();

			var _val_session_year =
				date_get_year(
					_val_session_now
				);

			var _val_session_month =
				date_get_month(
					_val_session_now
				);

			var _val_session_day =
				date_get_day(
					_val_session_now
				);

			var _val_session_hour =
				date_get_hour(
					_val_session_now
				);

			var _val_session_minute =
				date_get_minute(
					_val_session_now
				);

			var _val_session_second =
				date_get_second(
					_val_session_now
				);

			var _str_session_month =
				(_val_session_month < 10 ? "0" : "") +
				string(
					_val_session_month
				);

			var _str_session_day =
				(_val_session_day < 10 ? "0" : "") +
				string(
					_val_session_day
				);

			var _str_session_hour =
				(_val_session_hour < 10 ? "0" : "") +
				string(
					_val_session_hour
				);

			var _str_session_minute =
				(_val_session_minute < 10 ? "0" : "") +
				string(
					_val_session_minute
				);

			var _str_session_second =
				(_val_session_second < 10 ? "0" : "") +
				string(
					_val_session_second
				);

			var _str_session_time =
				string(
					_val_session_year
				) +
				"-" +
				_str_session_month +
				"-" +
				_str_session_day +
				"_" +
				_str_session_hour +
				"-" +
				_str_session_minute +
				"-" +
				_str_session_second;

			_str_log_path =
				_str_log_directory +
				"BEASTCARDS_" +
				_str_session_time +
				".txt";

			/*
				IMPORTANT:

				DO NOT create an empty file here.

				The first real debug entry will create the
				file with file_text_open_write(), exactly
				like the successful plaintext TIMMOTHY test.

				Every later entry will use append mode.
			*/

			_flag_log_available = true;
			_flag_log_has_entry = false;
		}
		else{

			_flag_log_available = false;

			show_debug_message(
				"!!! [CORE:LOGGING] EXTERNAL LOG DIRECTORY COULD NOT BE CREATED" +
				" | PATH: " +
				_str_log_directory
			);
		}
	}

	//================//
	//NORMALIZE INPUT//
	//================//
	_str_system =
		string_upper(
			string(
				_str_system
			)
		);

	_str_sender =
		string_upper(
			string(
				_str_sender
			)
		);

	_str_message =
		string(
			_str_message
		);

	_str_type =
		string_upper(
			string(
				_str_type
			)
		);

	_str_origin =
		string_upper(
			string(
				_str_origin
			)
		);

	//================//
	//FORCE ONE LINE//
	//================//
	/*
		Each scr_debug_log call owns exactly one physical
		logfile line.

		Any accidental line breaks inside the supplied
		message are flattened before output.
	*/

	_str_message =
		string_replace_all(
			_str_message,
			"\r",
			" "
		);

	_str_message =
		string_replace_all(
			_str_message,
			"\n",
			" "
		);

	//================//
	//GET SENDER NAME//
	//================//
	var _str_sender_name = "";

	if (is_struct(_ref_sender)){

		if (
			variable_struct_exists(
				_ref_sender,
				"_str_card_name"
			)
		){

			_str_sender_name =
				string(
					_ref_sender._str_card_name
				);
		}
		else if (
			variable_struct_exists(
				_ref_sender,
				"_str_beast_name"
			)
		){

			_str_sender_name =
				string(
					_ref_sender._str_beast_name
				);
		}
		else if (
			variable_struct_exists(
				_ref_sender,
				"_str_item_name"
			)
		){

			_str_sender_name =
				string(
					_ref_sender._str_item_name
				);
		}
		else if (
			variable_struct_exists(
				_ref_sender,
				"_str_name"
			)
		){

			_str_sender_name =
				string(
					_ref_sender._str_name
				);
		}
	}
	else if (instance_exists(_ref_sender)){

		if (
			variable_instance_exists(
				_ref_sender,
				"_str_card_name"
			)
		){

			_str_sender_name =
				string(
					_ref_sender._str_card_name
				);
		}
		else if (
			variable_instance_exists(
				_ref_sender,
				"_stct_unit"
			) &&
			is_struct(
				_ref_sender._stct_unit
			) &&
			variable_struct_exists(
				_ref_sender._stct_unit,
				"_str_beast_name"
			)
		){

			_str_sender_name =
				string(
					_ref_sender
						._stct_unit
						._str_beast_name
				);
		}
		else if (
			variable_instance_exists(
				_ref_sender,
				"_ref_unit"
			) &&
			is_struct(
				_ref_sender._ref_unit
			) &&
			variable_struct_exists(
				_ref_sender._ref_unit,
				"_str_beast_name"
			)
		){

			_str_sender_name =
				string(
					_ref_sender
						._ref_unit
						._str_beast_name
				);
		}
		else if (
			variable_instance_exists(
				_ref_sender,
				"_str_name"
			)
		){

			_str_sender_name =
				string(
					_ref_sender._str_name
				);
		}
	}

	//================//
	//BUILD SOURCE TAG//
	//================//
	var _str_source =
		_str_system;

	if (_str_sender != ""){

		_str_source +=
			":" +
			_str_sender;
	}

	if (_str_sender_name != ""){

		_str_source +=
			":" +
			string_upper(
				_str_sender_name
			);
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
	var _val_now =
		date_current_datetime();

	var _val_hour =
		date_get_hour(
			_val_now
		);

	var _val_minute =
		date_get_minute(
			_val_now
		);

	var _val_second =
		date_get_second(
			_val_now
		);

	var _str_hour =
		(_val_hour < 10 ? "0" : "") +
		string(
			_val_hour
		);

	var _str_minute =
		(_val_minute < 10 ? "0" : "") +
		string(
			_val_minute
		);

	var _str_second =
		(_val_second < 10 ? "0" : "") +
		string(
			_val_second
		);

	var _str_timestamp =
		_str_hour +
		":" +
		_str_minute +
		":" +
		_str_second;

	//================//
	//BUILD ORIGIN TAG//
	//================//
	var _str_origin_tag = "";

	if (_str_origin != ""){

		_str_origin_tag =
			"[" +
			_str_origin +
			"] ";
	}

	//================//
	//BUILD LOG ENTRY//
	//================//
	var _str_log_entry =
		_str_prefix +
		"[" +
		_str_timestamp +
		"] " +
		_str_origin_tag +
		"[" +
		_str_source +
		"] " +
		_str_message;

	//================//
	//WRITE TO OUTPUT//
	//================//
	show_debug_message(
		_str_log_entry
	);

	//================//
	//WRITE TO LOGFILE//
	//================//
	if (_flag_log_available){

		var _file_log = -1;

		//================//
		//FIRST LOG ENTRY//
		//================//
		/*
			The first actual debug entry creates the file
			and immediately writes real text into it.

			This deliberately matches the successful
			BEASTCARDS_PLAINTEXT_TEST write pattern.
		*/

		if (!_flag_log_has_entry){

			_file_log =
				file_text_open_write(
					_str_log_path
				);
		}

		//================//
		//LATER LOG ENTRIES//
		//================//
		else{

			_file_log =
				file_text_open_append(
					_str_log_path
				);
		}

		//================//
		//WRITE ONE ENTRY//
		//================//
		if (_file_log != -1){

			file_text_write_string(
				_file_log,
				_str_log_entry
			);

			file_text_writeln(
				_file_log
			);

			file_text_close(
				_file_log
			);

			_flag_log_has_entry = true;
		}

		//================//
		//WRITE FAILURE//
		//================//
		else{

			_flag_log_available = false;

			if (
				!_flag_log_write_failure_reported
			){

				_flag_log_write_failure_reported =
					true;

				show_debug_message(
					"!!! [CORE:LOGGING] EXTERNAL LOGFILE WRITE FAILED" +
						" | PATH: " +
						_str_log_path
				);
			}
		}
	}

	//================//
	//BATTLE LOG PANE//
	//================//
	var _flag_battle_log_entry =
		_str_type == "BATTLE";

	var _flag_cheat_log_entry =
		_str_system == "GUI" &&
		_str_sender == "CHEATS";

	if (
		room == rm_battle &&
		(
			_flag_battle_log_entry ||
			_flag_cheat_log_entry
		) &&
		instance_exists(
			obj_gui_battle_log_pane
		)
	){

		//------------------------//
		//EXCLUDE BATTLE LIFECYCLE//
		//------------------------//
		var _flag_battle_log_lifecycle =
			_str_sender == "ENTRY" ||
			_str_sender == "ENCOUNTER" ||
			_str_sender == "INITIATIVE" ||
			_str_sender == "START" ||
			_str_sender == "TURN" ||
			_str_sender == "ROUND" ||
			_str_sender == "TURN_CONTROLLER" ||
			_str_sender == "END" ||
			_str_sender == "RESULT" ||
			_str_sender == "REWARD" ||
			_str_sender == "EXIT" ||
			string_pos(
				":CREATE",
				_str_origin
			) > 0;

		//================//
		//ROUTE COMBAT LOG//
		//================//
		/*
			Normal BATTLE entries exclude lifecycle noise.

			CHEATS entries bypass that filter so every
			Cheat-menu operation performed during battle
			can appear in the pane.
		*/

		if (
			_flag_cheat_log_entry ||
			!_flag_battle_log_lifecycle
		){

			var _str_battle_log_entry =
				"[" +
				_str_timestamp +
				"] " +
				_str_message;

			obj_gui_battle_log_pane
				.hscr_gui_battle_log_add(
					_str_battle_log_entry
				);
		}
	}

	return _str_log_entry;
}