//===============================================================================//
//
// CREATE: OBJ_GUI_RANCH_PANE
// FUNCTION: Initializes the Party/Ranch management GUI pane.
//           Stores Party and Ranch layout, pagination, navigation references,
//           and local helpers used to display Beast held items.
//
//===============================================================================//

//================//
//DRAW SETTINGS//
//================//
depth = -1;

//================//
//UNIT COUNTS//
//================//
_ct_party_units = 0;
_ct_ranch_units = 0;

if (
	variable_global_exists("list_player_party") &&
	ds_exists(global.list_player_party,ds_type_list)
){
	_ct_party_units = ds_list_size(global.list_player_party);
}

if (
	variable_global_exists("list_player_ranch") &&
	ds_exists(global.list_player_ranch,ds_type_list)
){
	_ct_ranch_units = ds_list_size(global.list_player_ranch);
}

_str_type = "RANCH";

//================//
//PANE LAYOUT//
//================//
_val_pane_w = 800;
_val_pane_h = 800;

_val_pane_left = x - (_val_pane_w * 0.5);
_val_pane_top = y - (_val_pane_h * 0.5);

//================//
//SLOT LAYOUT//
//================//
_val_slot_h = 130;
_val_slot_margin = 15;
_val_slot_w = 370;

_val_party_x = _val_pane_left + 15;
_val_ranch_x = x + 15;
_val_start_y = _val_pane_top + 15;

//====================//
//RANCH PAGE SETTINGS//
//====================//
_val_ranch_page = 0;
_ct_ranch_units_per_page = 5;

_val_page_y = _val_pane_top + _val_pane_h - 50;
_val_page_center_x = _val_ranch_x + (_val_slot_w * 0.5);
_val_arrow_offset = 80;

//================//
//INPUT STATE//
//================//
_flag_clicked = false;
_ct_cooldown = 10;

//====================//
//CREATE NAVIGATION//
//====================//
_ref_left_arrow = instance_create_layer(
	_val_page_center_x - _val_arrow_offset,
	_val_page_y,
	"ily_fx",
	obj_gui_ranch_left_arrow
);

_ref_left_arrow._ref_gui_pane = self;

_ref_right_arrow = instance_create_layer(
	_val_page_center_x + _val_arrow_offset,
	_val_page_y,
	"ily_fx",
	obj_gui_ranch_right_arrow
);

_ref_right_arrow._ref_gui_pane = self;

//================//
//LOCAL HELPERS//
//================//

//-------------------------------------------------------------------------------//
// HSCR_GUI_RANCH_HAS_HELD_ITEM
// FUNCTION: Returns whether a Beast currently has a valid held-item struct.
//
// ARGUMENTS: _stct_unit is the Beast struct being checked.
// RETURNS: True if the Beast has a held-item struct; otherwise false.
//-------------------------------------------------------------------------------//
function hscr_gui_ranch_has_held_item(_stct_unit){

	if (!is_struct(_stct_unit)){
		return false;
	}

	if (!variable_struct_exists(_stct_unit,"_stct_beast_held_item")){
		return false;
	}

	if (!is_struct(_stct_unit._stct_beast_held_item)){
		return false;
	}

	return true;
}

//-------------------------------------------------------------------------------//
// HSCR_GUI_RANCH_DRAW_HELD_ITEM_BADGE
// FUNCTION: Draws a held-item badge inside a Ranch Beast frame.
//           Display-only; does not allow item changes.
//
// ARGUMENTS: _stct_unit is the Beast being displayed, while _val_box_x and
//            _val_box_y are the frame coordinates.
// RETURNS: Nothing.
//-------------------------------------------------------------------------------//
function hscr_gui_ranch_draw_held_item_badge(_stct_unit,_val_box_x,_val_box_y){

	if (!hscr_gui_ranch_has_held_item(_stct_unit)){
		return;
	}

	var _stct_held_item = _stct_unit._stct_beast_held_item;

	var _val_badge_x = _val_box_x + 96;
	var _val_badge_y = _val_box_y + 96;
	var _val_badge_size = 26;
	var _val_badge_half = _val_badge_size * 0.5;

	//----------------//
	//DRAW BADGE BOX//
	//----------------//
	draw_set_colour(c_black);

	draw_rectangle(
		_val_badge_x - _val_badge_half,
		_val_badge_y - _val_badge_half,
		_val_badge_x + _val_badge_half,
		_val_badge_y + _val_badge_half,
		false
	);

	draw_set_colour(c_white);

	draw_rectangle(
		_val_badge_x - _val_badge_half,
		_val_badge_y - _val_badge_half,
		_val_badge_x + _val_badge_half,
		_val_badge_y + _val_badge_half,
		true
	);

	//----------------//
	//DRAW ITEM ICON//
	//----------------//
	draw_sprite_ext(
		_stct_held_item._spr_item,
		0,
		_val_badge_x,
		_val_badge_y,
		1,
		1,
		0,
		c_white,
		1
	);
}