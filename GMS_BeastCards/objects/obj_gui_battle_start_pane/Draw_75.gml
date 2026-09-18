//===============================================================================//
//
// DRAW GUI: OBJ_GUI_BATTLE_START_PANE
// FUNCTION: Draws the pre-battle matchup pane.
//           Shows Player and Enemy team members, HP, Level, Speed,
//           average team Speed, opening initiative, and Start Battle.
//
//===============================================================================//

//================//
//DRAW STATE//
//================//

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_alpha(1);


//================//
//SCREEN DIM//
//================//

// The transition fader owns the background during battle entry.
// This fallback supports launching rm_battle directly without a transition.

if (!instance_exists(obj_transition_fader)){

	draw_set_alpha(0.35);
	draw_set_colour(c_black);

	draw_rectangle(
		0,
		0,
		display_get_gui_width(),
		display_get_gui_height(),
		false
	);
}

draw_set_alpha(1);
draw_set_colour(c_white);

//================//
//PANE LAYOUT//
//================//

var _val_pane_left = x - (_val_pane_w * 0.5);
var _val_pane_right = x + (_val_pane_w * 0.5);

var _val_pane_top = y - (_val_pane_h * 0.5);
var _val_pane_bottom = y + (_val_pane_h * 0.5);

var _val_team_top = _val_pane_top + 60;
var _val_team_bottom = _val_pane_bottom - 110;

var _val_player_x1 = _val_pane_left + 25;
var _val_player_x2 = x - 25;

var _val_enemy_x1 = x + 25;
var _val_enemy_x2 = _val_pane_right - 25;

//================//
//MAIN PANE//
//================//

draw_set_colour(c_black);

draw_rectangle(
	_val_pane_left,
	_val_pane_top,
	_val_pane_right,
	_val_pane_bottom,
	false
);

draw_set_colour(global.c_dk_gray);

draw_rectangle(
	_val_pane_left + 4,
	_val_pane_top + 4,
	_val_pane_right - 4,
	_val_pane_bottom - 4,
	false
);

//================//
//TEAM BOXES//
//================//

draw_set_colour(c_black);

draw_rectangle(
	_val_player_x1,
	_val_team_top,
	_val_player_x2,
	_val_team_bottom,
	true
);

draw_rectangle(
	_val_enemy_x1,
	_val_team_top,
	_val_enemy_x2,
	_val_team_bottom,
	true
);

//================//
//GOING FIRST BOX//
//================//

if (_str_first_team == "PLAYER"){

	draw_set_colour(c_yellow);

	draw_rectangle(
		_val_player_x1 - 3,
		_val_team_top - 3,
		_val_player_x2 + 3,
		_val_team_bottom + 3,
		true
	);

	draw_rectangle(
		_val_player_x1 - 4,
		_val_team_top - 4,
		_val_player_x2 + 4,
		_val_team_bottom + 4,
		true
	);
}
else if (_str_first_team == "ENEMY"){

	draw_set_colour(c_yellow);

	draw_rectangle(
		_val_enemy_x1 - 3,
		_val_team_top - 3,
		_val_enemy_x2 + 3,
		_val_team_bottom + 3,
		true
	);

	draw_rectangle(
		_val_enemy_x1 - 4,
		_val_team_top - 4,
		_val_enemy_x2 + 4,
		_val_team_bottom + 4,
		true
	);
}

//================//
//HEADERS//
//================//

draw_set_font(fnt_gui_medium);
draw_set_halign(fa_center);
draw_set_valign(fa_top);

draw_set_colour(c_white);

draw_text(
	(_val_player_x1 + _val_player_x2) * 0.5,
	_val_team_top + 14,
	"YOUR TEAM"
);

draw_text(
	(_val_enemy_x1 + _val_enemy_x2) * 0.5,
	_val_team_top + 14,
	"ENEMY TEAM"
);

//================//
//AVERAGE SPEED//
//================//

draw_set_font(fnt_gui_small);
draw_set_colour(c_ltgray);

draw_text(
	(_val_player_x1 + _val_player_x2) * 0.5,
	_val_team_top + 45,
	"AVG SPEED: " + string_format(_val_player_avg_speed,0,1)
);

draw_text(
	(_val_enemy_x1 + _val_enemy_x2) * 0.5,
	_val_team_top + 45,
	"AVG SPEED: " + string_format(_val_enemy_avg_speed,0,1)
);

//================//
//GOING FIRST TEXT//
//================//

draw_set_font(fnt_gui_medium);
draw_set_colour(c_yellow);

if (_str_first_team == "PLAYER"){

	draw_text(
		(_val_player_x1 + _val_player_x2) * 0.5,
		_val_team_top + 70,
		"GOING FIRST"
	);
}

if (_str_first_team == "ENEMY"){

	draw_text(
		(_val_enemy_x1 + _val_enemy_x2) * 0.5,
		_val_team_top + 70,
		"GOING FIRST"
	);
}

//================//
//VS//
//================//

draw_set_colour(c_white);
draw_set_font(fnt_gui_large);

draw_text(
	x,
	_val_team_top + 180,
	"VS"
);

//================//
//PLAYER TEAM//
//================//

draw_set_halign(fa_left);

var _val_player_row_y = _val_team_top + 110;

if (
	instance_exists(_ref_player_controller) &&
	ds_exists(_ref_player_controller._list_beasts_alive,ds_type_list)
){

	var _ct_player_beasts = min(
		5,
		ds_list_size(_ref_player_controller._list_beasts_alive)
	);

	for (var _it_beast = 0; _it_beast < _ct_player_beasts; _it_beast++){

		var _ref_beast = ds_list_find_value(
			_ref_player_controller._list_beasts_alive,
			_it_beast
		);

		if (!instance_exists(_ref_beast)){
			continue;
		}

		if (!is_struct(_ref_beast._ref_unit)){
			continue;
		}

		var _val_row_y =
			_val_player_row_y +
			(_it_beast * (_val_row_h + _val_row_spacing));

		//----------//
		//ROW BORDER//
		//----------//

		draw_set_colour(c_black);

		draw_rectangle(
			_val_player_x1 + 12,
			_val_row_y,
			_val_player_x2 - 12,
			_val_row_y + _val_row_h,
			true
		);

		//---------//
		//UNIT NAME//
		//---------//

		draw_set_font(fnt_gui_small);
		draw_set_colour(c_white);

		draw_text(
			_val_player_x1 + 24,
			_val_row_y + 7,
			string_upper(_ref_beast._ref_unit._str_beast_name)
		);

		//----------//
		//UNIT STATS//
		//----------//

		var _str_stats =
			"HP " +
			string(_ref_beast._val_cur_hp) +
			"/" +
			string(_ref_beast._val_max_hp) +
			"   LVL " +
			string(_ref_beast._ref_unit._val_beast_level) +
			"   SPD " +
			string(round(scr_battle_get_beast_speed(_ref_beast)));

		draw_set_colour(c_ltgray);

		draw_text(
			_val_player_x1 + 24,
			_val_row_y + 28,
			_str_stats
		);
	}
}

//================//
//ENEMY TEAM//
//================//

var _val_enemy_row_y = _val_team_top + 110;

if (
	instance_exists(_ref_enemy_controller) &&
	ds_exists(_ref_enemy_controller._list_beasts_alive,ds_type_list)
){

	var _ct_enemy_beasts = min(
		5,
		ds_list_size(_ref_enemy_controller._list_beasts_alive)
	);

	for (var _it_beast = 0; _it_beast < _ct_enemy_beasts; _it_beast++){

		var _ref_beast = ds_list_find_value(
			_ref_enemy_controller._list_beasts_alive,
			_it_beast
		);

		if (!instance_exists(_ref_beast)){
			continue;
		}

		if (!is_struct(_ref_beast._ref_unit)){
			continue;
		}

		var _val_row_y =
			_val_enemy_row_y +
			(_it_beast * (_val_row_h + _val_row_spacing));

		//----------//
		//ROW BORDER//
		//----------//

		draw_set_colour(c_black);

		draw_rectangle(
			_val_enemy_x1 + 12,
			_val_row_y,
			_val_enemy_x2 - 12,
			_val_row_y + _val_row_h,
			true
		);

		//---------//
		//UNIT NAME//
		//---------//

		draw_set_font(fnt_gui_small);
		draw_set_colour(c_white);

		draw_text(
			_val_enemy_x1 + 24,
			_val_row_y + 7,
			string_upper(_ref_beast._ref_unit._str_beast_name)
		);

		//----------//
		//UNIT STATS//
		//----------//

		var _str_stats =
			"HP " +
			string(_ref_beast._val_cur_hp) +
			"/" +
			string(_ref_beast._val_max_hp) +
			"   LVL " +
			string(_ref_beast._ref_unit._val_beast_level) +
			"   SPD " +
			string(round(scr_battle_get_beast_speed(_ref_beast)));

		draw_set_colour(c_ltgray);

		draw_text(
			_val_enemy_x1 + 24,
			_val_row_y + 28,
			_str_stats
		);
	}
}

//================//
//START BUTTON//
//================//

var _val_button_x1 = x - (_val_button_w * 0.5);
var _val_button_x2 = x + (_val_button_w * 0.5);

var _val_button_y1 = _val_pane_bottom - 78;
var _val_button_y2 = _val_button_y1 + _val_button_h;

var _val_mouse_x = device_mouse_x_to_gui(0);
var _val_mouse_y = device_mouse_y_to_gui(0);

var _flag_button_hover =
	_val_mouse_x >= _val_button_x1 &&
	_val_mouse_x <= _val_button_x2 &&
	_val_mouse_y >= _val_button_y1 &&
	_val_mouse_y <= _val_button_y2;

draw_set_colour(c_black);

draw_rectangle(
	_val_button_x1 - 3,
	_val_button_y1 - 3,
	_val_button_x2 + 3,
	_val_button_y2 + 3,
	false
);

draw_set_colour(_flag_button_hover ? c_white : c_yellow);

draw_rectangle(
	_val_button_x1,
	_val_button_y1,
	_val_button_x2,
	_val_button_y2,
	false
);

draw_set_font(fnt_gui_medium);
draw_set_colour(c_black);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_text(
	x,
	(_val_button_y1 + _val_button_y2) * 0.5,
	"START BATTLE!"
);

//================//
//RESET DRAW STATE//
//================//

draw_set_alpha(1);
draw_set_colour(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);