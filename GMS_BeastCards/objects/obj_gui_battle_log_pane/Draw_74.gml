//===============================================================================//
//
// DRAW GUI BEGIN: OBJ_GUI_BATTLE_LOG_PANE
// FUNCTION: Draws the expandable battle-action log in the upper-right corner.
//           Displays four combat events per page and the page counter at the
//           bottom-left of the pane.
//           Hovering a visible entry registers its full untruncated message as
//           the shared mouse-cursor tooltip.
//
//===============================================================================//

#region DRAW STATE

//================//
//RESET STATE//
//================//
draw_set_alpha(1);
draw_set_font(fnt_gui_party_small);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

#endregion

#region LAYOUT

//================//
//GUI SIZE//
//================//
var _val_gui_width = display_get_gui_width();

var _val_pane_height =
	_val_header_height +
	(_ct_entries_per_page * _val_entry_height) +
	_val_footer_height;

var _val_pane_x2 = _val_gui_width;
var _val_pane_x1 = _val_pane_x2 - _val_pane_width;

var _val_pane_y1 = _val_pane_top;
var _val_pane_y2 = _val_pane_y1 + _val_pane_height;

//================//
//TAB POSITION//
//================//
var _val_tab_x1;
var _val_tab_x2;

if (_flag_log_visible){

	_val_tab_x1 =
		_val_pane_x1 -
		_val_tab_width;

	_val_tab_x2 =
		_val_pane_x1;
}
else{

	_val_tab_x1 =
		_val_gui_width -
		_val_tab_width;

	_val_tab_x2 =
		_val_gui_width;
}

var _val_tab_y1 = _val_pane_y1;
var _val_tab_y2 = _val_tab_y1 + _val_tab_height;

#endregion

#region TAB

//================//
//TAB BACKGROUND//
//================//
draw_set_colour(global.c_dk_gray);

draw_rectangle(
	_val_tab_x1,
	_val_tab_y1,
	_val_tab_x2,
	_val_tab_y2,
	false
);

//================//
//TAB OUTLINE//
//================//
draw_set_colour(c_black);

draw_rectangle(
	_val_tab_x1,
	_val_tab_y1,
	_val_tab_x2,
	_val_tab_y2,
	true
);

//================//
//TAB ARROW//
//================//
draw_set_colour(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_text(
	(_val_tab_x1 + _val_tab_x2) * 0.5,
	(_val_tab_y1 + _val_tab_y2) * 0.5,
	_flag_log_visible ? ">" : "<"
);

#endregion

#region HIDDEN STATE

if (!_flag_log_visible){

	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_colour(c_white);

	exit;
}

#endregion

#region PANE

//================//
//BACKGROUND//
//================//
draw_set_colour(global.c_dk_gray);

draw_rectangle(
	_val_pane_x1,
	_val_pane_y1,
	_val_pane_x2,
	_val_pane_y2,
	false
);

//================//
//OUTLINE//
//================//
draw_set_colour(c_black);

draw_rectangle(
	_val_pane_x1,
	_val_pane_y1,
	_val_pane_x2,
	_val_pane_y2,
	true
);

#endregion

#region HEADER

//================//
//TITLE//
//================//
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_colour(c_white);

draw_text(
	_val_pane_x1 + _val_padding,
	_val_pane_y1 + 7,
	"BATTLE LOG"
);

//================//
//TOGGLE HINT//
//================//
draw_set_halign(fa_right);
draw_set_colour(c_ltgray);

draw_text(
	_val_pane_x2 - _val_padding,
	_val_pane_y1 + 7,
	"L: HIDE"
);

//================//
//HEADER DIVIDER//
//================//
draw_set_colour(c_black);

draw_line(
	_val_pane_x1,
	_val_pane_y1 + _val_header_height,
	_val_pane_x2,
	_val_pane_y1 + _val_header_height
);

#endregion

#region ENTRIES

//================//
//PAGE RANGE//
//================//
var _ct_entries = array_length(_arr_log_entries);

var _it_start =
	_it_log_page *
	_ct_entries_per_page;

var _it_end = min(
	_ct_entries,
	_it_start + _ct_entries_per_page
);

var _val_text_width =
	_val_pane_width -
	(_val_padding * 2);

//================//
//MOUSE//
//================//
var _val_mouse_x =
	device_mouse_x_to_gui(0);

var _val_mouse_y =
	device_mouse_y_to_gui(0);

//================//
//DRAW ENTRIES//
//================//
draw_set_font(fnt_gui_party_small);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_colour(c_white);

for (
	var _it_entry = _it_start;
	_it_entry < _it_end;
	_it_entry++
){

	var _it_draw_entry =
		_it_entry -
		_it_start;

	var _val_entry_y =
		_val_pane_y1 +
		_val_header_height +
		4 +
		(_it_draw_entry * _val_entry_height);

	//================//
	//ENTRY HOVER//
	//================//
	var _val_entry_row_y1 =
		_val_pane_y1 +
		_val_header_height +
		(_it_draw_entry * _val_entry_height);

	var _val_entry_row_y2 =
		_val_entry_row_y1 +
		_val_entry_height;

	if (
		_flag_log_visible &&
		point_in_rectangle(
			_val_mouse_x,
			_val_mouse_y,
			_val_pane_x1,
			_val_entry_row_y1,
			_val_pane_x2,
			_val_entry_row_y2
		)
	){

		scr_gui_set_hover_tooltip(
			"BATTLE LOG ENTRY",
			_arr_log_entries[_it_entry],
			100
		);
	}

	//================//
	//WRAP ENTRY//
	//================//
	var _arr_lines =
		hscr_gui_battle_log_wrap_text(
			_arr_log_entries[_it_entry],
			_val_text_width
		);

	//================//
	//DRAW ENTRY LINES//
	//================//
	for (
		var _it_line = 0;
		_it_line < array_length(_arr_lines);
		_it_line++
	){

		draw_text(
			_val_pane_x1 + _val_padding,
			_val_entry_y +
				(_it_line * _val_entry_line_height),
			_arr_lines[_it_line]
		);
	}

	//================//
	//ENTRY DIVIDER//
	//================//
	if (_it_draw_entry < _ct_entries_per_page - 1){

		draw_set_colour(c_black);

		draw_line(
			_val_pane_x1 + 4,
			_val_entry_y + _val_entry_height - 3,
			_val_pane_x2 - 4,
			_val_entry_y + _val_entry_height - 3
		);

		draw_set_colour(c_white);
	}
}

#endregion

#region FOOTER

//================//
//FOOTER DIVIDER//
//================//
var _val_footer_y =
	_val_pane_y2 -
	_val_footer_height;

draw_set_colour(c_black);

draw_line(
	_val_pane_x1,
	_val_footer_y,
	_val_pane_x2,
	_val_footer_y
);

//================//
//PAGE NUMBER//
//================//
var _ct_pages =
	hscr_gui_battle_log_get_page_count();

_it_log_page = clamp(
	_it_log_page,
	0,
	_ct_pages - 1
);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_colour(c_ltgray);

draw_text(
	_val_pane_x1 + _val_padding,
	_val_footer_y + 6,
	"PAGE " +
	string(_it_log_page + 1) +
	"/" +
	string(_ct_pages)
);

//================//
//SCROLL HINT//
//================//
draw_set_halign(fa_right);

draw_text(
	_val_pane_x2 - _val_padding,
	_val_footer_y + 6,
	"SCROLL: PAGE"
);

#endregion

#region RESET DRAW STATE

draw_set_alpha(1);
draw_set_colour(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

#endregion
