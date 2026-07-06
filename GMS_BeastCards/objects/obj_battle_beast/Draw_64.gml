//===============================================================================//
//
// DRAW GUI: OBJ_BATTLE_BEAST
// FUNCTION: Draws and manages a battle beast.
//           Handles hover preview, HP/armor display, casting visual checks,
//           death handling, prism targeting, and battlefield repositioning.
//
//===============================================================================//

if (!instance_exists(obj_gui_end_battle_pane)){

	draw_set_font(fnt_small_gui);

	if (_str_list == "DEAD"){
		_val_cur_hp = 0;
	}

	//----------------//
	//STATE SHORTCUTS//
	//----------------//
	var _flag_state_select_target = (
		obj_battle_player_controller._state_player == ENUM_PLAYER_STATE.SELECT_TARGET ||
		obj_battle_player_controller._state_player == ENUM_PLAYER_STATE.SELECT_PRISM_TARGET
	);

	var _flag_state_select_prism_target = (
		obj_battle_player_controller._state_player == ENUM_PLAYER_STATE.SELECT_PRISM_TARGET
	);

	//
	// DRAW SELF AND SHADOW
	//
	//
	// DRAW SELF AND SHADOW
	//
	#region DRAW SELF AND SHADOW

	var _val_scale_x = (_str_team == "PLAYER") ? 0.2 : -0.2;
	var _val_scale_y = 0.2;

	//-----------------//
	//CAPTURED DISPLAY//
	//-----------------//
	if (_flag_captured){

		draw_sprite(spr_battle_beast_captured,0,x,y);

		exit;
	}

	//-------------//
	//NORMAL HOVER//
	//-------------//
	if (position_meeting(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),self)){

		if (obj_battle_player_controller._state_player == ENUM_PLAYER_STATE.SELECT_CASTER && _str_team == "PLAYER"){
			draw_sprite(spr_battle_caster_hover_icon,0,x,y - 50);
		}

		if (_flag_state_select_target){
			draw_sprite(spr_battle_target_hover_icon,0,x,y - 50);
		}

		_val_scale_x *= 1.15;
		_val_scale_y *= 1.15;

		_flag_preview_beast = keyboard_check(vk_lcontrol);

		//-------------------//
		//PRISM TAME PREVIEW//
		//-------------------//
		if (
			_flag_state_select_prism_target &&
			_str_team == "ENEMY" &&
			_str_list == "ALIVE" &&
			_val_cur_hp > 0 &&
			obj_battle_player_controller._stct_selected_prism != undefined
		){
			var _val_tame_chance = scr_get_prism_tame_chance(
				obj_battle_player_controller._stct_selected_prism._str_item_id,
				self
			);

			draw_set_font(fnt_small_gui);
			draw_set_halign(fa_center);
			draw_set_valign(fa_top);
			draw_set_colour(c_black);

			draw_text(x,y - 115,"TAME: " + string(_val_tame_chance) + "%");

			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
		}
	}
	else{
		_flag_preview_beast = false;
	}

	//--------//
	//SHADOW//
	//--------//
	var _spr_shadow = scr_get_beast_type_shadow(_ref_unit._str_beast_color_type);

	draw_sprite_ext(_spr_shadow,0,x,y + 34,1,1,0,c_white,1);

	//-------------//
	//BEAST SPRITE//
	//-------------//
	if (_val_cur_hp <= 0){
		draw_sprite_ext(_spr_beast,0,x,y,_val_scale_x,_val_scale_y,0,c_ltgray,1);
		draw_sprite(spr_battle_beast_dead,0,x,y);
	}
	else if (obj_battle_player_controller._state_player == ENUM_PLAYER_STATE.SELECT_CASTER && (!_flag_beast_able_check || !_flag_beast_color_check || !_flag_beast_archetype_check || !_flag_beast_class_check)){
		draw_sprite_ext(_spr_beast,0,x,y,_val_scale_x,_val_scale_y,0,c_ltgray,1);
	}
	else if (_flag_state_select_target && !_flag_beast_range_check){
		draw_sprite_ext(_spr_beast,0,x,y,_val_scale_x,_val_scale_y,0,c_ltgray,1);
	}
	else{
		draw_sprite_ext(_spr_beast,0,x,y,_val_scale_x,_val_scale_y,0,c_white,1);
	}

	if (obj_battle_player_controller._state_player != ENUM_PLAYER_STATE.SELECT_CASTER){
		_flag_beast_color_check = true;
		_flag_beast_archetype_check = true;
		_flag_beast_class_check = true;
	}

	if (!_flag_state_select_target){
		_flag_beast_range_check = true;
	}
	#endregion

	//
	// DRAW HP BAR
	//
	#region DRAW HP BAR
	var _val_bar_w = 96;
	var _val_bar_h = 10;
	var _val_bar_x1 = x - (_val_bar_w * 0.5);
	var _val_bar_y1 = y - 70;
	var _val_bar_x2 = _val_bar_x1 + _val_bar_w;
	var _val_bar_y2 = _val_bar_y1 + _val_bar_h;

	draw_set_colour(c_red);
	draw_rectangle(_val_bar_x1,_val_bar_y1,_val_bar_x2,_val_bar_y2,false);

	var _val_hp_fill = clamp(_val_cur_hp / _val_max_hp,0,1);

	draw_set_colour(c_green);
	draw_rectangle(_val_bar_x1,_val_bar_y1,_val_bar_x1 + (_val_bar_w * _val_hp_fill),_val_bar_y2,false);

	if (_val_overhealth > 0){

		var _ct_pip = ceil(_val_overhealth / 5);
		_ct_pip = min(_ct_pip,10);

		var _val_pip_size = 8;
		var _val_pip_gap = 1;

		var _val_pip_x = _val_bar_x1 + 2;
		var _val_pip_y = _val_bar_y1 + 1;

		for (var _it_pip = 0; _it_pip < _ct_pip; _it_pip++){

			var _val_x1 = _val_pip_x + (_it_pip * (_val_pip_size + _val_pip_gap));
			var _val_y1 = _val_pip_y;

			draw_set_colour(c_lime);
			draw_rectangle(_val_x1,_val_y1,_val_x1 + _val_pip_size,_val_y1 + _val_pip_size,false);

			draw_set_colour(c_black);
			draw_rectangle(_val_x1,_val_y1,_val_x1 + _val_pip_size,_val_y1 + _val_pip_size,true);
		}
	}

	draw_set_colour(c_black);
	draw_rectangle(_val_bar_x1,_val_bar_y1,_val_bar_x2,_val_bar_y2,true);

	draw_set_font(fnt_small_gui);
	draw_set_colour(c_black);

	var _str_hp_text = string(_val_cur_hp);

	if (_val_overhealth > 0){
		_str_hp_text += " (+" + string(_val_overhealth) + ")";
	}

	_str_hp_text += "/" + string(_val_max_hp);

	draw_text(x - string_width(_str_hp_text) * 0.5,_val_bar_y1 - 16,_str_hp_text);
	#endregion

	//
	// DRAW ARMOR
	//
	#region DRAW ARMOR
	if (_val_armor > 0){

		draw_set_font(fnt_small_gui);
		draw_set_colour(c_white);

		var _val_icon_x = _val_bar_x2 - 16;
		var _val_icon_y = _val_bar_y2 + 16;

		draw_sprite(spr_battle_armor_icon,0,_val_icon_x,_val_icon_y);

		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);

		draw_text(_val_icon_x,_val_icon_y,string(_val_armor));

		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
	}
	#endregion

	//
	// CASTER ICON WHILE TARGETING
	//
	#region CASTER ICON WHILE TARGETING
	if (_flag_state_select_target){
		if (self == global.ref_caster_beast){
			draw_sprite(spr_battle_caster_hover_icon,0,x,y - 50);
		}
	}
	#endregion

	//
	// DRAW SELECTION HIGHLIGHT
	//
	#region DRAW SELECTION HIGHLIGHT
	if (global.ref_caster_beast == self){
		draw_set_colour(c_black);
		draw_rectangle(x - 70,y - 90,x + 70,y + 90,true);
	}

	if (global.ref_target_beast == self){
		draw_set_colour(c_black);
		draw_rectangle(x - 75,y - 95,x + 75,y + 95,true);
	}
	#endregion

	//
	// DEATH CHECK
	//
	#region DEATH CHECK
	if (_val_cur_hp <= 0 && !_flag_death_handled){

		_flag_death_handled = true;
		_val_cur_hp = 0;
		_str_list = "DEAD";

		for (var _it_minion = ds_list_size(_list_minions) - 1; _it_minion >= 0; _it_minion--){

			var _ref_minion = ds_list_find_value(_list_minions,_it_minion);

			if (instance_exists(_ref_minion)){
				instance_destroy(_ref_minion);
			}
		}

		for (var _it_status = ds_list_size(_list_statuses) - 1; _it_status >= 0; _it_status--){

			var _ref_status = ds_list_find_value(_list_statuses,_it_status);

			if (instance_exists(_ref_status)){
				_ref_status._str_status_command = "DEATH";
			}
		}

		var _list_alive;
		var _list_dead;

		if (_str_team == "PLAYER"){
			_list_alive = obj_battle_player_controller._list_beasts_alive;
			_list_dead = obj_battle_player_controller._list_beasts_graveyard;
		}
		else{
			_list_alive = obj_battle_enemy_controller._list_beasts_alive;
			_list_dead = obj_battle_enemy_controller._list_beasts_graveyard;
		}

		ds_list_delete(_list_alive,_val_pos);
		ds_list_add(_list_dead,self);

		for (var _it_beast = 0; _it_beast < ds_list_size(_list_alive); _it_beast++){

			var _ref_beast = ds_list_find_value(_list_alive,_it_beast);

			_ref_beast._val_pos = _it_beast;
			_ref_beast.x = hscr_get_battle_x(_ref_beast._str_team,_it_beast);

			scr_reposition_minions(_ref_beast);
			scr_reposition_statuses(_ref_beast);
		}

		var _ct_alive = ds_list_size(_list_alive);

		for (var _it_beast = 0; _it_beast < ds_list_size(_list_dead); _it_beast++){

			var _ref_beast = ds_list_find_value(_list_dead,_it_beast);

			_ref_beast._val_pos = _ct_alive + _it_beast;
			_ref_beast.x = hscr_get_dead_x(_ref_beast._str_team,_ct_alive,_it_beast);
		}

		draw_sprite(spr_battle_beast_dead,0,x,y);

		exit;
	}
	#endregion
}