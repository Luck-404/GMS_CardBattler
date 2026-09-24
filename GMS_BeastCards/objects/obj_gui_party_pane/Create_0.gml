//===============================================================================//
//
// CREATE: OBJ_GUI_PARTY_PANE
// FUNCTION: Initializes the Party GUI pane.
//           Stores Party selection, layout, navigation references, and local
//           helpers used to display Beast and held-item information.
//
//===============================================================================//

//================//
//DRAW SETTINGS//
//================//
depth = -1;

//================//
//PARTY STATE//
//================//
_val_pos = 0;

_ct_units = ds_list_size(global.list_player_party);
_stct_unit_selected = ds_list_find_value(global.list_player_party,_val_pos);

_str_type = "PARTY";

//================//
//PANE LAYOUT//
//================//
_val_pane_w = 800;
_val_pane_h = 800;

_val_pane_left = x - (_val_pane_w * 0.5);
_val_pane_top = y - (_val_pane_h * 0.5);

_val_slot_size = 100;
_val_spacing = 15;
_val_padding_y = 15;

_val_total_width = (_ct_units * _val_slot_size) + ((_ct_units - 1) * _val_spacing);
_val_row_start_x = x - (_val_total_width * 0.5);
_val_row_y = _val_pane_top + _val_padding_y;

_val_arrow_offset = 60;

//================//
//INPUT STATE//
//================//
_flag_clicked = false;
_ct_cooldown = 10;

//====================//
//CREATE NAVIGATION//
//====================//
_ref_left_arrow = instance_create_layer(
	_val_row_start_x - _val_arrow_offset,
	_val_row_y + (_val_slot_size * 0.5),
	"ily_fx",
	obj_gui_party_left_arrow
);

_ref_left_arrow._ref_gui_pane = self;

_ref_right_arrow = instance_create_layer(
	_val_row_start_x + _val_total_width + _val_arrow_offset,
	_val_row_y + (_val_slot_size * 0.5),
	"ily_fx",
	obj_gui_party_right_arrow
);

_ref_right_arrow._ref_gui_pane = self;

//================//
//LOCAL HELPERS//
//================//

//-------------------------------------------------------------------------------//
// HSCR_GUI_PARTY_HAS_HELD_ITEM
// FUNCTION: Returns whether a Beast currently has a valid held-item struct.
//
// ARGUMENTS: _stct_unit is the Beast struct being checked.
// RETURNS: True if the Beast has a held item struct; otherwise false.
//-------------------------------------------------------------------------------//
function hscr_gui_party_has_held_item(_stct_unit){

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
// HSCR_GUI_PARTY_DRAW_SLOT_HELD_ITEM
// FUNCTION: Draws the held-item badge displayed inside a Party slot.
//
// ARGUMENTS: _stct_unit is the Beast being displayed, while _val_box_x and
//            _val_box_y are the Party-slot coordinates.
// RETURNS: Nothing.
//-------------------------------------------------------------------------------//
function hscr_gui_party_draw_slot_held_item(_stct_unit,_val_box_x,_val_box_y){

	if (!hscr_gui_party_has_held_item(_stct_unit)){
		return;
	}

	var _stct_held_item = _stct_unit._stct_beast_held_item;
	var _val_badge_x = _val_box_x + _val_slot_size - 18;
	var _val_badge_y = _val_box_y + _val_slot_size - 18;

	draw_set_colour(c_black);
	draw_circle(_val_badge_x,_val_badge_y,15,false);

	draw_set_colour(c_white);
	draw_circle(_val_badge_x,_val_badge_y,12,false);

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

//-------------------------------------------------------------------------------//
// HSCR_GUI_PARTY_DRAW_SELECTED_HELD_ITEM
// FUNCTION: Draws held-item information for the selected Beast.
//           Right-clicking the held-item box unequips the item.
//
// ARGUMENTS: _stct_unit is the selected Beast, while _val_x and _val_y define
//            the starting GUI position.
// RETURNS: The next vertical drawing position after the held-item section.
//-------------------------------------------------------------------------------//
function hscr_gui_party_draw_selected_held_item(_stct_unit,_val_x,_val_y){

	draw_text(_val_x,_val_y,"=== HELD ITEM ===");
	_val_y += 22;

	if (!hscr_gui_party_has_held_item(_stct_unit)){
		draw_text(_val_x,_val_y,"EMPTY");
		return _val_y + 32;
	}

	var _stct_held_item = _stct_unit._stct_beast_held_item;

	var _val_box_w = 430;
	var _val_box_h = 74;

	var _val_box_x1 = _val_x;
	var _val_box_y1 = _val_y;
	var _val_box_x2 = _val_box_x1 + _val_box_w;
	var _val_box_y2 = _val_box_y1 + _val_box_h;

	var _val_mouse_x = device_mouse_x_to_gui(0);
	var _val_mouse_y = device_mouse_y_to_gui(0);

	var _flag_hover =
		_val_mouse_x > _val_box_x1 &&
		_val_mouse_x < _val_box_x2 &&
		_val_mouse_y > _val_box_y1 &&
		_val_mouse_y < _val_box_y2;

	//----------------//
	//DRAW ITEM BOX//
	//----------------//
	draw_set_colour(_flag_hover ? c_white : global.c_dk_gray);
	draw_rectangle(_val_box_x1,_val_box_y1,_val_box_x2,_val_box_y2,false);

	draw_set_colour(c_black);
	draw_rectangle(_val_box_x1 + 3,_val_box_y1 + 3,_val_box_x2 - 3,_val_box_y2 - 3,false);

	//----------------//
	//DRAW ITEM DATA//
	//----------------//
	draw_sprite_ext(
		_stct_held_item._spr_item,
		0,
		_val_box_x1 + 34,
		_val_box_y1 + 36,
		1.5,
		1.5,
		0,
		c_white,
		1
	);

	draw_set_colour(c_white);
	draw_text(_val_box_x1 + 70,_val_box_y1 + 10,_stct_held_item._str_item_name);

	draw_set_font(fnt_gui_small);
	draw_set_colour(c_ltgray);
	draw_text(_val_box_x1 + 70,_val_box_y1 + 36,"RIGHT CLICK: UNEQUIP");

	//----------------//
	//HANDLE UNEQUIP//
	//----------------//
	if (_flag_hover && mouse_check_button_pressed(mb_right) && !_flag_clicked){

		_flag_clicked = true;
		_ct_cooldown = 10;

		scr_inventory_unequip_held_item(
			_stct_unit,
			_val_box_x1 + (_val_box_w * 0.5),
			_val_box_y1
		);
	}

	draw_set_font(fnt_gui_small);
	draw_set_colour(c_black);

	return _val_y + _val_box_h + 24;
}