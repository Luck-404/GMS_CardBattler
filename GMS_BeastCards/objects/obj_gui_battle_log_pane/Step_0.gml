//===============================================================================//
//
// STEP: OBJ_GUI_BATTLE_LOG_PANE
// FUNCTION: Handles battle-log lifetime, L-key visibility toggle,
//           left-side tab input, and hover-only mouse-wheel paging.
//
//===============================================================================//

#region LIFETIME

//================//
//LEAVE BATTLE//
//================//
if (room != rm_battle){
	instance_destroy();
	exit;
}

//================//
//BATTLE FINISHED//
//================//
if (
	instance_exists(obj_battle_turn_controller) &&
	variable_instance_exists(obj_battle_turn_controller,"_flag_battle_ended") &&
	obj_battle_turn_controller._flag_battle_ended
){
	instance_destroy();
	exit;
}

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

#region TOGGLE INPUT

//================//
//L KEY//
//================//
if (keyboard_check_pressed(ord("L"))){

	hscr_gui_battle_log_toggle();

	exit;
}

//================//
//TAB CLICK//
//================//
var _val_mouse_x = device_mouse_x_to_gui(0);
var _val_mouse_y = device_mouse_y_to_gui(0);

if (
	mouse_check_button_pressed(mb_left) &&
	point_in_rectangle(
		_val_mouse_x,
		_val_mouse_y,
		_val_tab_x1,
		_val_tab_y1,
		_val_tab_x2,
		_val_tab_y2
	)
){

	hscr_gui_battle_log_toggle();

	exit;
}

#endregion

#region PAGE INPUT

//================//
//VISIBLE ONLY//
//================//
if (!_flag_log_visible){
	exit;
}

//================//
//HOVER PANE//
//================//
var _flag_hover_pane =
	point_in_rectangle(
		_val_mouse_x,
		_val_mouse_y,
		_val_pane_x1,
		_val_pane_y1,
		_val_pane_x2,
		_val_pane_y2
	);

if (!_flag_hover_pane){
	exit;
}

//================//
//PAGE LIMITS//
//================//
var _it_max_page =
	hscr_gui_battle_log_get_max_page();

//================//
//OLDER PAGE//
//================//
if (mouse_wheel_up()){

	_it_log_page = max(
		0,
		_it_log_page - 1
	);

	exit;
}

//================//
//NEWER PAGE//
//================//
if (mouse_wheel_down()){

	_it_log_page = min(
		_it_max_page,
		_it_log_page + 1
	);

	exit;
}

#endregion