//===============================================================================//
//
// CREATE: OBJ_GUI_BATTLE_LOG_PANE
// FUNCTION: Initializes the ephemeral battle-action log.
//           Stores runtime combat log entries for the current battle only.
//           Displays eight entries per page and defaults to the newest page.
//
//===============================================================================//

#region VARIABLES

//================//
//PANE STATE//
//================//
_flag_log_visible = true;

_arr_log_entries = [];

_it_log_page = 0;
_ct_entries_per_page = 4;

//================//
//LAYOUT//
//================//
_val_pane_width = 200;
_val_pane_top = 30;

_val_header_height = 30;
_val_footer_height = 26;

_val_padding = 8;

// Each entry gets enough vertical space for roughly three lines.
_val_entry_height = 48;
_ct_entry_lines = 3;
_val_entry_line_height = 14;

_val_tab_width = 24;
_val_tab_height = 44;

//================//
//DRAW ORDER//
//================//
depth = -5000;

#endregion

#region INIT

//================//
//NON-PERSISTENT//
//================//
persistent = false;

#endregion

#region METHODS

//-------------------------------------------------------------------------------//
// HSCR_GUI_BATTLE_LOG_GET_PAGE_COUNT
// FUNCTION: Returns the current number of battle-log pages.
//-------------------------------------------------------------------------------//
hscr_gui_battle_log_get_page_count = function(){

	var _ct_entries = array_length(_arr_log_entries);

	if (_ct_entries <= 0){
		return 1;
	}

	return ceil(_ct_entries / _ct_entries_per_page);
};

//-------------------------------------------------------------------------------//
// HSCR_GUI_BATTLE_LOG_GET_MAX_PAGE
// FUNCTION: Returns the highest legal zero-based page index.
//-------------------------------------------------------------------------------//
hscr_gui_battle_log_get_max_page = function(){

	return max(
		0,
		hscr_gui_battle_log_get_page_count() - 1
	);
};

//-------------------------------------------------------------------------------//
// HSCR_GUI_BATTLE_LOG_ADD
// FUNCTION: Adds one combat log entry to the current battle.
//           Auto-follows new entries only while viewing the newest page.
//-------------------------------------------------------------------------------//
hscr_gui_battle_log_add = function(_str_entry){

	if (!is_string(_str_entry)){
		return false;
	}

	if (_str_entry == ""){
		return false;
	}

	//================//
	//FOLLOW STATE//
	//================//
	var _it_old_max_page =
		hscr_gui_battle_log_get_max_page();

	var _flag_follow_newest =
		_it_log_page >= _it_old_max_page;

	//================//
	//ADD ENTRY//
	//================//
	array_push(
		_arr_log_entries,
		_str_entry
	);

	//================//
	//UPDATE PAGE//
	//================//
	var _it_new_max_page =
		hscr_gui_battle_log_get_max_page();

	if (_flag_follow_newest){
		_it_log_page = _it_new_max_page;
	}
	else{
		_it_log_page = clamp(
			_it_log_page,
			0,
			_it_new_max_page
		);
	}

	return true;
};

//-------------------------------------------------------------------------------//
// HSCR_GUI_BATTLE_LOG_TOGGLE
// FUNCTION: Toggles the expanded battle-log pane.
//-------------------------------------------------------------------------------//
hscr_gui_battle_log_toggle = function(){

	_flag_log_visible = !_flag_log_visible;

	return _flag_log_visible;
};

//-------------------------------------------------------------------------------//
// HSCR_GUI_BATTLE_LOG_WRAP_TEXT
// FUNCTION: Wraps one battle-log entry into at most three readable lines.
//           Truncates overflowing content with an ellipsis.
//-------------------------------------------------------------------------------//
hscr_gui_battle_log_wrap_text = function(_str_text,_val_max_width){

	var _arr_words = string_split(string(_str_text)," ");

	var _arr_lines = [];
	var _str_line = "";

	for (var _it_word = 0; _it_word < array_length(_arr_words); _it_word++){

		var _str_word = _arr_words[_it_word];

		var _str_test =
			(_str_line == "")
			? _str_word
			: _str_line + " " + _str_word;

		//================//
		//WORD FITS LINE//
		//================//
		if (string_width(_str_test) <= _val_max_width){

			_str_line = _str_test;
			continue;
		}

		//================//
		//STORE LINE//
		//================//
		if (_str_line != ""){
			array_push(_arr_lines,_str_line);
		}

		_str_line = _str_word;

		//================//
		//FINAL LINE//
		//================//
		if (array_length(_arr_lines) >= _ct_entry_lines - 1){

			var _str_remaining = _str_line;

			for (
				var _it_remaining = _it_word + 1;
				_it_remaining < array_length(_arr_words);
				_it_remaining++
			){

				_str_remaining +=
					" " +
					_arr_words[_it_remaining];
			}

			//----------------//
			//TRUNCATE//
			//----------------//
			while (
				string_length(_str_remaining) > 0 &&
				string_width(_str_remaining + "...") > _val_max_width
			){

				_str_remaining =
					string_delete(
						_str_remaining,
						string_length(_str_remaining),
						1
					);
			}

			array_push(
				_arr_lines,
				_str_remaining + "..."
			);

			return _arr_lines;
		}
	}

	//================//
	//FINAL TEXT LINE//
	//================//
	if (_str_line != ""){
		array_push(_arr_lines,_str_line);
	}

	return _arr_lines;
};

#endregion