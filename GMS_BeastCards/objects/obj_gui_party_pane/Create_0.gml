//===============================================================================//
//
// CREATE: OBJ_GUI_PARTY_PANE
// FUNCTION: Initializes the party GUI pane.
//           Stores party selection, layout, and navigation arrow references.
//           Displays beast structs from the player party.
//
//===============================================================================//

//---------//
//VARIABLES//
//---------//
depth = -1;

_val_pos = 0;

_ct_unit = ds_list_size(global.list_player_party);
_stct_unit_selected = ds_list_find_value(global.list_player_party,_val_pos);

_str_type = "PARTY";

_val_pane_w = 800;
_val_pane_h = 800;
_val_pane_left = x - (_val_pane_w * 0.5);
_val_pane_top = y - (_val_pane_h * 0.5);

_val_slot_size = 100;
_val_spacing = 15;
_val_padding_y = 15;

_val_total_width = (_ct_unit * _val_slot_size) + ((_ct_unit - 1) * _val_spacing);
_val_row_start_x = x - (_val_total_width * 0.5);
_val_row_y = _val_pane_top + _val_padding_y;

_val_arrow_offset = 60;

_flag_clicked = false;
_val_cooldown = 10;

//----//
//INIT//
//----//
_ref_left_arrow = instance_create_layer(_val_row_start_x - _val_arrow_offset,_val_row_y + (_val_slot_size * 0.5),"ily_fx",obj_gui_party_left_arrow);
_ref_left_arrow._ref_gui_pane = self;

_ref_right_arrow = instance_create_layer(_val_row_start_x + _val_total_width + _val_arrow_offset,_val_row_y + (_val_slot_size * 0.5),"ily_fx",obj_gui_party_right_arrow);
_ref_right_arrow._ref_gui_pane = self;

//-------//
//METHODS//
//-------//
#region METHODS

//—------------------------------------------------------------------------------//
// hscr_has_held_item
// FUNCTION: Returns whether a beast currently has a held item struct.
//—------------------------------------------------------------------------------//
function hscr_has_held_item(_stct_unit){

	if (_stct_unit == undefined){
		return false;
	}

	if (_stct_unit._ref_beast_held_item == undefined){
		return false;
	}

	if (_stct_unit._ref_beast_held_item == "EMPTY"){
		return false;
	}

	return true;
}

//—------------------------------------------------------------------------------//
// hscr_draw_party_slot_held_item
// FUNCTION: Draws a small held item badge in a party slot.
//           Used for quick party overview.
//
//—------------------------------------------------------------------------------//
function hscr_draw_party_slot_held_item(_stct_unit,_val_box_x,_val_box_y){

	if (!hscr_has_held_item(_stct_unit)){
		return;
	}

	var _stct_held_item = _stct_unit._ref_beast_held_item;

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

//—------------------------------------------------------------------------------//
// hscr_draw_selected_held_item
// FUNCTION: Draws the selected beast's held item data.
//           Right-clicking the held item box unequips the item.
//
//—------------------------------------------------------------------------------//
function hscr_draw_selected_held_item(_stct_unit,_val_x,_val_y){

	draw_text(_val_x,_val_y,"=== HELD ITEM ===");
	_val_y += 22;

	var _stct_held_item = _stct_unit._ref_beast_held_item;

	if (!hscr_has_held_item(_stct_unit)){
		draw_text(_val_x,_val_y,"EMPTY");
		return _val_y + 32;
	}

	var _val_box_w = 430;
	var _val_box_h = 74;

	var _val_box_x1 = _val_x;
	var _val_box_y1 = _val_y;
	var _val_box_x2 = _val_box_x1 + _val_box_w;
	var _val_box_y2 = _val_box_y1 + _val_box_h;

	var _val_mouse_x = device_mouse_x_to_gui(0);
	var _val_mouse_y = device_mouse_y_to_gui(0);

	var _flag_hover = _val_mouse_x > _val_box_x1 && _val_mouse_x < _val_box_x2 && _val_mouse_y > _val_box_y1 && _val_mouse_y < _val_box_y2;

	draw_set_colour(_flag_hover ? c_white : c_gray);
	draw_rectangle(_val_box_x1,_val_box_y1,_val_box_x2,_val_box_y2,false);

	draw_set_colour(c_black);
	draw_rectangle(_val_box_x1 + 3,_val_box_y1 + 3,_val_box_x2 - 3,_val_box_y2 - 3,false);

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

	draw_set_font(fnt_small_gui);
	draw_set_colour(c_ltgray);
	draw_text(_val_box_x1 + 70,_val_box_y1 + 36,"RIGHT CLICK: UNEQUIP");

	if (_flag_hover && mouse_check_button_pressed(mb_right) && !_flag_clicked){

		_flag_clicked = true;
		_val_cooldown = 10;

		scr_unequip_held_item_to_inventory(
			_stct_unit,
			_val_box_x1 + (_val_box_w * 0.5),
			_val_box_y1
		);
	}

	draw_set_font(fnt_small_gui);
	draw_set_colour(c_black);

	return _val_y + _val_box_h + 24;
}

#endregion