//===============================================================================//
//
// DRAW GUI: OBJ_GUI_PARTY_PANE
// FUNCTION: Draws the player's Party and selected Beast data.
//           Handles Beast selection and Party-slot reordering.
//           Logs successful Party reordering.
//
//===============================================================================//

//====================//
//VALIDATE PARTY LIST//
//====================//
if (
	!variable_global_exists("list_player_party") ||
	!ds_exists(global.list_player_party,ds_type_list)
){
	exit;
}

//================//
//DRAW PARTY PANE//
//================//
draw_sprite(spr_gui_party_pane,0,x,y);

_ct_units = ds_list_size(global.list_player_party);

var _val_mouse_x = device_mouse_x_to_gui(0);
var _val_mouse_y = device_mouse_y_to_gui(0);

//================//
//DRAW PARTY ROW//
//================//
for (var _it_unit = 0;_it_unit < _ct_units;_it_unit++){

	var _val_box_x = _val_row_start_x + ((_val_slot_size + _val_spacing) * _it_unit);
	var _val_box_y = _val_row_y;

	var _stct_unit = ds_list_find_value(global.list_player_party,_it_unit);

	if (!is_struct(_stct_unit)){
		continue;
	}

	var _val_unit_x = _val_box_x + (_val_slot_size * 0.5);
	var _val_unit_y = _val_box_y + (_val_slot_size * 0.5);

	//-----------------//
	//SLOT BACKGROUND//
	//-----------------//
	if (_stct_unit._val_beast_hp_cur <= 0){
		draw_set_colour(c_maroon);
	}
	else{
		draw_set_colour(global.c_dk_gray);
	}

	draw_rectangle(
		_val_box_x,
		_val_box_y,
		_val_box_x + _val_slot_size,
		_val_box_y + _val_slot_size,
		false
	);

	draw_set_colour(c_black);

	draw_rectangle(
		_val_box_x,
		_val_box_y,
		_val_box_x + _val_slot_size,
		_val_box_y + _val_slot_size,
		true
	);

	//----------------//
	//DRAW SHADOW//
	//----------------//
	var _spr_shadow = scr_beast_get_type_shadow(_stct_unit._str_beast_color_type);

	if (_spr_shadow != undefined){

		draw_sprite_ext(
			_spr_shadow,
			0,
			_val_unit_x,
			_val_unit_y + 24,
			1,
			1,
			0,
			c_white,
			1
		);
	}

	//----------------//
	//DRAW BEAST//
	//----------------//
	var _c_beast = _stct_unit._val_beast_hp_cur <= 0 ? c_ltgray : c_white;

	draw_sprite_ext(
		_stct_unit._spr_beast,
		0,
		_val_unit_x,
		_val_unit_y,
		0.125,
		0.125,
		0,
		_c_beast,
		1
	);

	//----------------------//
	//DRAW HELD ITEM BADGE//
	//----------------------//
	hscr_gui_party_draw_slot_held_item(
		_stct_unit,
		_val_box_x,
		_val_box_y
	);

	//----------------//
	//DRAW SELECTION//
	//----------------//
	if (_it_unit == _val_pos){
		draw_sprite(spr_gui_party_selected,0,_val_unit_x,_val_unit_y);
	}

	//================//
	//HANDLE HOVER//
	//================//
	var _flag_hover =
		_val_mouse_x > _val_box_x &&
		_val_mouse_x < _val_box_x + _val_slot_size &&
		_val_mouse_y > _val_box_y &&
		_val_mouse_y < _val_box_y + _val_slot_size;

	if (!_flag_hover){
		continue;
	}

	draw_sprite(spr_gui_party_highlight,0,_val_unit_x,_val_unit_y);

	//----------------//
	//SELECT BEAST//
	//----------------//
	if (
		mouse_check_button_pressed(mb_left) &&
		!_flag_clicked
	){

		audio_play_sound(snd_gui_press,0,false);

		_flag_clicked = true;
		_ct_cooldown = 10;

		_val_pos = _it_unit;

		_stct_unit_selected = ds_list_find_value(
			global.list_player_party,
			_val_pos
		);

		if (is_struct(_stct_unit_selected)){
			audio_play_sound(_stct_unit_selected._snd_beast_cry,0,false);
		}
	}

	//====================//
	//NUMBER KEY REORDER//
	//====================//
	for (var _it_key = 1;_it_key <= 5;_it_key++){

		if (!keyboard_check_pressed(ord(string(_it_key)))){
			continue;
		}

		audio_play_sound(snd_gui_press,0,false);

		var _val_target = _it_key - 1;

		if (
			_val_target < _ct_units &&
			_val_target != _it_unit
		){

			var _stct_hover_unit = ds_list_find_value(
				global.list_player_party,
				_it_unit
			);

			var _stct_target_unit = ds_list_find_value(
				global.list_player_party,
				_val_target
			);

			//----------------//
			//SWAP PARTY SLOTS//
			//----------------//
			ds_list_replace(
				global.list_player_party,
				_it_unit,
				_stct_target_unit
			);

			ds_list_replace(
				global.list_player_party,
				_val_target,
				_stct_hover_unit
			);

			//--------------------//
			//REFRESH SELECTION//
			//--------------------//
			if (is_struct(_stct_unit_selected)){

				_stct_unit_selected = ds_list_find_value(
					global.list_player_party,
					_val_pos
				);
			}

			_flag_clicked = true;
			_ct_cooldown = 10;

			//================//
			//DEBUG REORDER//
			//================//
			scr_debug_log(
				"BEASTS",
				"PARTY",
				undefined,
				"PARTY REORDERED" +
				" | BEAST: " +
				string_upper(_stct_hover_unit._str_beast_name) +
				" | POSITION: " +
				string(_it_unit + 1) +
				" -> " +
				string(_val_target + 1) +
				" | SWAPPED WITH: " +
				string_upper(_stct_target_unit._str_beast_name),
				"INFO",
				"OBJ_GUI_PARTY_PANE:DRAW_GUI"
			);

			//--------------------//
			//REFRESH COMPANION//
			//--------------------//
			scr_overworld_spawn_companion_beast();
		}

		break;
	}
}

//================//
//CLICK COOLDOWN//
//================//
if (_flag_clicked){

	if (_ct_cooldown > 0){
		_ct_cooldown--;
	}
	else{

		_ct_cooldown = 0;
		_flag_clicked = false;
	}
}

//====================//
//DRAW SELECTED BEAST//
//====================//
if (is_struct(_stct_unit_selected)){

	var _stct_unit = _stct_unit_selected;

	var _val_x = _val_pane_left + 25;
	var _val_y = _val_row_y + _val_slot_size + 10;

	var _val_lh = 22;
	var _val_sg = 32;

	draw_set_colour(c_black);
	draw_set_font(fnt_gui_small);
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);

	//================//
	//BEAST HEADER//
	//================//
	var _str_color_1 = _stct_unit._arr_beast_colors[0];
	var _str_color_2 = _stct_unit._arr_beast_colors[1];
	var _str_color_type = _stct_unit._str_beast_color_type;

	draw_text(
		_val_x,
		_val_y,
		_stct_unit._str_beast_name +
		" | LV " +
		string(_stct_unit._val_beast_level) +
		" | " +
		string(_stct_unit._val_beast_exp) +
		"/10"
	);

	_val_y += _val_lh;

	draw_text(
		_val_x,
		_val_y,
		_stct_unit._str_beast_archetype +
		" | " +
		_stct_unit._str_beast_class
	);

	_val_y += _val_lh;

	var _str_color_text = string(_str_color_1);

	if (_str_color_2 != undefined){
		_str_color_text += ", " + string(_str_color_2);
	}

	draw_text(
		_val_x,
		_val_y,
		_str_color_text +
		" | " +
		string(_str_color_type)
	);

	_val_y += _val_lh;

	draw_text(
		_val_x,
		_val_y,
		"HP: " +
		string(_stct_unit._val_beast_hp_cur) +
		"/" +
		string(_stct_unit._val_beast_hp_max)
	);

	_val_y += _val_sg;

	//================//
	//CORE STATS//
	//================//
	draw_text(_val_x,_val_y,"=== CORE STATS ===");
	_val_y += _val_lh;

	var _val_hp_stat = _stct_unit._val_beast_hp_stat;
	var _val_con_stat = _stct_unit._val_beast_con_stat;
	var _val_ppow_stat = _stct_unit._val_beast_ppow_stat;
	var _val_mpow_stat = _stct_unit._val_beast_mpow_stat;
	var _val_pdef_stat = _stct_unit._val_beast_pdef_stat;
	var _val_mdef_stat = _stct_unit._val_beast_mdef_stat;

	draw_text(
		_val_x,
		_val_y,
		"HP: " +
		string(_val_hp_stat) +
		" | " +
		scr_beast_get_grade_letter(_val_hp_stat) +
		" | " +
		string(scr_beast_get_grade_modifier(_val_hp_stat))
	);

	_val_y += _val_lh;

	draw_text(
		_val_x,
		_val_y,
		"CON: " +
		string(_val_con_stat) +
		" | " +
		scr_beast_get_grade_letter(_val_con_stat) +
		" | " +
		string(scr_beast_get_grade_modifier(_val_con_stat))
	);

	_val_y += _val_lh;

	draw_text(
		_val_x,
		_val_y,
		"PPOW: " +
		string(_val_ppow_stat) +
		" | " +
		scr_beast_get_grade_letter(_val_ppow_stat) +
		" | " +
		string(scr_beast_get_grade_modifier(_val_ppow_stat))
	);

	_val_y += _val_lh;

	draw_text(
		_val_x,
		_val_y,
		"MPOW: " +
		string(_val_mpow_stat) +
		" | " +
		scr_beast_get_grade_letter(_val_mpow_stat) +
		" | " +
		string(scr_beast_get_grade_modifier(_val_mpow_stat))
	);

	_val_y += _val_lh;

	draw_text(
		_val_x,
		_val_y,
		"PDEF: " +
		string(_val_pdef_stat) +
		" | " +
		scr_beast_get_grade_letter(_val_pdef_stat) +
		" | " +
		string(scr_beast_get_grade_modifier(_val_pdef_stat))
	);

	_val_y += _val_lh;

	draw_text(
		_val_x,
		_val_y,
		"MDEF: " +
		string(_val_mdef_stat) +
		" | " +
		scr_beast_get_grade_letter(_val_mdef_stat) +
		" | " +
		string(scr_beast_get_grade_modifier(_val_mdef_stat))
	);

	_val_y += _val_sg;

	//==================//
	//SECONDARY STATS//
	//==================//
	var _val_crit_dmg = 25;

	if (variable_struct_exists(_stct_unit,"_val_beast_crit_dmg_stat")){
		_val_crit_dmg = _stct_unit._val_beast_crit_dmg_stat;
	}

	draw_text(
		_val_x,
		_val_y,
		"CRIT CHANCE: " +
		string(_stct_unit._val_beast_crit_stat) +
		"%"
	);

	_val_y += _val_lh;

	draw_text(
		_val_x,
		_val_y,
		"CRIT DAMAGE: +" +
		string(_val_crit_dmg) +
		"%"
	);

	_val_y += _val_lh;

	draw_text(
		_val_x,
		_val_y,
		"DODGE: " +
		string(_stct_unit._val_beast_dod_stat) +
		"%"
	);

	_val_y += _val_lh;

	draw_text(
		_val_x,
		_val_y,
		"SPEED: " +
		string(_stct_unit._val_beast_speed_stat)
	);

	_val_y += _val_lh;

	draw_text(
		_val_x,
		_val_y,
		"MINION COUNT: " +
		string(_stct_unit._val_beast_min_stat)
	);

	_val_y += _val_sg;

	//================//
	//HELD ITEM//
	//================//
	_val_y = hscr_gui_party_draw_selected_held_item(
		_stct_unit,
		_val_x,
		_val_y
	);

	_val_y += 8;

	//================//
	//ABILITY//
	//================//
	draw_text(
		_val_x,
		_val_y,
		"ABILITY: " +
		string(_stct_unit._str_beast_ability)
	);

	_val_y += _val_sg;

	//================//
	//LORE//
	//================//
	draw_text(_val_x,_val_y,"=== LORE ===");
	_val_y += _val_lh;

	draw_text_ext(
		_val_x,
		_val_y,
		_stct_unit._str_beast_lore,
		-1,
		740
	);

	_val_y += _val_sg * 4.5;

	draw_text_ext(
		_val_x,
		_val_y,
		_stct_unit._str_beast_role,
		-1,
		740
	);
}