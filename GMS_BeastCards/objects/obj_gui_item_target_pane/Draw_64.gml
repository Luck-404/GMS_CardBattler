//===============================================================================//
//
// DRAW GUI: OBJ_GUI_ITEM_TARGET_PANE
// FUNCTION: Draws item target selection pane.
//           Shows party members on the left.
//           Shows selected item sprite, name, amount, and close hint on the right.
//
//===============================================================================//

draw_set_font(fnt_medium_gui);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

//------//
//LAYOUT//
//------//
var _val_mouse_x = device_mouse_x_to_gui(0);
var _val_mouse_y = device_mouse_y_to_gui(0);

var _val_pane_right = _val_pane_left + _val_pane_w;
var _val_pane_bottom = _val_pane_top + _val_pane_h;

//----//
//PANE//
//----//
draw_set_colour(c_black);
draw_rectangle(_val_pane_left,_val_pane_top,_val_pane_right,_val_pane_bottom,false);

draw_set_colour(c_dkgray);
draw_rectangle(_val_pane_left + 4,_val_pane_top + 4,_val_pane_right - 4,_val_pane_bottom - 4,false);

//-------//
//HEADERS//
//-------//
draw_set_colour(c_white);
var _str_header = "CHOOSE TARGET";

if (_str_target_mode == "HELD"){
	_str_header = "CHOOSE HOLDER";
}

draw_text(_val_left_x,_val_pane_top + 24,_str_header);
draw_text(_val_right_x,_val_pane_top + 24,"ITEM");

//-------//
//TARGETS//
//-------//
var _ct_party = ds_list_size(global.list_player_party);

for (var _it_unit = 0; _it_unit < _ct_party; _it_unit++){

	var _stct_unit = ds_list_find_value(global.list_player_party,_it_unit);

	if (_stct_unit == undefined){
		continue;
	}

	var _val_box_x = _val_left_x;
	var _val_box_y = _val_start_y + (_it_unit * (_val_slot_h + _val_slot_spacing));

	var _flag_hover = _val_mouse_x > _val_box_x && _val_mouse_x < _val_box_x + _val_slot_w && _val_mouse_y > _val_box_y && _val_mouse_y < _val_box_y + _val_slot_h;

	draw_set_colour(_flag_hover ? c_white : c_gray);
	draw_rectangle(_val_box_x,_val_box_y,_val_box_x + _val_slot_w,_val_box_y + _val_slot_h,false);

	draw_set_colour(c_black);
	draw_rectangle(_val_box_x,_val_box_y,_val_box_x + _val_slot_w,_val_box_y + _val_slot_h,true);

	var _val_unit_x = _val_box_x + 36;
	var _val_unit_y = _val_box_y + (_val_slot_h * 0.5);

	var _spr_shadow = scr_get_beast_type_shadow(_stct_unit._str_beast_color_type);

	if (_spr_shadow != undefined){
		draw_sprite_ext(_spr_shadow,0,_val_unit_x,_val_unit_y + 14,0.55,0.55,0,c_white,1);
	}

	draw_sprite_ext(_stct_unit._spr_beast,0,_val_unit_x,_val_unit_y,0.075,0.075,0,c_white,1);

	draw_set_colour(c_black);
	draw_text(_val_box_x + 76,_val_box_y + 12,_stct_unit._str_beast_name);

	var _str_hp = "HP: " + string(_stct_unit._val_beast_hp_cur) + "/" + string(_stct_unit._val_beast_hp_max);
	draw_text(_val_box_x + 76,_val_box_y + 38,_str_hp);
}

//----//
//ITEM//
//----//
if (_stct_item != undefined){

	var _ct_amount = hscr_get_current_item_amount();

	draw_sprite_ext(_stct_item._spr_item,0,_val_right_x + 72,_val_pane_top + 130,3,3,0,c_white,1);

	draw_set_colour(c_white);
	draw_text(_val_right_x,_val_pane_top + 220,_stct_item._str_item_name);

	draw_set_font(fnt_small_gui);
	draw_set_colour(c_ltgray);

	var _str_amount = "AMOUNT: " + string(_ct_amount);

	if (_stct_item._flag_stackable){
		_str_amount = "AMOUNT: " + string(_ct_amount);
	}
	else{
		_str_amount = "AMOUNT: 1";
	}

	draw_text(_val_right_x,_val_pane_top + 250,_str_amount);
	draw_text_ext(_val_right_x,_val_pane_top + 280,_stct_item._str_item_desc,16,220);

	draw_set_colour(c_white);
	draw_text(_val_right_x,_val_pane_bottom - 44,"RIGHT CLICK: CLOSE");
}

//-------//
//RESET//
//-------//
draw_set_halign(fa_left);
draw_set_valign(fa_top);