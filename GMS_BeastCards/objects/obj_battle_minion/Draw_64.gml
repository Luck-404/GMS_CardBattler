//===============================================================================//
//
// DRAW: OBJ_BATTLE_MINION
// FUNCTION: Draws the battle minion.
//           Displays sprite, HP, and an inspection tooltip while hovered.
//
//===============================================================================//

if (!instance_exists(obj_gui_end_battle_pane)){

	if (_ref_host == undefined){
		exit;
	}

	//
	// BASIC SETUP
	//
	#region BASIC SETUP

	draw_set_font(fnt_small_party_draw);

	var _val_scale = 0.125;
	var _val_flip = (_str_team == "ENEMY") ? -1 : 1;

	#endregion

	//
	// DRAW SPRITE
	//
	#region DRAW SPRITE

	draw_sprite_ext(
		_spr_minion,
		0,
		x,
		y,
		_val_scale * _val_flip,
		_val_scale,
		0,
		c_white,
		1
	);

	#endregion

	//
	// DRAW HP
	//
	#region DRAW HP

	draw_set_colour(c_white);

	var _str_hp = string(_val_cur_hp) + "/" + string(_val_max_hp);

	draw_text(
		x - string_width(_str_hp) * 0.5,
		y + 20,
		_str_hp
	);

	#endregion

	//
	// DRAW TOOLTIP
	//
	#region DRAW TOOLTIP

	if (keyboard_check(vk_lcontrol) && position_meeting(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),self)){

		var _str_host_name = (_ref_host != undefined) ? string(_ref_host._stct_unit.beast_name) : "UNKNOWN";

		var _str_title = _str_name + " | " + _str_host_name;

		var _val_panel_w = string_width(_str_title) + 40;
		var _val_panel_h = 40;

		var _val_panel_x = room_width * 0.5 - (_val_panel_w * 0.5);
		var _val_panel_y = 20;

		draw_set_colour(c_dkgray);
		draw_rectangle(
			_val_panel_x,
			_val_panel_y,
			_val_panel_x + _val_panel_w,
			_val_panel_y + _val_panel_h,
			false
		);

		draw_set_colour(c_black);
		draw_rectangle(
			_val_panel_x,
			_val_panel_y,
			_val_panel_x + _val_panel_w,
			_val_panel_y + _val_panel_h,
			true
		);

		draw_set_colour(c_white);

		draw_text(
			_val_panel_x + (_val_panel_w * 0.5) - (string_width(_str_title) * 0.5),
			_val_panel_y + 12,
			_str_title
		);
	}

	#endregion
}