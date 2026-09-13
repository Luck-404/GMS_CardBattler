//===============================================================================//
//
// DRAW GUI: OBJ_GUI_RANCH_PANE
// FUNCTION: Draws Party and Ranch Beast slots.
//           Handles moving Beasts between Party and Ranch.
//           Handles Party reordering, Ranch deletion, pagination, and cooldown.
//           Logs all successful roster mutations.
//
//===============================================================================//

//====================//
//VALIDATE DATA LISTS//
//====================//
if (
	!variable_global_exists("list_player_party") ||
	!ds_exists(global.list_player_party,ds_type_list) ||
	!variable_global_exists("list_player_ranch") ||
	!ds_exists(global.list_player_ranch,ds_type_list)
){
	exit;
}

//================//
//DRAW GUI PANE//
//================//
draw_self();

_ct_party_units = ds_list_size(global.list_player_party);
_ct_ranch_units = ds_list_size(global.list_player_ranch);

var _val_mouse_x = device_mouse_x_to_gui(0);
var _val_mouse_y = device_mouse_y_to_gui(0);

//================//
//DRAW HEADERS//
//================//
draw_set_font(fnt_gui_medium);
draw_set_colour(c_white);

draw_text(_val_pane_left + 100,_val_pane_top - 25,"PARTY");
draw_text(_val_pane_left + 615,_val_pane_top - 25,"RANCH");

draw_set_font(fnt_gui_small);

//================//
//DRAW PARTY SIDE//
//================//
for (var _it_unit = 0;_it_unit < 5;_it_unit++){

	var _val_box_x = _val_party_x;
	var _val_box_y = _val_start_y + (_it_unit * (_val_slot_h + _val_slot_margin));

	//----------------//
	//DRAW SLOT FRAME//
	//----------------//
	draw_set_colour(c_black);

	draw_rectangle(
		_val_box_x,
		_val_box_y,
		_val_box_x + _val_slot_w,
		_val_box_y + _val_slot_h,
		false
	);

	draw_set_colour(global.c_dk_gray);

	draw_rectangle(
		_val_box_x + 4,
		_val_box_y + 4,
		_val_box_x + _val_slot_w - 4,
		_val_box_y + _val_slot_h - 4,
		false
	);

	if (_it_unit >= _ct_party_units){
		continue;
	}

	var _stct_unit = ds_list_find_value(
		global.list_player_party,
		_it_unit
	);

	if (!is_struct(_stct_unit)){
		continue;
	}

	//----------------//
	//DRAW BEAST BOX//
	//----------------//
	var _c_beast_box = _stct_unit._val_beast_hp_cur <= 0 ? c_maroon : c_aqua;

	draw_set_colour(_c_beast_box);

	draw_rectangle(
		_val_box_x + 10,
		_val_box_y + 10,
		_val_box_x + 110,
		_val_box_y + 110,
		false
	);

	var _val_unit_x = _val_box_x + 60;
	var _val_unit_y = _val_box_y + 60;

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
	hscr_gui_ranch_draw_held_item_badge(
		_stct_unit,
		_val_box_x,
		_val_box_y
	);

	//----------------//
	//DRAW BEAST DATA//
	//----------------//
	draw_set_colour(c_black);

	draw_text(
		_val_box_x + 125,
		_val_box_y + 20,
		_stct_unit._str_beast_name
	);

	draw_text(
		_val_box_x + 125,
		_val_box_y + 45,
		"LV " + string(_stct_unit._val_beast_level)
	);

	draw_text(
		_val_box_x + 125,
		_val_box_y + 70,
		string(_stct_unit._val_beast_hp_cur) +
		"/" +
		string(_stct_unit._val_beast_hp_max)
	);

	//================//
	//HANDLE HOVER//
	//================//
	var _flag_hover =
		_val_mouse_x > _val_box_x &&
		_val_mouse_x < _val_box_x + _val_slot_w &&
		_val_mouse_y > _val_box_y &&
		_val_mouse_y < _val_box_y + _val_slot_h;

	if (!_flag_hover){
		continue;
	}

	if (_ct_party_units > 1){
		draw_sprite(spr_gui_ranch_highlight,0,_val_party_x + 185,_val_box_y + 65);
	}

	//====================//
	//MOVE BEAST TO RANCH//
	//====================//
	if (
		_ct_party_units > 1 &&
		mouse_check_button_pressed(mb_left) &&
		!_flag_clicked
	){

		audio_play_sound(snd_beast_transfer,0,false);

		_flag_clicked = true;
		_ct_cooldown = 10;

		//----------------//
		//MOVE BEAST//
		//----------------//
		ds_list_add(
			global.list_player_ranch,
			_stct_unit
		);

		ds_list_delete(
			global.list_player_party,
			_it_unit
		);

		//================//
		//DEBUG TRANSFER//
		//================//
		scr_debug_log(
			"BEASTS",
			"RANCH",
			undefined,
			string_upper(_stct_unit._str_beast_name) +
			" MOVED FROM PARTY TO RANCH" +
			" | LEVEL: " +
			string(_stct_unit._val_beast_level) +
			" | UID: " +
			string(_stct_unit._uid_beast) +
			" | PARTY: " +
			string(ds_list_size(global.list_player_party)) +
			"/5" +
			" | RANCH: " +
			string(ds_list_size(global.list_player_ranch)),
			"INFO",
			"OBJ_GUI_RANCH_PANE"
		);

		//------------------//
		//SPAWN RANCH DUMMY//
		//------------------//
		if (instance_exists(obj_ranch_interactable)){
			obj_ranch_interactable.hscr_ranch_spawn_beast_dummy(_stct_unit);
		}

		_ct_party_units = ds_list_size(global.list_player_party);
		_ct_ranch_units = ds_list_size(global.list_player_ranch);

		//================//
		//DEBUG TRANSFER//
		//================//
		scr_debug_log(
			"BEASTS",
			"RANCH",
			undefined,
			string_upper(_stct_unit._str_beast_name) +
			" MOVED FROM PARTY TO RANCH" +
			" | LEVEL: " +
			string(_stct_unit._val_beast_level) +
			" | UID: " +
			string(_stct_unit._uid_beast) +
			" | PARTY: " +
			string(_ct_party_units) +
			"/5" +
			" | RANCH: " +
			string(_ct_ranch_units),
			"INFO",
			"OBJ_GUI_RANCH_PANE:DRAW_GUI"
		);

		//--------------------//
		//REFRESH COMPANION//
		//--------------------//
		scr_overworld_spawn_companion_beast();

		continue;
	}

	//====================//
	//NUMBER KEY REORDER//
	//====================//
	for (var _it_key = 1;_it_key <= 5;_it_key++){

		if (!keyboard_check_pressed(ord(string(_it_key)))){
			continue;
		}

		var _val_target = _it_key - 1;

		if (
			_val_target < _ct_party_units &&
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
				"OBJ_GUI_RANCH_PANE:DRAW_GUI"
			);

			scr_overworld_spawn_companion_beast();
		}

		break;
	}
}

//================//
//DRAW RANCH SIDE//
//================//
var _val_start_index = _val_ranch_page * _ct_ranch_units_per_page;

for (var _it_unit = 0;_it_unit < _ct_ranch_units_per_page;_it_unit++){

	var _val_ranch_index = _val_start_index + _it_unit;
	var _val_box_x = _val_ranch_x;
	var _val_box_y = _val_start_y + (_it_unit * (_val_slot_h + _val_slot_margin));

	//----------------//
	//DRAW SLOT FRAME//
	//----------------//
	draw_set_colour(c_black);

	draw_rectangle(
		_val_box_x,
		_val_box_y,
		_val_box_x + _val_slot_w,
		_val_box_y + _val_slot_h,
		false
	);

	draw_set_colour(global.c_dk_gray);

	draw_rectangle(
		_val_box_x + 4,
		_val_box_y + 4,
		_val_box_x + _val_slot_w - 4,
		_val_box_y + _val_slot_h - 4,
		false
	);

	if (_val_ranch_index >= _ct_ranch_units){
		continue;
	}

	var _stct_unit = ds_list_find_value(
		global.list_player_ranch,
		_val_ranch_index
	);

	if (!is_struct(_stct_unit)){
		continue;
	}

	//----------------//
	//DRAW BEAST BOX//
	//----------------//
	var _c_beast_box = _stct_unit._val_beast_hp_cur <= 0 ? c_maroon : c_aqua;

	draw_set_colour(_c_beast_box);

	draw_rectangle(
		_val_box_x + 10,
		_val_box_y + 10,
		_val_box_x + 110,
		_val_box_y + 110,
		false
	);

	var _val_unit_x = _val_box_x + 60;
	var _val_unit_y = _val_box_y + 60;

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
	hscr_gui_ranch_draw_held_item_badge(
		_stct_unit,
		_val_box_x,
		_val_box_y
	);

	//----------------//
	//DRAW BEAST DATA//
	//----------------//
	draw_set_colour(c_black);

	draw_text(
		_val_box_x + 125,
		_val_box_y + 20,
		_stct_unit._str_beast_name
	);

	draw_text(
		_val_box_x + 125,
		_val_box_y + 45,
		"LV " + string(_stct_unit._val_beast_level)
	);

	draw_text(
		_val_box_x + 125,
		_val_box_y + 70,
		string(_stct_unit._val_beast_hp_cur) +
		"/" +
		string(_stct_unit._val_beast_hp_max)
	);

	//================//
	//HANDLE HOVER//
	//================//
	var _flag_hover =
		_val_mouse_x > _val_box_x &&
		_val_mouse_x < _val_box_x + _val_slot_w &&
		_val_mouse_y > _val_box_y &&
		_val_mouse_y < _val_box_y + _val_slot_h;

	if (!_flag_hover){
		continue;
	}

	draw_sprite(spr_gui_ranch_highlight,0,_val_ranch_x + 185,_val_box_y + 65);

	//====================//
	//MOVE BEAST TO PARTY//
	//====================//
	if (
		_ct_party_units < 5 &&
		mouse_check_button_pressed(mb_left) &&
		!_flag_clicked
	){

		audio_play_sound(snd_beast_transfer,0,false);

		_flag_clicked = true;
		_ct_cooldown = 10;

		//----------------//
		//MOVE BEAST//
		//----------------//
		ds_list_add(
			global.list_player_party,
			_stct_unit
		);

		ds_list_delete(
			global.list_player_ranch,
			_val_ranch_index
		);

		//================//
		//DEBUG TRANSFER//
		//================//
		scr_debug_log(
			"BEASTS",
			"PARTY",
			undefined,
			string_upper(_stct_unit._str_beast_name) +
			" MOVED FROM RANCH TO PARTY" +
			" | LEVEL: " +
			string(_stct_unit._val_beast_level) +
			" | UID: " +
			string(_stct_unit._uid_beast) +
			" | PARTY: " +
			string(ds_list_size(global.list_player_party)) +
			"/5" +
			" | RANCH: " +
			string(ds_list_size(global.list_player_ranch)),
			"INFO",
			"OBJ_GUI_RANCH_PANE"
		);

		//--------------------//
		//DESTROY RANCH DUMMY//
		//--------------------//
		if (instance_exists(obj_ranch_interactable)){
			obj_ranch_interactable.hscr_ranch_destroy_beast_dummy(_stct_unit._uid_beast);
		}

		_ct_party_units = ds_list_size(global.list_player_party);
		_ct_ranch_units = ds_list_size(global.list_player_ranch);

		var _ct_total_pages = max(
			1,
			ceil(_ct_ranch_units / _ct_ranch_units_per_page)
		);

		_val_ranch_page = clamp(
			_val_ranch_page,
			0,
			_ct_total_pages - 1
		);

		//================//
		//DEBUG TRANSFER//
		//================//
		scr_debug_log(
			"BEASTS",
			"PARTY",
			undefined,
			string_upper(_stct_unit._str_beast_name) +
			" MOVED FROM RANCH TO PARTY" +
			" | LEVEL: " +
			string(_stct_unit._val_beast_level) +
			" | UID: " +
			string(_stct_unit._uid_beast) +
			" | PARTY: " +
			string(_ct_party_units) +
			"/5" +
			" | RANCH: " +
			string(_ct_ranch_units),
			"INFO",
			"OBJ_GUI_RANCH_PANE:DRAW_GUI"
		);

		scr_overworld_spawn_companion_beast();

		continue;
	}

	//====================//
	//DELETE RANCH BEAST//
	//====================//
	if (
		keyboard_check_pressed(vk_delete) &&
		!_flag_clicked
	){

		audio_play_sound(snd_gui_destroy,0,false);

		_flag_clicked = true;
		_ct_cooldown = 10;

		//----------------//
		//STORE BEAST DATA//
		//----------------//
		var _str_deleted_name = string_upper(_stct_unit._str_beast_name);
		var _val_deleted_level = _stct_unit._val_beast_level;
		var _uid_deleted_beast = _stct_unit._uid_beast;

		//----------------//
		//DELETE BEAST//
		//----------------//
		ds_list_delete(
			global.list_player_ranch,
			_val_ranch_index
		);

		if (instance_exists(obj_ranch_interactable)){
			obj_ranch_interactable.hscr_ranch_destroy_beast_dummy(_uid_deleted_beast);
		}

		_ct_party_units = ds_list_size(global.list_player_party);
		_ct_ranch_units = ds_list_size(global.list_player_ranch);

		var _ct_total_pages = max(
			1,
			ceil(_ct_ranch_units / _ct_ranch_units_per_page)
		);

		_val_ranch_page = clamp(
			_val_ranch_page,
			0,
			_ct_total_pages - 1
		);

		//================//
		//DEBUG DELETION//
		//================//
		scr_debug_log(
			"BEASTS",
			"RANCH",
			undefined,
			_str_deleted_name +
			" PERMANENTLY REMOVED FROM RANCH" +
			" | LEVEL: " +
			string(_val_deleted_level) +
			" | UID: " +
			string(_uid_deleted_beast) +
			" | RANCH: " +
			string(_ct_ranch_units),
			"INFO",
			"OBJ_GUI_RANCH_PANE:DRAW_GUI"
		);

		continue;
	}
}

//================//
//DRAW PAGE NUMBER//
//================//
var _ct_total_pages = max(
	1,
	ceil(_ct_ranch_units / _ct_ranch_units_per_page)
);

_val_ranch_page = clamp(
	_val_ranch_page,
	0,
	_ct_total_pages - 1
);

draw_set_colour(c_black);
draw_set_halign(fa_center);

draw_text(
	_val_page_center_x,
	_val_page_y - 8,
	"PAGE " +
	string(_val_ranch_page + 1) +
	"/" +
	string(_ct_total_pages)
);

draw_set_halign(fa_left);

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