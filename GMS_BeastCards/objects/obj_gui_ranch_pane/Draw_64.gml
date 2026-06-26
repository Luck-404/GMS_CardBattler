//===============================================================================//
//
// DRAW GUI: OBJ_GUI_RANCH_PANE
// FUNCTION: Draws party and ranch beast slots.
//           Handles moving beasts between party and ranch.
//           Handles ranch deletion, pagination, and click cooldown.
//
//===============================================================================//

draw_self();

_ct_party = ds_list_size(global.list_player_party);
_ct_ranch = ds_list_size(global.list_player_ranch);

var _val_mouse_x = device_mouse_x_to_gui(0);
var _val_mouse_y = device_mouse_y_to_gui(0);

//
// SIGNS
//
#region SIGNS
draw_set_font(fnt_medium_gui);
draw_set_colour(c_white);

draw_text(_val_pane_left + 100,_val_pane_top - 25,"PARTY");
draw_text(_val_pane_left + 615,_val_pane_top - 25,"RANCH");

draw_set_font(fnt_small_gui);
#endregion

//
// PARTY SIDE
//
#region PARTY DRAW AND MOVING TO RANCH
for (var _it_unit = 0; _it_unit < 5; _it_unit++){

	var _stct_unit = ds_list_find_value(global.list_player_party,_it_unit);

	var _val_box_x = _val_party_x;
	var _val_box_y = _val_start_y + (_it_unit * (_val_slot_h + _val_slot_margin));

	draw_set_colour(c_black);
	draw_rectangle(_val_box_x,_val_box_y,_val_box_x + _val_slot_w,_val_box_y + _val_slot_h,false);

	draw_set_colour(c_gray);
	draw_rectangle(_val_box_x + 4,_val_box_y + 4,_val_box_x + _val_slot_w - 4,_val_box_y + _val_slot_h - 4,false);

	if (_stct_unit != undefined){

		if (_stct_unit._val_beast_hp_cur <= 0){
			draw_set_colour(c_maroon);
		}
		else{
			draw_set_colour(c_aqua);
		}

		draw_rectangle(_val_box_x + 10,_val_box_y + 10,_val_box_x + 110,_val_box_y + 110,false);

		var _val_unit_x = _val_box_x + 60;
		var _val_unit_y = _val_box_y + 60;

		var _spr_shadow = scr_get_beast_type_shadow(_stct_unit._str_beast_color_type);

		draw_sprite_ext(_spr_shadow,0,_val_unit_x,_val_unit_y + 20,1,1,0,c_white,1);
		draw_sprite_ext(_stct_unit._spr_beast,0,_val_unit_x,_val_unit_y,0.125,0.125,0,c_white,1);

		draw_set_colour(c_black);

		draw_text(_val_box_x + 125,_val_box_y + 20,_stct_unit._str_beast_name);
		draw_text(_val_box_x + 125,_val_box_y + 45,"LV " + string(_stct_unit._val_beast_level));
		draw_text(_val_box_x + 125,_val_box_y + 70,string(_stct_unit._val_beast_hp_cur) + "/" + string(_stct_unit._val_beast_hp_max));

		if (_val_mouse_x > _val_box_x && _val_mouse_x < _val_box_x + _val_slot_w && _val_mouse_y > _val_box_y && _val_mouse_y < _val_box_y + _val_slot_h && ds_list_size(global.list_player_party) > 1){

			draw_sprite(spr_gui_ranch_highlight,0,_val_party_x + 185,_val_box_y + 65);

			if (mouse_check_button_pressed(mb_left) && !_flag_clicked){
				_flag_clicked = true;
				_val_cooldown = 10;

				ds_list_add(global.list_player_ranch,_stct_unit);
				ds_list_delete(global.list_player_party,_it_unit);

				obj_ranch_interactable.hscr_spawn_ranch_unit(_stct_unit);

				_ct_party = ds_list_size(global.list_player_party);
				_ct_ranch = ds_list_size(global.list_player_ranch);
			}

			for (var _it_key = 1; _it_key <= 5; _it_key++){
				if (keyboard_check_pressed(ord(string(_it_key)))){
					var _val_target = _it_key - 1;

					if (_val_target < ds_list_size(global.list_player_party) && _val_target != _it_unit){
						var _stct_hover_unit = ds_list_find_value(global.list_player_party,_it_unit);
						var _stct_target_unit = ds_list_find_value(global.list_player_party,_val_target);

						ds_list_replace(global.list_player_party,_it_unit,_stct_target_unit);
						ds_list_replace(global.list_player_party,_val_target,_stct_hover_unit);

						_ct_party = ds_list_size(global.list_player_party);

						_flag_clicked = true;
						_val_cooldown = 10;
					}

					break;
				}
			}
		}
	}
}
#endregion

//
// RANCH SIDE
//
#region RANCH DRAW, MOVING TO PARTY, DELETING
var _val_start_index = _val_ranch_page * _ct_ranch_per_page;

for (var _it_unit = 0; _it_unit < _ct_ranch_per_page; _it_unit++){

	var _val_ranch_index = _val_start_index + _it_unit;

	var _val_box_x = _val_ranch_x;
	var _val_box_y = _val_start_y + (_it_unit * (_val_slot_h + _val_slot_margin));

	draw_set_colour(c_black);
	draw_rectangle(_val_box_x,_val_box_y,_val_box_x + _val_slot_w,_val_box_y + _val_slot_h,false);

	draw_set_colour(c_gray);
	draw_rectangle(_val_box_x + 4,_val_box_y + 4,_val_box_x + _val_slot_w - 4,_val_box_y + _val_slot_h - 4,false);

	if (_val_ranch_index < ds_list_size(global.list_player_ranch)){

		var _stct_unit = ds_list_find_value(global.list_player_ranch,_val_ranch_index);

		if (_stct_unit == undefined){
			continue;
		}

		if (_stct_unit._val_beast_hp_cur <= 0){
			draw_set_colour(c_maroon);
		}
		else{
			draw_set_colour(c_aqua);
		}

		draw_rectangle(_val_box_x + 10,_val_box_y + 10,_val_box_x + 110,_val_box_y + 110,false);

		var _val_unit_x = _val_box_x + 60;
		var _val_unit_y = _val_box_y + 60;

		var _spr_shadow = scr_get_beast_type_shadow(_stct_unit._str_beast_color_type);

		draw_sprite_ext(_spr_shadow,0,_val_unit_x,_val_unit_y + 20,1,1,0,c_white,1);
		draw_sprite_ext(_stct_unit._spr_beast,0,_val_unit_x,_val_unit_y,0.125,0.125,0,c_white,1);

		draw_set_colour(c_black);

		draw_text(_val_box_x + 125,_val_box_y + 20,_stct_unit._str_beast_name);
		draw_text(_val_box_x + 125,_val_box_y + 45,"LV " + string(_stct_unit._val_beast_level));
		draw_text(_val_box_x + 125,_val_box_y + 70,string(_stct_unit._val_beast_hp_cur) + "/" + string(_stct_unit._val_beast_hp_max));

		if (_val_mouse_x > _val_box_x && _val_mouse_x < _val_box_x + _val_slot_w && _val_mouse_y > _val_box_y && _val_mouse_y < _val_box_y + _val_slot_h && ds_list_size(global.list_player_party) < 5){

			draw_sprite(spr_gui_ranch_highlight,0,_val_ranch_x + 185,_val_box_y + 65);

			if (mouse_check_button_pressed(mb_left) && !_flag_clicked){
				_flag_clicked = true;
				_val_cooldown = 10;

				ds_list_add(global.list_player_party,_stct_unit);
				ds_list_delete(global.list_player_ranch,_val_ranch_index);

				obj_ranch_interactable.hscr_destroy_ranch_unit(_stct_unit.beast_uid);

				_ct_party = ds_list_size(global.list_player_party);
				_ct_ranch = ds_list_size(global.list_player_ranch);
			}
		}

		if (keyboard_check_pressed(vk_delete) && !_flag_clicked){
			_flag_clicked = true;
			_val_cooldown = 10;

			ds_list_delete(global.list_player_ranch,_val_ranch_index);
			obj_ranch_interactable.hscr_destroy_ranch_unit(_stct_unit.beast_uid);

			_ct_party = ds_list_size(global.list_player_party);
			_ct_ranch = ds_list_size(global.list_player_ranch);
		}
	}
}
#endregion

//
// PAGE DISPLAY
//
#region PAGE DISPLAY
var _ct_total_pages = max(1,ceil(_ct_ranch / _ct_ranch_per_page));

draw_set_colour(c_black);
draw_set_halign(fa_center);

draw_text(_val_page_center_x,_val_page_y - 8,"PAGE " + string(_val_ranch_page + 1) + "/" + string(_ct_total_pages));

draw_set_halign(fa_left);
#endregion

//
// CLICK COOLDOWN
//
#region CLICK COOLDOWN
if (_flag_clicked){
	if (_val_cooldown > 0){
		_val_cooldown--;
	}
	else{
		_val_cooldown = 0;
		_flag_clicked = false;
	}
}
#endregion