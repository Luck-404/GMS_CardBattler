//===============================================================================//
//
// DRAW: OBJ_BATTLE_MINION
// FUNCTION: Draws the battle minion.
//           Displays sprite, HP, and an inspection tooltip while hovered.
//
//===============================================================================//

if (!instance_exists(obj_gui_end_battle_pane)){

	if (!instance_exists(_ref_host)){
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
	draw_sprite_ext(_spr_minion,0,x,y,_val_scale * _val_flip,_val_scale,0,c_white,1);
	#endregion

	//
	// DRAW HP
	//
	#region DRAW HP
	draw_set_colour(c_white);

	var _str_hp = string(_val_cur_hp) + "/" + string(_val_max_hp);

	draw_text(x - string_width(_str_hp) * 0.5,y + 20,_str_hp);
	#endregion

//
// DRAW TOOLTIP
//
#region DRAW TOOLTIP

if (
	keyboard_check(vk_lcontrol) &&
	position_meeting(
		device_mouse_x_to_gui(0),
		device_mouse_y_to_gui(0),
		self
	)
){

	var _str_host_name = "UNKNOWN";

	if (
		instance_exists(_ref_host) &&
		_ref_host._ref_unit != undefined
	){
		_str_host_name =
			string(_ref_host._ref_unit._str_beast_name);
	}

	var _str_title =
		_str_name +
		" | " +
		_str_host_name;

	var _str_age = "";

	//-----------------//
	//DORMANT SEED AGE//
	//-----------------//
	if (_str_name == "DORMANT SEED"){
		_str_age = "AGE: " + string(_ct_age) + " / 2";
	}

	//------------//
	//PANEL SIZE//
	//------------//
	var _val_panel_w =
		string_width(_str_title) + 40;

	if (_str_age != ""){
		_val_panel_w =
			max(
				_val_panel_w,
				string_width(_str_age) + 40
			);
	}

	var _val_panel_h =
		(_str_age != "") ? 60 : 40;

	var _val_panel_x =
		room_width * 0.5 -
		(_val_panel_w * 0.5);

	var _val_panel_y = 20;

	//-----------//
	//DRAW PANEL//
	//-----------//
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

	//-----------//
	//DRAW TITLE//
	//-----------//
	draw_set_colour(c_white);

	draw_text(
		_val_panel_x +
			(_val_panel_w * 0.5) -
			(string_width(_str_title) * 0.5),
		_val_panel_y + 12,
		_str_title
	);

	//----------//
	//DRAW AGE//
	//----------//
	if (_str_age != ""){

		draw_text(
			_val_panel_x +
				(_val_panel_w * 0.5) -
				(string_width(_str_age) * 0.5),
			_val_panel_y + 32,
			_str_age
		);
	}
}

#endregion
}