//===============================================================================//
//
// CREATE: OBJ_GUI_NPC_PANE
// FUNCTION: Initializes the NPC interaction GUI.
//           Stores NPC references, menu options, layout, and dialogue state.
//           Defines menu navigation, dialogue scrolling, and closing helpers.
//
//===============================================================================//

//---------//
//VARIABLES//
//---------//
#region VARIABLES

	//-----------//
	// REFERENCES
	//-----------//
	_ref_npc = undefined;
	_stct_npc = undefined;
	
	_flag_transfer_to_market = false;
	
	//----------//
	// GUI STATE
	//----------//
	_str_npc_gui_mode = "MENU";

	_arr_options = [];

	_it_option_selected = 0;
	_it_option_hovered = -1;

	//----------//
	// DIALOGUE
	//----------//
	_arr_dialogue = [];

	_it_dialogue_line = 0;

	_str_dialogue_full = "";
	_str_dialogue_visible = "";

	_ct_dialogue_char = 0;
	_ct_dialogue_tick = 0;

	_val_dialogue_speed = 2;
	_val_dialogue_tick_max = 1;

	_flag_dialogue_line_complete = false;
	_flag_dialogue_finished = false;

	//------------//
	// PANE LAYOUT
	//------------//
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

	//------//
	// INPUT
	//------//
	_flag_clicked = false;
	_ct_cooldown = 10;

	//--------//
	// DISPLAY
	//--------//
	depth = -10000;

#endregion

//----//
//INIT//
//----//
#region INIT

	global.ref_active_gui = self;

#endregion

//-------//
//METHODS//
//-------//
#region METHODS
//—------------------------------------------------------------------------------//
// hscr_open_trade
// FUNCTION: Closes the NPC menu pane and opens the generic market pane.
//           Passes NPC stock, UID, and NPC instance into the market system.
//—------------------------------------------------------------------------------//
hscr_open_trade = function(){

	if (_ref_npc == undefined){
		return;
	}

	if (!instance_exists(_ref_npc)){
		return;
	}

	if (_stct_npc == undefined){
		return;
	}

	if (!_stct_npc._flag_can_trade){
		return;
	}

	if (
		!is_array(
			_stct_npc._arr_trade_stock
		) ||
		array_length(
			_stct_npc._arr_trade_stock
		) <= 0
	){
		audio_play_sound(
			snd_error,
			0,
			false
		);

		scr_spawn_popup_error(
			"NOTHING FOR SALE",
			60
		);

		return;
	}

	//--------------------//
	// CREATE MARKET GUI  //
	//--------------------//
	var _ref_market_gui =
		instance_create_layer(
			x,
			y,
			"ily_fx",
			obj_gui_market_pane
		);

	_ref_market_gui._str_market_type =
		"NPC";

	_ref_market_gui._str_market_uid =
		"NPC_VENDOR_" +
		string(_ref_npc._uid_npc);

	_ref_market_gui._ref_market_owner =
		_ref_npc;

	_ref_market_gui._ref_npc =
		_ref_npc;

	_ref_market_gui._arr_external_stock =
		_stct_npc._arr_trade_stock;

	_ref_market_gui._flag_return_to_npc =
		true;

	_ref_market_gui.hscr_market_init();

	global.ref_active_gui = _ref_market_gui;

	/*
		The interaction is being transferred to the market pane.
		The NPC pane Cleanup event must not close the interaction.
	*/

	show_debug_message(
		"NPC TRADE TRANSFER | UID: " +
		string(_ref_npc._uid_npc) +
		" | NPC REF: " +
		string(_ref_npc) +
		" | MARKET NPC REF: " +
		string(_ref_market_gui._ref_npc)
	);

	_flag_transfer_to_market = true;

	instance_destroy();
};

//—------------------------------------------------------------------------------//
// hscr_npc_init
// FUNCTION: Initializes the NPC pane after receiving an NPC reference.
//           Retrieves NPC data and builds the available interaction options.
//—------------------------------------------------------------------------------//
hscr_npc_init = function(){

	if (!instance_exists(_ref_npc)){

		show_debug_message(
			"NPC GUI ERROR: INVALID NPC REFERENCE"
		);

		instance_destroy();
		return;
	}

	_stct_npc = _ref_npc._stct_npc;

	if (_stct_npc == undefined){

		show_debug_message(
			"NPC GUI ERROR: NPC STRUCT IS UNDEFINED"
		);

		instance_destroy();
		return;
	}

	hscr_build_option_array();

	if (array_length(_arr_options) > 0){
		_it_option_selected = 0;
	}
	else{
		_it_option_selected = -1;
	}
};


//—------------------------------------------------------------------------------//
// hscr_build_option_array
// FUNCTION: Builds the NPC interaction menu from enabled interaction flags.
//           Only includes interactions supported by the active NPC.
//—------------------------------------------------------------------------------//
hscr_build_option_array = function(){

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


//—------------------------------------------------------------------------------//
// hscr_is_mouse_in_rect
// FUNCTION: Returns whether the GUI mouse is inside a supplied rectangle.
//—------------------------------------------------------------------------------//
hscr_is_mouse_in_rect = function(
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


//—------------------------------------------------------------------------------//
// hscr_update_click_cooldown
// FUNCTION: Updates the GUI click cooldown.
//           Prevents one input from triggering multiple GUI actions.
//—------------------------------------------------------------------------------//
hscr_update_click_cooldown = function(){

	if (_ct_cooldown > 0){
		_ct_cooldown--;
	}

	if (_ct_cooldown <= 0){
		_ct_cooldown = 0;
		_flag_clicked = false;
	}
};


//—------------------------------------------------------------------------------//
// hscr_select_previous_option
// FUNCTION: Moves selection to the previous NPC interaction option.
//           Wraps to the final option when moving above the first.
//—------------------------------------------------------------------------------//
hscr_select_previous_option = function(){

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


//—------------------------------------------------------------------------------//
// hscr_select_next_option
// FUNCTION: Moves selection to the next NPC interaction option.
//           Wraps to the first option when moving beyond the final option.
//—------------------------------------------------------------------------------//
hscr_select_next_option = function(){

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


//—------------------------------------------------------------------------------//
// hscr_start_dialogue
// FUNCTION: Starts the active NPC's stored dialogue.
//           Resets dialogue progress and loads the first dialogue line.
//—------------------------------------------------------------------------------//
hscr_start_dialogue = function(){

	if (_stct_npc == undefined){
		return;
	}

	_arr_dialogue = _stct_npc._arr_npc_dialogue;

	if (!is_array(_arr_dialogue)){
		_arr_dialogue = [];
	}

	if (array_length(_arr_dialogue) <= 0){

		_arr_dialogue = [
			"..."
		];
	}

	_str_npc_gui_mode = "DIALOGUE";

	_it_dialogue_line = 0;

	_flag_dialogue_finished = false;

	hscr_load_dialogue_line();
};


//—------------------------------------------------------------------------------//
// hscr_load_dialogue_line
// FUNCTION: Loads the current dialogue line.
//           Resets visible text and character-scrolling progress.
//—------------------------------------------------------------------------------//
hscr_load_dialogue_line = function(){

	if (
		_it_dialogue_line < 0 ||
		_it_dialogue_line >= array_length(_arr_dialogue)
	){
		hscr_finish_dialogue();
		return;
	}

	_str_dialogue_full = string(
		_arr_dialogue[_it_dialogue_line]
	);

	_str_dialogue_visible = "";

	_ct_dialogue_char = 0;
	_ct_dialogue_tick = 0;

	_flag_dialogue_line_complete = false;
};


//—------------------------------------------------------------------------------//
// hscr_update_dialogue
// FUNCTION: Reveals the current dialogue line one character at a time.
//           Marks the line complete once the full text is visible.
//—------------------------------------------------------------------------------//
hscr_update_dialogue = function(){

	if (_str_npc_gui_mode != "DIALOGUE"){
		return;
	}

	if (_flag_dialogue_line_complete){
		return;
	}

	_ct_dialogue_tick++;

	if (_ct_dialogue_tick < _val_dialogue_tick_max){
		return;
	}

	_ct_dialogue_tick = 0;

	_ct_dialogue_char += _val_dialogue_speed;

	_ct_dialogue_char = min(
		_ct_dialogue_char,
		string_length(_str_dialogue_full)
	);

	_str_dialogue_visible = string_copy(
		_str_dialogue_full,
		1,
		_ct_dialogue_char
	);

	if (_ct_dialogue_char >= string_length(_str_dialogue_full)){

		_str_dialogue_visible = _str_dialogue_full;
		_flag_dialogue_line_complete = true;
	}
};


//—------------------------------------------------------------------------------//
// hscr_complete_dialogue_line
// FUNCTION: Immediately reveals the full current dialogue line.
//           Used when the player advances while text is still scrolling.
//—------------------------------------------------------------------------------//
hscr_complete_dialogue_line = function(){

	_ct_dialogue_char = string_length(
		_str_dialogue_full
	);

	_str_dialogue_visible = _str_dialogue_full;

	_flag_dialogue_line_complete = true;
};


//—------------------------------------------------------------------------------//
// hscr_advance_dialogue
// FUNCTION: Completes the current scrolling line or advances to the next line.
//           Finishes dialogue after the final stored line.
//—------------------------------------------------------------------------------//
hscr_advance_dialogue = function(){

	if (_str_npc_gui_mode != "DIALOGUE"){
		return;
	}

	if (!_flag_dialogue_line_complete){

		hscr_complete_dialogue_line();

		return;
	}

	_it_dialogue_line++;

	if (_it_dialogue_line >= array_length(_arr_dialogue)){

		hscr_finish_dialogue();

		return;
	}

	hscr_load_dialogue_line();
};


//—------------------------------------------------------------------------------//
// hscr_finish_dialogue
// FUNCTION: Ends the current conversation and returns to the NPC menu.
//           Resets temporary dialogue state for the next conversation.
//—------------------------------------------------------------------------------//
hscr_finish_dialogue = function(){

	_flag_dialogue_finished = true;

	_str_npc_gui_mode = "MENU";

	_arr_dialogue = [];

	_it_dialogue_line = 0;

	_str_dialogue_full = "";
	_str_dialogue_visible = "";

	_ct_dialogue_char = 0;
	_ct_dialogue_tick = 0;

	_flag_dialogue_line_complete = false;

	_flag_clicked = true;
	_ct_cooldown = 10;
};


//—------------------------------------------------------------------------------//
// hscr_handle_dialogue_input
// FUNCTION: Handles player input while dialogue is active.
//           Allows mouse, E, Enter, or Space to complete or advance dialogue.
//—------------------------------------------------------------------------------//
hscr_handle_dialogue_input = function(){

	if (_str_npc_gui_mode != "DIALOGUE"){
		return;
	}

	if (_ct_cooldown > 0){
		return;
	}

	var _flag_advance = (
		mouse_check_button_pressed(mb_left) ||
		keyboard_check_pressed(ord("E")) ||
		keyboard_check_pressed(vk_enter) ||
		keyboard_check_pressed(vk_space)
	);

	if (_flag_advance){

		_flag_clicked = true;
		_ct_cooldown = 6;

		hscr_advance_dialogue();
	}
};


//—------------------------------------------------------------------------------//
// hscr_draw_dialogue
// FUNCTION: Draws the active NPC dialogue line.
//           Displays an advance indicator when the line is fully visible.
//—------------------------------------------------------------------------------//
hscr_draw_dialogue = function(){

	draw_set_font(fnt_small_gui);
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


//—------------------------------------------------------------------------------//
// hscr_activate_option
// FUNCTION: Activates the selected NPC interaction option.
//           Routes the pane into dialogue, quest, trade, or fight behavior.
//—------------------------------------------------------------------------------//
hscr_activate_option = function(_str_option){

	if (_str_option == undefined){
		return;
	}

	audio_play_sound(snd_gui_press,0,false);

	switch(_str_option){

		case "TALK":

			hscr_start_dialogue();

		break;

		case "QUEST":

			show_debug_message(
				"NPC GUI: QUEST NOT IMPLEMENTED | NPC: " +
				string(_stct_npc._str_npc_name)
			);

		break;

		case "TRADE":

			hscr_open_trade();

		break;

		case "FIGHT":

			show_debug_message(
				"NPC GUI: FIGHT NOT IMPLEMENTED | NPC: " +
				string(_stct_npc._str_npc_name)
			);

		break;
	}
};


//—------------------------------------------------------------------------------//
// hscr_handle_menu_keyboard_input
// FUNCTION: Handles keyboard navigation and selection while in menu mode.
//—------------------------------------------------------------------------------//
hscr_handle_menu_keyboard_input = function(){

	if (_str_npc_gui_mode != "MENU"){
		return;
	}

	if (_ct_cooldown > 0){
		return;
	}

	if (keyboard_check_pressed(vk_up)){
		hscr_select_previous_option();
	}

	if (keyboard_check_pressed(vk_down)){
		hscr_select_next_option();
	}

	if (
		keyboard_check_pressed(vk_enter) ||
		keyboard_check_pressed(ord("E"))
	){
		if (
			_it_option_selected >= 0 &&
			_it_option_selected < array_length(_arr_options)
		){
			hscr_activate_option(
				_arr_options[_it_option_selected]
			);

			_flag_clicked = true;
			_ct_cooldown = 10;
		}
	}
};


//—------------------------------------------------------------------------------//
// hscr_close_npc_pane
// FUNCTION: Closes the NPC interaction pane.
//           Unpauses gameplay, resumes NPC movement, and clears references.
//—------------------------------------------------------------------------------//
hscr_close_npc_pane = function(){

	if (instance_exists(_ref_npc)){

		if (
			variable_instance_exists(
				_ref_npc,
				"hscr_close_npc_interaction"
			)
		){
			_ref_npc.hscr_close_npc_interaction();
		}
		else{

			_ref_npc._flag_triggered = false;

			if (
				_ref_npc._str_path_type == "PATH" &&
				_ref_npc.path_index != -1
			){
				_ref_npc.path_speed = _ref_npc._val_move_speed;
			}
		}
	}

	global.flag_pause = false;

	if (
		variable_global_exists("ref_interacting_npc") &&
		global.ref_interacting_npc == _ref_npc
	){
		global.ref_interacting_npc = undefined;
	}

	if (
		variable_global_exists("ref_active_gui") &&
		global.ref_active_gui == self
	){
		global.ref_active_gui = undefined;
	}

	instance_destroy();
};


//—------------------------------------------------------------------------------//
// hscr_draw_menu_option
// FUNCTION: Draws one NPC interaction option.
//           Displays mouse hover and keyboard selection consistently.
//           Activates the exact option clicked by the player.
//—------------------------------------------------------------------------------//
hscr_draw_menu_option = function(
	_str_option,
	_it_option,
	_val_mouse_x,
	_val_mouse_y
){

	var _val_box_x1 = _val_option_x;

	var _val_box_y1 =
		_val_option_start_y +
		(_it_option * (_val_option_h + _val_option_gap));

	var _val_box_x2 = _val_box_x1 + _val_option_w;
	var _val_box_y2 = _val_box_y1 + _val_option_h;

	var _flag_hover = (
		_it_option_hovered == _it_option
	);

	var _flag_selected = (
		_it_option_selected == _it_option
	);

	//----------//
	// OUTER BOX
	//----------//
	draw_set_colour(c_black);

	draw_rectangle(
		_val_box_x1,
		_val_box_y1,
		_val_box_x2,
		_val_box_y2,
		false
	);

	//----------//
	// INNER BOX
	//----------//
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

	//-------------//
	// OPTION TEXT
	//-------------//
	draw_set_font(fnt_medium_gui);
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

	//-------------//
	// MOUSE CLICK
	//-------------//
	if (
		_flag_hover &&
		mouse_check_button_pressed(mb_left) &&
		!_flag_clicked &&
		_ct_cooldown <= 0
	){

		_flag_clicked = true;
		_ct_cooldown = 10;

		_it_option_selected = _it_option;

		hscr_activate_option(_str_option);
	}
};


//—------------------------------------------------------------------------------//
// hscr_draw_menu
// FUNCTION: Determines the hovered NPC option before drawing the menu.
//           Synchronizes mouse hover and keyboard selection.
//           Draws all available NPC interaction options.
//—------------------------------------------------------------------------------//
hscr_draw_menu = function(
	_val_mouse_x,
	_val_mouse_y
){

	_it_option_hovered = -1;

	//—------------------------------------------------------------------------------//
	// DETERMINE HOVERED OPTION BEFORE DRAWING
	//—------------------------------------------------------------------------------//
	for (
		var _it_option = 0;
		_it_option < array_length(_arr_options);
		_it_option++
	){

		var _val_box_x1 = _val_option_x;

		var _val_box_y1 =
			_val_option_start_y +
			(_it_option * (_val_option_h + _val_option_gap));

		var _val_box_x2 = _val_box_x1 + _val_option_w;
		var _val_box_y2 = _val_box_y1 + _val_option_h;

		if (
			hscr_is_mouse_in_rect(
				_val_mouse_x,
				_val_mouse_y,
				_val_box_x1,
				_val_box_y1,
				_val_box_x2,
				_val_box_y2
			)
		){
			_it_option_hovered = _it_option;
			_it_option_selected = _it_option;

			break;
		}
	}

	//—------------------------------------------------------------------------------//
	// DRAW OPTIONS
	//—------------------------------------------------------------------------------//
	for (
		var _it_option = 0;
		_it_option < array_length(_arr_options);
		_it_option++
	){

		hscr_draw_menu_option(
			_arr_options[_it_option],
			_it_option,
			_val_mouse_x,
			_val_mouse_y
		);
	}

	//—------------------------------------------------------------------------------//
	// NO OPTIONS
	//—------------------------------------------------------------------------------//
	if (array_length(_arr_options) <= 0){

		draw_set_font(fnt_small_gui);
		draw_set_colour(c_ltgray);

		draw_text(
			_val_option_x,
			_val_option_start_y,
			"NO INTERACTIONS AVAILABLE"
		);
	}
};

#endregion