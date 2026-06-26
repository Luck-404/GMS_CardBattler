//===============================================================================//
//
// DRAW GUI: OBJ_BATTLE_BEAST
// FUNCTION: Draws and manages a battle beast.
//           Handles hover preview, HP/armor display, casting visual checks,
//           death handling, and battlefield repositioning.
//
//===============================================================================//

if (!instance_exists(obj_gui_end_battle_pane)){

	draw_set_font(fnt_small_gui);

	if (_str_list == "DEAD"){
		_val_cur_hp = 0;
	}

	//
	// DRAW SELF AND SHADOW
	//
	#region DRAW SELF AND SHADOW
	draw_self();

	var _val_scale_x = (_str_team == "PLAYER") ? 0.2 : -0.2;
	var _val_scale_y = 0.2;

	if (position_meeting(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),self)){

		if (obj_battle_player_controller._player_state == PLAYER_STATE.SELECT_CASTER && _str_team == "PLAYER"){
			draw_sprite(spr_battle_caster_hover_icon,0,x,y - 50);
		}

		if (obj_battle_player_controller._player_state == PLAYER_STATE.SELECT_TARGET){
			draw_sprite(spr_battle_target_hover_icon,0,x,y - 50);
		}

		_val_scale_x *= 1.15;
		_val_scale_y *= 1.15;

		_flag_preview_beast = keyboard_check(vk_lcontrol);
	}
	else{
		_flag_preview_beast = false;
	}

	var _spr_shadow = scr_get_beast_type_shadow(_stct_unit._str_beast_color_type);

	draw_sprite_ext(_spr_shadow,0,x,y + 34,1,1,0,c_white,1);

	if (_val_cur_hp <= 0){
		draw_sprite_ext(_spr_beast,0,x,y,_val_scale_x,_val_scale_y,0,c_ltgray,1);
		draw_sprite(spr_battle_beast_dead,0,x,y);
	}
	else if (obj_battle_player_controller._player_state == PLAYER_STATE.SELECT_CASTER && (!_flag_beast_able_check || !_flag_beast_color_check || !_flag_beast_archetype_check || !_flag_beast_class_check)){
		draw_sprite_ext(_spr_beast,0,x,y,_val_scale_x,_val_scale_y,0,c_ltgray,1);
	}
	else if (obj_battle_player_controller._player_state == PLAYER_STATE.SELECT_TARGET && !_flag_beast_range_check){
		draw_sprite_ext(_spr_beast,0,x,y,_val_scale_x,_val_scale_y,0,c_ltgray,1);
	}
	else{
		draw_sprite_ext(_spr_beast,0,x,y,_val_scale_x,_val_scale_y,0,c_white,1);
	}

	if (obj_battle_player_controller._player_state != PLAYER_STATE.SELECT_CASTER){
		_flag_beast_color_check = true;
		_flag_beast_archetype_check = true;
		_flag_beast_class_check = true;
	}

	if (obj_battle_player_controller._player_state != PLAYER_STATE.SELECT_TARGET){
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

	if (obj_battle_player_controller._player_state == PLAYER_STATE.SELECT_TARGET){
		if (self == global.ref_caster_beast){
			draw_sprite(spr_battle_caster_hover_icon,0,x,y - 50);
		}
	}

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
				_ref_status._status_command = "DEATH";
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

//
// BEAST PREVIEW
//
#region BEAST PREVIEW
if (_flag_preview_beast && _stct_unit != undefined){

	draw_set_font(fnt_small_gui);
	draw_set_colour(c_black);

	var _val_panel_w = 360;
	var _val_panel_h = 380;

	var _val_panel_x = room_width * 0.5 - (_val_panel_w * 0.5);
	var _val_panel_y = 40;

	draw_set_colour(c_dkgray);
	draw_rectangle(_val_panel_x,_val_panel_y,_val_panel_x + _val_panel_w,_val_panel_y + _val_panel_h,false);

	draw_set_colour(c_black);
	draw_rectangle(_val_panel_x,_val_panel_y,_val_panel_x + _val_panel_w,_val_panel_y + _val_panel_h,true);

	var _val_text_x = _val_panel_x + 12;
	var _val_text_y = _val_panel_y + 12;
	var _val_lh = 18;

	draw_set_colour(c_white);

	draw_text(_val_text_x,_val_text_y,string(_stct_unit._str_beast_name));

	_val_text_y += _val_lh * 2;

	draw_text(_val_text_x,_val_text_y,"=== STATS ===");
	_val_text_y += _val_lh;

	var _val_hp = _stct_unit._val_beast_hp_stat;
	var _val_con = _stct_unit._val_beast_con_stat;
	var _val_ppow = _stct_unit._val_beast_ppow_stat;
	var _val_mpow = _stct_unit._val_beast_mpow_stat;
	var _val_pdef = _stct_unit._val_beast_pdef_stat;
	var _val_mdef = _stct_unit._val_beast_mdef_stat;
	var _val_crit = _stct_unit._val_beast_crit_stat;
	var _val_dodge = _stct_unit._val_beast_dod_stat;
	var _val_minions = _stct_unit._val_beast_min_stat;

	draw_text(_val_text_x,_val_text_y,"HP: " + string(_val_hp) + " (" + scr_get_beast_grade_letter(_val_hp) + " x" + string(scr_get_beast_grade_modifier(_val_hp)) + ")");
	_val_text_y += _val_lh;

	draw_text(_val_text_x,_val_text_y,"CON: " + string(_val_con) + " (" + scr_get_beast_grade_letter(_val_con) + " x" + string(scr_get_beast_grade_modifier(_val_con)) + ")");
	_val_text_y += _val_lh;

	draw_text(_val_text_x,_val_text_y,"PPOW: " + string(_val_ppow) + " (" + scr_get_beast_grade_letter(_val_ppow) + " x" + string(scr_get_beast_grade_modifier(_val_ppow)) + ")");
	_val_text_y += _val_lh;

	draw_text(_val_text_x,_val_text_y,"MPOW: " + string(_val_mpow) + " (" + scr_get_beast_grade_letter(_val_mpow) + " x" + string(scr_get_beast_grade_modifier(_val_mpow)) + ")");
	_val_text_y += _val_lh;

	draw_text(_val_text_x,_val_text_y,"PDEF: " + string(_val_pdef) + " (" + scr_get_beast_grade_letter(_val_pdef) + " x" + string(scr_get_beast_grade_modifier(_val_pdef)) + ")");
	_val_text_y += _val_lh;

	draw_text(_val_text_x,_val_text_y,"MDEF: " + string(_val_mdef) + " (" + scr_get_beast_grade_letter(_val_mdef) + " x" + string(scr_get_beast_grade_modifier(_val_mdef)) + ")");
	_val_text_y += _val_lh;

	draw_text(_val_text_x,_val_text_y,"CRIT: " + string(_val_crit));
	_val_text_y += _val_lh;

	draw_text(_val_text_x,_val_text_y,"DODGE: " + string(_val_dodge));
	_val_text_y += _val_lh;

	draw_text(_val_text_x,_val_text_y,"MINIONS: " + string(_val_minions));
	_val_text_y += _val_lh * 2;

	draw_text(_val_text_x,_val_text_y,"=== ABILITY ===");
	_val_text_y += _val_lh;

	draw_text_ext(_val_text_x,_val_text_y,string(_stct_unit._str_beast_ability),-1,320);

	_val_text_y += 60;

	draw_text(_val_text_x,_val_text_y,"=== TALENT TREES ===");
	_val_text_y += _val_lh;

	var _arr_trees = _stct_unit._arr_beast_talent_trees;
	var _str_tree_text = "";

	for (var _it_tree = 0; _it_tree < array_length(_arr_trees); _it_tree++){

		if (_it_tree > 0){
			_str_tree_text += ", ";
		}

		_str_tree_text += string(_arr_trees[_it_tree]);
	}

	draw_text(_val_text_x,_val_text_y,_str_tree_text);
}
#endregion