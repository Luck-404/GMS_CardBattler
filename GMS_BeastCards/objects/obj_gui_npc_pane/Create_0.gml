//===============================================================================//
//
// CREATE: OBJ_GUI_NPC_PANE
// FUNCTION: Initializes the NPC interaction GUI.
//           Stores NPC references, menu options, layout, and dialogue state.
//           Defines menu navigation, dialogue, trading, and closing helpers.
//
//===============================================================================//

//================//
//VARIABLES//
//================//
#region VARIABLES

//----------------//
//REFERENCES//
//----------------//
_ref_npc = undefined;
_stct_npc = undefined;

_flag_transfer_to_market = false;

//----------------//
//GUI STATE//
//----------------//
_str_type = "NPC";
_str_npc_gui_mode = "MENU";

_arr_options = [];

_it_option_selected = 0;
_it_option_hovered = -1;

//----------------//
//DIALOGUE//
//----------------//
_arr_dialogue = [];

_it_dialogue_line = 0;

_str_dialogue_full = "";
_str_dialogue_visible = "";

_it_dialogue_char = 0;
_ct_dialogue_tick = 0;

_ct_dialogue_chars_per_tick = 2;
_ct_dialogue_tick_max = 1;

_flag_dialogue_line_complete = false;
_flag_dialogue_finished = false;

//----------------//
//PANE LAYOUT//
//----------------//
_val_pane_w = 420;
_val_pane_h = 420;

_val_pane_left = x - (_val_pane_w * 0.5);
_val_pane_top = y - (_val_pane_h * 0.5);

_val_header_x = _val_pane_left + 24;
_val_header_y = _val_pane_top + 24;

_val_option_x = _val_pane_left + 40;
_val_option_start_y = _val_pane_top + 130;

_val_option_w = _val_pane_w - 80;
_val_option_h = 48;
_val_option_gap = 12;

_val_dialogue_x = _val_pane_left + 32;
_val_dialogue_y = _val_pane_top + 130;
_val_dialogue_w = _val_pane_w - 64;

//----------------//
//INPUT//
//----------------//
_flag_clicked = false;
_ct_cooldown = 10;

#endregion

//================//
//INIT//
//================//
#region INIT

depth = -10000;

global.ref_active_gui = self;

#endregion

//================//
//METHODS//
//================//
#region METHODS

//-------------------------------------------------------------------------------//
// HSCR_GUI_NPC_OPEN_TRADE
// FUNCTION: Transfers the active NPC interaction into the generic Market pane.
//           Passes vendor stock, NPC UID, and NPC reference.
//           Keeps NPC interaction ownership active until Market cleanup.
//
// ARGUMENTS: None.
// RETURNS: True when the Market opens; otherwise false.
//
//-------------------------------------------------------------------------------//
hscr_gui_npc_open_trade = function(){

	//================//
	//VALIDATE NPC//
	//================//
	if (!instance_exists(_ref_npc)){
		return false;
	}

	if (_stct_npc == undefined){
		return false;
	}

	if (!_stct_npc._flag_can_trade){
		return false;
	}

	//================//
	//VALIDATE STOCK//
	//================//
	if (
		!is_array(_stct_npc._arr_trade_stock) ||
		array_length(_stct_npc._arr_trade_stock) <= 0
	){

		audio_play_sound(
			snd_gui_error,
			0,
			false
		);

		scr_gui_spawn_popup_error(
			"NOTHING FOR SALE",
			60
		);

		scr_debug_log(
			"NPC",
			"TRADE",
			_ref_npc,
			"NPC TRADE BLOCKED" +
			" | NPC: " +
			string_upper(_stct_npc._str_npc_name) +
			" | UID: " +
			string(_ref_npc._uid_npc) +
			" | REASON: NO TRADE STOCK",
			"WARNING",
			"OBJ_GUI_NPC_PANE:HSCR_GUI_NPC_OPEN_TRADE"
		);

		return false;
	}

	//================//
	//CREATE MARKET//
	//================//
	var _ref_market_gui = instance_create_layer(
		display_get_gui_width() * 0.5,
		display_get_gui_height() * 0.5,
		"ily_fx",
		obj_gui_market_pane
	);

	if (!instance_exists(_ref_market_gui)){

		scr_debug_log(
			"NPC",
			"TRADE",
			_ref_npc,
			"NPC TRADE FAILED" +
			" | NPC: " +
			string_upper(_stct_npc._str_npc_name) +
			" | UID: " +
			string(_ref_npc._uid_npc) +
			" | REASON: MARKET GUI CREATION FAILED",
			"ERROR",
			"OBJ_GUI_NPC_PANE:HSCR_GUI_NPC_OPEN_TRADE"
		);

		return false;
	}

	//================//
	//CONFIGURE MARKET//
	//================//
	var _str_market_uid =
		"NPC_VENDOR_" +
		string(_ref_npc._uid_npc);

	_ref_market_gui._str_market_type = "NPC";
	_ref_market_gui._str_market_uid = _str_market_uid;

	_ref_market_gui._ref_market_owner = _ref_npc;
	_ref_market_gui._ref_npc = _ref_npc;

	_ref_market_gui._arr_external_stock = _stct_npc._arr_trade_stock;
	_ref_market_gui._flag_return_to_npc = true;

	var _flag_market_initialized =
		_ref_market_gui.hscr_gui_market_init();

	if (!_flag_market_initialized){

		instance_destroy(_ref_market_gui);

		return false;
	}

	global.ref_active_gui = _ref_market_gui;

	//================//
	//DEBUG TRADE//
	//================//
	scr_debug_log(
		"NPC",
		"TRADE",
		_ref_npc,
		"NPC TRADE OPENED" +
		" | NPC: " +
		string_upper(_stct_npc._str_npc_name) +
		" | UID: " +
		string(_ref_npc._uid_npc) +
		" | MARKET UID: " +
		string_upper(_str_market_uid) +
		" | STOCK DEFINITIONS: " +
		string(array_length(_stct_npc._arr_trade_stock)),
		"INFO",
		"OBJ_GUI_NPC_PANE:HSCR_GUI_NPC_OPEN_TRADE"
	);

	//================//
	//TRANSFER CONTROL//
	//================//
	_flag_transfer_to_market = true;

	instance_destroy();

	return true;
};

//-------------------------------------------------------------------------------//
// HSCR_GUI_NPC_INIT
// FUNCTION: Initializes the NPC pane after receiving an NPC reference.
//           Retrieves NPC data and builds available interaction options.
//
// ARGUMENTS: None.
// RETURNS: True when initialization succeeds; otherwise false.
//
//-------------------------------------------------------------------------------//
hscr_gui_npc_init = function(){

	//================//
	//VALIDATE NPC//
	//================//
	if (!instance_exists(_ref_npc)){

		scr_debug_log(
			"NPC",
			"GUI",
			self,
			"NPC PANE INITIALIZATION FAILED" +
			" | REASON: INVALID NPC REFERENCE",
			"ERROR",
			"OBJ_GUI_NPC_PANE:HSCR_GUI_NPC_INIT"
		);

		instance_destroy();

		return false;
	}

	//================//
	//GET NPC DATA//
	//================//
	_stct_npc = _ref_npc._stct_npc;

	if (_stct_npc == undefined){

		scr_debug_log(
			"NPC",
			"GUI",
			_ref_npc,
			"NPC PANE INITIALIZATION FAILED" +
			" | UID: " +
			string(_ref_npc._uid_npc) +
			" | REASON: NPC DATA UNDEFINED",
			"ERROR",
			"OBJ_GUI_NPC_PANE:HSCR_GUI_NPC_INIT"
		);

		instance_destroy();

		return false;
	}

	//================//
	//BUILD MENU//
	//================//
	hscr_gui_npc_build_options();

	if (array_length(_arr_options) > 0){
		_it_option_selected = 0;
	}
	else{
		_it_option_selected = -1;
	}

	return true;
};

//-------------------------------------------------------------------------------//
// HSCR_GUI_NPC_BUILD_OPTIONS
// FUNCTION: Builds the NPC interaction menu from enabled interaction flags.
//           Only includes interactions supported by the active NPC.
//
// ARGUMENTS: None.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
hscr_gui_npc_build_options = function(){

	_arr_options = [];

	if (_stct_npc == undefined){
		return;
	}

	if (_stct_npc._flag_can_talk){
		array_push(_arr_options,"TALK");
	}

	if (_stct_npc._flag_can_quest){
		array_push(_arr_options,"QUEST");
	}

	if (_stct_npc._flag_can_trade){
		array_push(_arr_options,"TRADE");
	}

	if (_stct_npc._flag_can_fight){
		array_push(_arr_options,"FIGHT");
	}
};

//-------------------------------------------------------------------------------//
// HSCR_GUI_NPC_IS_MOUSE_IN_RECT
// FUNCTION: Checks whether the GUI mouse position is inside a rectangle.
//
// ARGUMENTS: Mouse x/y and rectangle x1/y1/x2/y2 coordinates.
// RETURNS: True when the mouse is inside the rectangle.
//
//-------------------------------------------------------------------------------//
hscr_gui_npc_is_mouse_in_rect = function(
	_val_mouse_x,
	_val_mouse_y,
	_val_x1,
	_val_y1,
	_val_x2,
	_val_y2
){

	return (
		_val_mouse_x >= _val_x1 &&
		_val_mouse_x <= _val_x2 &&
		_val_mouse_y >= _val_y1 &&
		_val_mouse_y <= _val_y2
	);
};

//-------------------------------------------------------------------------------//
// HSCR_GUI_NPC_UPDATE_CLICK_COOLDOWN
// FUNCTION: Updates the NPC GUI input cooldown.
//           Prevents one input from triggering multiple GUI actions.
//
// ARGUMENTS: None.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
hscr_gui_npc_update_click_cooldown = function(){

	if (_ct_cooldown > 0){
		_ct_cooldown--;
	}

	if (_ct_cooldown <= 0){
		_ct_cooldown = 0;
		_flag_clicked = false;
	}
};

//-------------------------------------------------------------------------------//
// HSCR_GUI_NPC_SELECT_PREVIOUS_OPTION
// FUNCTION: Moves selection to the previous NPC interaction option.
//           Wraps to the final option when moving above the first.
//
// ARGUMENTS: None.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
hscr_gui_npc_select_previous_option = function(){

	var _ct_options = array_length(_arr_options);

	if (_ct_options <= 0){
		return;
	}

	_it_option_selected--;

	if (_it_option_selected < 0){
		_it_option_selected = _ct_options - 1;
	}

	audio_play_sound(snd_gui_press,0,false);
};

//-------------------------------------------------------------------------------//
// HSCR_GUI_NPC_SELECT_NEXT_OPTION
// FUNCTION: Moves selection to the next NPC interaction option.
//           Wraps to the first option after the final option.
//
// ARGUMENTS: None.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
hscr_gui_npc_select_next_option = function(){

	var _ct_options = array_length(_arr_options);

	if (_ct_options <= 0){
		return;
	}

	_it_option_selected++;

	if (_it_option_selected >= _ct_options){
		_it_option_selected = 0;
	}

	audio_play_sound(snd_gui_press,0,false);
};

//-------------------------------------------------------------------------------//
// HSCR_GUI_NPC_START_DIALOGUE
// FUNCTION: Starts the active NPC's stored dialogue.
//           Resets dialogue progress, loads the first line, and logs the
//           conversation start.
//
// ARGUMENTS: None.
// RETURNS: True when dialogue starts; otherwise false.
//
//-------------------------------------------------------------------------------//
hscr_gui_npc_start_dialogue = function(){

	//================//
	//VALIDATE NPC//
	//================//
	if (_stct_npc == undefined){
		return false;
	}

	//================//
	//LOAD DIALOGUE//
	//================//
	_arr_dialogue = _stct_npc._arr_npc_dialogue;

	if (!is_array(_arr_dialogue)){
		_arr_dialogue = [];
	}

	if (array_length(_arr_dialogue) <= 0){
		_arr_dialogue = ["..."];
	}

	//================//
	//START DIALOGUE//
	//================//
	_str_npc_gui_mode = "DIALOGUE";

	_it_dialogue_line = 0;
	_flag_dialogue_finished = false;

	hscr_gui_npc_load_dialogue_line();

	//================//
	//DEBUG DIALOGUE//
	//================//
	scr_debug_log(
		"NPC",
		"DIALOGUE",
		_ref_npc,
		"DIALOGUE STARTED" +
		" | NPC: " +
		string_upper(_stct_npc._str_npc_name) +
		" | UID: " +
		string(_ref_npc._uid_npc) +
		" | LINES: " +
		string(array_length(_arr_dialogue)),
		"INFO",
		"OBJ_GUI_NPC_PANE:HSCR_GUI_NPC_START_DIALOGUE"
	);

	return true;
};

//-------------------------------------------------------------------------------//
// HSCR_GUI_NPC_LOAD_DIALOGUE_LINE
// FUNCTION: Loads the current dialogue line.
//           Resets visible text and character-scrolling progress.
//
// ARGUMENTS: None.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
hscr_gui_npc_load_dialogue_line = function(){

	if (_it_dialogue_line < 0 || _it_dialogue_line >= array_length(_arr_dialogue)){
		hscr_gui_npc_finish_dialogue();
		return;
	}

	_str_dialogue_full = string(_arr_dialogue[_it_dialogue_line]);
	_str_dialogue_visible = "";

	_it_dialogue_char = 0;
	_ct_dialogue_tick = 0;

	_flag_dialogue_line_complete = false;
};

//-------------------------------------------------------------------------------//
// HSCR_GUI_NPC_UPDATE_DIALOGUE
// FUNCTION: Reveals the current dialogue line over time.
//           Marks the line complete when the full text is visible.
//
// ARGUMENTS: None.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
hscr_gui_npc_update_dialogue = function(){

	if (_str_npc_gui_mode != "DIALOGUE"){
		return;
	}

	if (_flag_dialogue_line_complete){
		return;
	}

	_ct_dialogue_tick++;

	if (_ct_dialogue_tick < _ct_dialogue_tick_max){
		return;
	}

	_ct_dialogue_tick = 0;

	_it_dialogue_char += _ct_dialogue_chars_per_tick;
	_it_dialogue_char = min(_it_dialogue_char,string_length(_str_dialogue_full));

	_str_dialogue_visible = string_copy(
		_str_dialogue_full,
		1,
		_it_dialogue_char
	);

	if (_it_dialogue_char >= string_length(_str_dialogue_full)){
		_str_dialogue_visible = _str_dialogue_full;
		_flag_dialogue_line_complete = true;
	}
};

//-------------------------------------------------------------------------------//
// HSCR_GUI_NPC_COMPLETE_DIALOGUE_LINE
// FUNCTION: Immediately reveals the full current dialogue line.
//
// ARGUMENTS: None.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
hscr_gui_npc_complete_dialogue_line = function(){

	_it_dialogue_char = string_length(_str_dialogue_full);

	_str_dialogue_visible = _str_dialogue_full;
	_flag_dialogue_line_complete = true;
};

//-------------------------------------------------------------------------------//
// HSCR_GUI_NPC_ADVANCE_DIALOGUE
// FUNCTION: Completes the current scrolling line or advances to the next.
//           Finishes dialogue after the final stored line.
//
// ARGUMENTS: None.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
hscr_gui_npc_advance_dialogue = function(){

	if (_str_npc_gui_mode != "DIALOGUE"){
		return;
	}

	if (!_flag_dialogue_line_complete){
		hscr_gui_npc_complete_dialogue_line();
		return;
	}

	_it_dialogue_line++;

	if (_it_dialogue_line >= array_length(_arr_dialogue)){
		hscr_gui_npc_finish_dialogue();
		return;
	}

	hscr_gui_npc_load_dialogue_line();
};

//-------------------------------------------------------------------------------//
// HSCR_GUI_NPC_FINISH_DIALOGUE
// FUNCTION: Ends the conversation and returns to the NPC menu.
//           Logs completion before clearing temporary dialogue state.
//
// ARGUMENTS: None.
// RETURNS: True when dialogue finishes.
//
//-------------------------------------------------------------------------------//
hscr_gui_npc_finish_dialogue = function(){

	//================//
	//STORE DIALOGUE DATA//
	//================//
	var _ct_dialogue_lines = array_length(_arr_dialogue);

	//================//
	//DEBUG DIALOGUE//
	//================//
	if (
		_stct_npc != undefined &&
		instance_exists(_ref_npc)
	){

		scr_debug_log(
			"NPC",
			"DIALOGUE",
			_ref_npc,
			"DIALOGUE COMPLETED" +
			" | NPC: " +
			string_upper(_stct_npc._str_npc_name) +
			" | UID: " +
			string(_ref_npc._uid_npc) +
			" | LINES: " +
			string(_ct_dialogue_lines),
			"INFO",
			"OBJ_GUI_NPC_PANE:HSCR_GUI_NPC_FINISH_DIALOGUE"
		);
	}

	//================//
	//RESET DIALOGUE//
	//================//
	_flag_dialogue_finished = true;

	_str_npc_gui_mode = "MENU";

	_arr_dialogue = [];

	_it_dialogue_line = 0;

	_str_dialogue_full = "";
	_str_dialogue_visible = "";

	_it_dialogue_char = 0;
	_ct_dialogue_tick = 0;

	_flag_dialogue_line_complete = false;

	_flag_clicked = true;
	_ct_cooldown = 10;

	return true;
};

//-------------------------------------------------------------------------------//
// HSCR_GUI_NPC_HANDLE_DIALOGUE_INPUT
// FUNCTION: Handles input while dialogue is active.
//           Allows mouse, E, Enter, or Space to advance dialogue.
//
// ARGUMENTS: None.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
hscr_gui_npc_handle_dialogue_input = function(){

	if (_str_npc_gui_mode != "DIALOGUE"){
		return;
	}

	if (_ct_cooldown > 0){
		return;
	}

	var _flag_advance =
		mouse_check_button_pressed(mb_left) ||
		keyboard_check_pressed(ord("E")) ||
		keyboard_check_pressed(vk_enter) ||
		keyboard_check_pressed(vk_space);

	if (_flag_advance){

		_flag_clicked = true;
		_ct_cooldown = 6;

		hscr_gui_npc_advance_dialogue();
	}
};

//-------------------------------------------------------------------------------//
// HSCR_GUI_NPC_DRAW_DIALOGUE
// FUNCTION: Draws the active NPC dialogue line.
//           Displays an advance indicator when the line is fully visible.
//
// ARGUMENTS: None.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
hscr_gui_npc_draw_dialogue = function(){

	draw_set_font(fnt_gui_small);
	draw_set_colour(c_white);

	draw_text_ext(
		_val_dialogue_x,
		_val_dialogue_y,
		_str_dialogue_visible,
		-1,
		_val_dialogue_w
	);

	draw_set_colour(c_ltgray);

	draw_text(
		_val_dialogue_x,
		_val_pane_top + _val_pane_h - 60,
		"E / ENTER / CLICK: ADVANCE"
	);

	if (_flag_dialogue_line_complete){

		draw_set_colour(c_white);
		draw_set_halign(fa_right);

		draw_text(
			_val_pane_left + _val_pane_w - 28,
			_val_pane_top + _val_pane_h - 60,
			">"
		);

		draw_set_halign(fa_left);
	}
};

//-------------------------------------------------------------------------------//
// HSCR_GUI_NPC_ACTIVATE_OPTION
// FUNCTION: Activates the selected NPC interaction option.
//           Routes into dialogue or trade.
//           Reports Quest and Fight selections as currently unimplemented.
//
// ARGUMENTS: _str_option is the selected interaction option.
// RETURNS: True when a supported option begins; otherwise false.
//
//-------------------------------------------------------------------------------//
hscr_gui_npc_activate_option = function(_str_option){

	//================//
	//VALIDATE OPTION//
	//================//
	if (_str_option == undefined){
		return false;
	}

	if (_stct_npc == undefined){
		return false;
	}

	audio_play_sound(
		snd_gui_press,
		0,
		false
	);

	//================//
	//ACTIVATE OPTION//
	//================//
	switch (_str_option){

		//======//
		//TALK//
		//======//
		case "TALK":

			return hscr_gui_npc_start_dialogue();

		//=======//
		//QUEST//
		//=======//
		case "QUEST":

			scr_debug_log(
				"NPC",
				"QUEST",
				_ref_npc,
				"NPC QUEST SELECTED" +
				" | NPC: " +
				string_upper(_stct_npc._str_npc_name) +
				" | UID: " +
				string(_ref_npc._uid_npc) +
				" | STATUS: NOT IMPLEMENTED",
				"WARNING",
				"OBJ_GUI_NPC_PANE:HSCR_GUI_NPC_ACTIVATE_OPTION"
			);

			return false;

		//=======//
		//TRADE//
		//=======//
		case "TRADE":

			return hscr_gui_npc_open_trade();

		//=======//
		//FIGHT//
		//=======//
		case "FIGHT":

			scr_debug_log(
				"NPC",
				"FIGHT",
				_ref_npc,
				"NPC FIGHT SELECTED" +
				" | NPC: " +
				string_upper(_stct_npc._str_npc_name) +
				" | UID: " +
				string(_ref_npc._uid_npc) +
				" | STATUS: NOT IMPLEMENTED",
				"WARNING",
				"OBJ_GUI_NPC_PANE:HSCR_GUI_NPC_ACTIVATE_OPTION"
			);

			return false;
	}

	//================//
	//UNKNOWN OPTION//
	//================//
	scr_debug_log(
		"NPC",
		"INTERACTION",
		_ref_npc,
		"UNKNOWN NPC OPTION" +
		" | NPC: " +
		string_upper(_stct_npc._str_npc_name) +
		" | OPTION: " +
		string_upper(_str_option),
		"WARNING",
		"OBJ_GUI_NPC_PANE:HSCR_GUI_NPC_ACTIVATE_OPTION"
	);

	return false;
};

//-------------------------------------------------------------------------------//
// HSCR_GUI_NPC_HANDLE_MENU_INPUT
// FUNCTION: Handles keyboard navigation and activation while in menu mode.
//
// ARGUMENTS: None.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
hscr_gui_npc_handle_menu_input = function(){

	if (_str_npc_gui_mode != "MENU"){
		return;
	}

	if (_ct_cooldown > 0){
		return;
	}

	if (keyboard_check_pressed(vk_up)){
		hscr_gui_npc_select_previous_option();
	}

	if (keyboard_check_pressed(vk_down)){
		hscr_gui_npc_select_next_option();
	}

	if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("E"))){

		if (_it_option_selected >= 0 && _it_option_selected < array_length(_arr_options)){

			hscr_gui_npc_activate_option(_arr_options[_it_option_selected]);

			_flag_clicked = true;
			_ct_cooldown = 10;
		}
	}
};

//-------------------------------------------------------------------------------//
// HSCR_GUI_NPC_CLOSE
// FUNCTION: Closes the NPC interaction pane.
//           Unpauses gameplay, resumes NPC movement, and clears references.
//
// ARGUMENTS: None.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
hscr_gui_npc_close = function(){

	//----------------//
	//RELEASE NPC//
	//----------------//
	if (instance_exists(_ref_npc)){

		if (variable_instance_exists(_ref_npc,"hscr_npc_close_interaction")){
			_ref_npc.hscr_npc_close_interaction();
		}
		else{

			_ref_npc._flag_triggered = false;

			if (_ref_npc._str_path_type == "PATH" && _ref_npc.path_index != -1){
				_ref_npc.path_speed = _ref_npc._val_move_speed;
			}
		}
	}

	//----------------//
	//CLEAR STATE//
	//----------------//
	global.flag_pause = false;

	if (variable_global_exists("ref_interacting_npc") && global.ref_interacting_npc == _ref_npc){
		global.ref_interacting_npc = undefined;
	}

	if (variable_global_exists("ref_active_gui") && global.ref_active_gui == self){
		global.ref_active_gui = undefined;
	}

	instance_destroy();
};

//-------------------------------------------------------------------------------//
// HSCR_GUI_NPC_DRAW_MENU_OPTION
// FUNCTION: Draws one NPC interaction option.
//           Displays hover and keyboard selection consistently.
//           Activates the exact option clicked by the player.
//
// ARGUMENTS: Option string, option index, and GUI mouse x/y.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
hscr_gui_npc_draw_menu_option = function(_str_option,_it_option,_val_mouse_x,_val_mouse_y){

	var _val_box_x1 = _val_option_x;
	var _val_box_y1 = _val_option_start_y + (_it_option * (_val_option_h + _val_option_gap));

	var _val_box_x2 = _val_box_x1 + _val_option_w;
	var _val_box_y2 = _val_box_y1 + _val_option_h;

	var _flag_hover = (_it_option_hovered == _it_option);
	var _flag_selected = (_it_option_selected == _it_option);

	//----------------//
	//OUTER BOX//
	//----------------//
	draw_set_colour(c_black);

	draw_rectangle(
		_val_box_x1,
		_val_box_y1,
		_val_box_x2,
		_val_box_y2,
		false
	);

	//----------------//
	//INNER BOX//
	//----------------//
	if (_flag_hover){
		draw_set_colour(c_white);
	}
	else if (_flag_selected){
		draw_set_colour(global.c_dk_gray);
	}
	else{
		draw_set_colour(c_ltgray);
	}

	draw_rectangle(
		_val_box_x1 + 3,
		_val_box_y1 + 3,
		_val_box_x2 - 3,
		_val_box_y2 - 3,
		false
	);

	//----------------//
	//OPTION TEXT//
	//----------------//
	draw_set_font(fnt_gui_medium);
	draw_set_colour(c_black);

	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);

	draw_text(
		(_val_box_x1 + _val_box_x2) * 0.5,
		(_val_box_y1 + _val_box_y2) * 0.5,
		_str_option
	);

	draw_set_halign(fa_left);
	draw_set_valign(fa_top);

	//----------------//
	//MOUSE CLICK//
	//----------------//
	if (_flag_hover && mouse_check_button_pressed(mb_left) && !_flag_clicked && _ct_cooldown <= 0){

		_flag_clicked = true;
		_ct_cooldown = 10;

		_it_option_selected = _it_option;

		hscr_gui_npc_activate_option(_str_option);
	}
};

//-------------------------------------------------------------------------------//
// HSCR_GUI_NPC_DRAW_MENU
// FUNCTION: Determines the hovered NPC option before drawing the menu.
//           Synchronizes mouse hover and keyboard selection.
//
// ARGUMENTS: _val_mouse_x/_val_mouse_y are the GUI mouse coordinates.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
hscr_gui_npc_draw_menu = function(_val_mouse_x,_val_mouse_y){

	_it_option_hovered = -1;

	//----------------//
	//DETERMINE HOVER//
	//----------------//
	for (var _it_option = 0; _it_option < array_length(_arr_options); _it_option++){

		var _val_box_x1 = _val_option_x;
		var _val_box_y1 = _val_option_start_y + (_it_option * (_val_option_h + _val_option_gap));

		var _val_box_x2 = _val_box_x1 + _val_option_w;
		var _val_box_y2 = _val_box_y1 + _val_option_h;

		if (hscr_gui_npc_is_mouse_in_rect(
			_val_mouse_x,
			_val_mouse_y,
			_val_box_x1,
			_val_box_y1,
			_val_box_x2,
			_val_box_y2
		)){
			_it_option_hovered = _it_option;
			_it_option_selected = _it_option;

			break;
		}
	}

	//----------------//
	//DRAW OPTIONS//
	//----------------//
	for (var _it_option = 0; _it_option < array_length(_arr_options); _it_option++){

		hscr_gui_npc_draw_menu_option(
			_arr_options[_it_option],
			_it_option,
			_val_mouse_x,
			_val_mouse_y
		);
	}

	//----------------//
	//NO OPTIONS//
	//----------------//
	if (array_length(_arr_options) <= 0){

		draw_set_font(fnt_gui_small);
		draw_set_colour(c_ltgray);

		draw_text(
			_val_option_x,
			_val_option_start_y,
			"NO INTERACTIONS AVAILABLE"
		);
	}
};

#endregion