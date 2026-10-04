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
// FUNCTION: Draws the Beast's Held Item entirely inside the bottom-right corner
//           of its Party portrait pane.
//
// ARGUMENTS: _stct_unit is the displayed Beast.
//            _val_box_x/_val_box_y are the Party pane coordinates.
// RETURNS: Nothing.
//-------------------------------------------------------------------------------//
function hscr_gui_party_draw_slot_held_item(_stct_unit,_val_box_x,_val_box_y){

	//================//
	//VALIDATE ITEM//
	//================//
	if (!hscr_gui_party_has_held_item(_stct_unit)){
		return;
	}

	var _stct_held_item =
		_stct_unit._stct_beast_held_item;

	//================//
	//DRAW ITEM//
	//================//
	scr_gui_draw_item_badge(
		_stct_held_item._spr_item,
		_val_box_x +
			_val_slot_size -
			4,
		_val_box_y +
			_val_slot_size -
			4,
		26
	);
}

//-------------------------------------------------------------------------------//
// HSCR_GUI_PARTY_DRAW_SELECTED_HELD_ITEM
// FUNCTION: Draws held-item information directly on the Party pane.
//           Does not create a secondary inset pane.
//           Right-clicking the Item area unequips the Item.
//
// ARGUMENTS: _stct_unit is the selected Beast.
//            _val_x/_val_y define the starting GUI position.
// RETURNS: Next vertical drawing position.
//-------------------------------------------------------------------------------//
function hscr_gui_party_draw_selected_held_item(_stct_unit,_val_x,_val_y){

	//================//
	//HEADER//
	//================//
	draw_set_colour(c_black);
	draw_set_font(fnt_gui_small);

	draw_text(
		_val_x,
		_val_y,
		"=== HELD ITEM ==="
	);

	_val_y += 22;

	//================//
	//EMPTY//
	//================//
	if (!hscr_gui_party_has_held_item(_stct_unit)){

		draw_text(
			_val_x,
			_val_y,
			"EMPTY"
		);

		return _val_y + 32;
	}

	var _stct_held_item =
		_stct_unit._stct_beast_held_item;

	//================//
	//INTERACTION AREA//
	//================//
	var _val_item_x1 =
		_val_x;

	var _val_item_y1 =
		_val_y;

	var _val_item_x2 =
		_val_item_x1 +
		300;

	var _val_item_y2 =
		_val_item_y1 +
		42;

	var _val_mouse_x =
		device_mouse_x_to_gui(0);

	var _val_mouse_y =
		device_mouse_y_to_gui(0);

	var _flag_hover =
		_val_mouse_x >= _val_item_x1 &&
		_val_mouse_x <= _val_item_x2 &&
		_val_mouse_y >= _val_item_y1 &&
		_val_mouse_y <= _val_item_y2;

	//================//
	//ITEM BADGE//
	//================//
	scr_gui_draw_item_badge(
		_stct_held_item._spr_item,
		_val_x + 36,
		_val_y + 36,
		36
	);

	//================//
	//ITEM NAME//
	//================//
	draw_set_colour(c_black);
	draw_set_font(fnt_gui_small);

	draw_text(
		_val_x + 48,
		_val_y + 2,
		_stct_held_item._str_item_name
	);

	//================//
	//UNEQUIP HINT//
	//================//
	draw_set_colour(
		_flag_hover
		? c_black
		: global.c_dk_gray
	);

	draw_set_font(fnt_gui_party_small);

	draw_text(
		_val_x + 48,
		_val_y + 22,
		"RIGHT CLICK: UNEQUIP"
	);

	//================//
	//HANDLE UNEQUIP//
	//================//
	if (
		_flag_hover &&
		mouse_check_button_pressed(mb_right) &&
		!_flag_clicked
	){

		_flag_clicked =
			true;

		_ct_cooldown =
			10;

		scr_inventory_unequip_held_item(
			_stct_unit,
			_val_x + 150,
			_val_y
		);
	}

	//================//
	//RESET//
	//================//
	draw_set_font(fnt_gui_small);
	draw_set_colour(c_black);

	return _val_y + 56;
}