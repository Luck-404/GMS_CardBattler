//===============================================================================//
//
// DRAW GUI: OBJ_GUI_LOGBOOK_PANE
// FUNCTION: Draws the logbook GUI shell.
//           Displays beast/card tabs, paged entry rows, and selected details.
//           Handles tab switching, keyboard paging, mouse row selection, and page buttons.
//
//===============================================================================//

//----//
//SETUP//
//----//
draw_set_font(fnt_small_gui);

var _val_mouse_x = device_mouse_x_to_gui(0);
var _val_mouse_y = device_mouse_y_to_gui(0);

hscr_handle_mode_and_page_input();

var _ct_total_pages = hscr_get_total_pages();

if (_ct_logbook_page > _ct_total_pages - 1){
	_ct_logbook_page = _ct_total_pages - 1;
}

if (_ct_logbook_page < 0){
	_ct_logbook_page = 0;
}

//----//
//PANE//
//----//
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

//------//
//HEADER//
//------//
draw_set_font(fnt_medium_gui);
draw_set_colour(c_white);

draw_text(
	_val_pane_left + 24,
	_val_pane_top + 20,
	"LOGBOOK"
);

draw_set_font(fnt_small_gui);

// TABS
if (_str_logbook_mode == "BEAST"){
	draw_set_colour(c_lime);
	draw_text(_val_pane_left + 210,_val_pane_top + 28,"[BEASTS]");

	draw_set_colour(c_white);
	draw_text(_val_pane_left + 310,_val_pane_top + 28,"CARDS");
}
else{
	draw_set_colour(c_white);
	draw_text(_val_pane_left + 210,_val_pane_top + 28,"BEASTS");

	draw_set_colour(c_lime);
	draw_text(_val_pane_left + 310,_val_pane_top + 28,"[CARDS]");
}

// CONTROLS
draw_set_colour(c_ltgray);
draw_text(
	_val_pane_left + 500,
	_val_pane_top + 28,
	"TAB: SWITCH   LEFT/RIGHT: PAGE"
);

//----//
//ROWS//
//----//
for (var _it_slot = 0; _it_slot < _ct_entries_per_page; _it_slot++){

	var _stct_entry = hscr_get_entry_at_slot(_it_slot);

	if (_stct_entry != undefined){
		hscr_draw_entry_row(_stct_entry,_it_slot,_val_mouse_x,_val_mouse_y);
	}
}

//-------------//
//PAGE BUTTONS//
//-------------//
var _val_left_x = _val_page_center_x - _val_arrow_offset;
var _val_right_x = _val_page_center_x + _val_arrow_offset;

var _val_button_w = 36;
var _val_button_h = 28;

var _val_left_button_x1 = _val_left_x - (_val_button_w * 0.5);
var _val_left_button_y1 = _val_page_y - (_val_button_h * 0.5);
var _val_left_button_x2 = _val_left_x + (_val_button_w * 0.5);
var _val_left_button_y2 = _val_page_y + (_val_button_h * 0.5);

var _val_right_button_x1 = _val_right_x - (_val_button_w * 0.5);
var _val_right_button_y1 = _val_page_y - (_val_button_h * 0.5);
var _val_right_button_x2 = _val_right_x + (_val_button_w * 0.5);
var _val_right_button_y2 = _val_page_y + (_val_button_h * 0.5);

// LEFT BUTTON
draw_set_colour(c_black);
draw_rectangle(
	_val_left_button_x1,
	_val_left_button_y1,
	_val_left_button_x2,
	_val_left_button_y2,
	false
);

draw_set_colour(c_white);
draw_text(_val_left_x - 4,_val_page_y - 8,"<");

if (hscr_is_mouse_in_rect(_val_mouse_x,_val_mouse_y,_val_left_button_x1,_val_left_button_y1,_val_left_button_x2,_val_left_button_y2)){

	draw_set_colour(c_lime);
	draw_rectangle(
		_val_left_button_x1,
		_val_left_button_y1,
		_val_left_button_x2,
		_val_left_button_y2,
		true
	);

	if (mouse_check_button_pressed(mb_left) && !_flag_clicked && _ct_logbook_page > 0){
		audio_play_sound(snd_gui_press,0,false);
		_flag_clicked = true;
		_ct_cooldown = 10;

		_ct_logbook_page--;
		_str_entry_selected_id = "";
	}
}

// RIGHT BUTTON
draw_set_colour(c_black);
draw_rectangle(
	_val_right_button_x1,
	_val_right_button_y1,
	_val_right_button_x2,
	_val_right_button_y2,
	false
);

draw_set_colour(c_white);
draw_text(_val_right_x - 4,_val_page_y - 8,">");

if (hscr_is_mouse_in_rect(_val_mouse_x,_val_mouse_y,_val_right_button_x1,_val_right_button_y1,_val_right_button_x2,_val_right_button_y2)){

	draw_set_colour(c_lime);
	draw_rectangle(
		_val_right_button_x1,
		_val_right_button_y1,
		_val_right_button_x2,
		_val_right_button_y2,
		true
	);

	if (mouse_check_button_pressed(mb_left) && !_flag_clicked && _ct_logbook_page < _ct_total_pages - 1){
		audio_play_sound(snd_gui_press,0,false);
		_flag_clicked = true;
		_ct_cooldown = 10;

		_ct_logbook_page++;
		_str_entry_selected_id = "";
	}
}

// PAGE TEXT
draw_set_colour(c_white);
draw_text(
	_val_page_center_x - 35,
	_val_page_y - 8,
	"PAGE " + string(_ct_logbook_page + 1) + "/" + string(_ct_total_pages)
);

//-------//
//DETAILS//
//-------//
draw_set_colour(c_black);
draw_rectangle(
	_val_detail_x - 15,
	_val_start_y - 20,
	_val_pane_left + _val_pane_w - 20,
	_val_pane_top + _val_pane_h - 70,
	true
);

hscr_draw_selected_details();

//--------//
//COOLDOWN//
//--------//
hscr_update_click_cooldown();