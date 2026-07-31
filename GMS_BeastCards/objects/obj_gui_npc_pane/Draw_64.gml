//===============================================================================//
//
// DRAW GUI: OBJ_GUI_NPC_PANE
// FUNCTION: Draws and manages the active NPC interaction pane.
//           Displays NPC identity, available menu options, and placeholder modes.
//           Handles keyboard navigation, mouse interaction, and pane closing.
//
//===============================================================================//

//----------------//
// VALIDATE DATA
//----------------//
if (
	!instance_exists(_ref_npc) ||
	_stct_npc == undefined
){
	hscr_close_npc_pane();
	exit;
}

//----------------//
// SETUP
//----------------//
var _val_mouse_x = device_mouse_x_to_gui(0);
var _val_mouse_y = device_mouse_y_to_gui(0);

hscr_update_click_cooldown();

//----------------//
// CLOSE / RETURN
//----------------//
if (
	keyboard_check_pressed(vk_escape) &&
	_ct_cooldown <= 0
){

	if (_str_npc_gui_mode == "MENU"){
		hscr_close_npc_pane();
		exit;
	}
	else{
		_str_npc_gui_mode = "MENU";
		_ct_cooldown = 10;
		_flag_clicked = true;
	}
}

//----------------//
// PANE
//----------------//
draw_set_colour(c_black);

draw_rectangle(
	_val_pane_left,
	_val_pane_top,
	_val_pane_left + _val_pane_w,
	_val_pane_top + _val_pane_h,
	false
);

draw_set_colour(c_dkgray);

draw_rectangle(
	_val_pane_left + 4,
	_val_pane_top + 4,
	_val_pane_left + _val_pane_w - 4,
	_val_pane_top + _val_pane_h - 4,
	false
);

//----------------//
// NPC HEADER
//----------------//
draw_set_font(fnt_medium_gui);
draw_set_colour(c_white);

draw_text(
	_val_header_x,
	_val_header_y,
	string(_stct_npc._str_npc_name)
);

draw_set_font(fnt_small_gui);
draw_set_colour(c_ltgray);

draw_text(
	_val_header_x,
	_val_header_y + 34,
	string(_stct_npc._str_npc_title)
);

//----------------//
// HEADER DIVIDER
//----------------//
draw_set_colour(c_black);

draw_line(
	_val_pane_left + 20,
	_val_pane_top + 100,
	_val_pane_left + _val_pane_w - 20,
	_val_pane_top + 100
);

//----------------//
// ACTIVE MODE
//----------------//
switch(_str_npc_gui_mode){

	case "MENU":

		hscr_handle_menu_keyboard_input();

		hscr_draw_menu(
			_val_mouse_x,
			_val_mouse_y
		);

	break;


	case "DIALOGUE":

		hscr_update_dialogue();
		hscr_handle_dialogue_input();
		hscr_draw_dialogue();

	break;
}

//----------------//
// FOOTER
//----------------//
if (_str_npc_gui_mode == "MENU"){

	draw_set_font(fnt_small_gui);
	draw_set_colour(c_ltgray);

	draw_text(
		_val_pane_left + 24,
		_val_pane_top + _val_pane_h - 34,
		"UP/DOWN: SELECT   E/ENTER: CONFIRM   ESC: CLOSE"
	);
}