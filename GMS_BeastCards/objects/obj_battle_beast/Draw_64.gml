//===============================================================================//
//
// DRAW GUI: OBJ_BATTLE_BEAST
// FUNCTION: Draws a battle Beast and its combat GUI.
//           Handles targeting/caster feedback, HP, Overhealth, Armor,
//           selection markers, and battle presentation.
//
//===============================================================================//

if (!instance_exists(obj_gui_end_battle_pane)){

	draw_set_font(fnt_gui_small);

	#region STATE

	//----------------//
	//STATE SHORTCUTS//
	//----------------//
	var _flag_state_select_caster =
		(obj_battle_player_controller._state_player == ENUM_PLAYER_STATE.SELECT_CASTER);

	var _flag_state_select_card_target =
		(obj_battle_player_controller._state_player == ENUM_PLAYER_STATE.SELECT_TARGET);

	var _flag_state_select_prism_target =
		(obj_battle_player_controller._state_player == ENUM_PLAYER_STATE.SELECT_PRISM_TARGET);

	var _flag_state_select_any_target =
		(_flag_state_select_card_target || _flag_state_select_prism_target);

	//----------------//
	//HOVER SHORTCUT//
	//----------------//
	var _flag_mouse_hover = position_meeting(
		device_mouse_x_to_gui(0),
		device_mouse_y_to_gui(0),
		self
	);

	#endregion

	#region BEAST DRAW

	//----------------//
	//DRAW VARIABLES//
	//----------------//
	var _val_scale_x = (_str_team == "PLAYER") ? 0.2 : -0.2;
	var _val_scale_y = 0.2;

	var _val_beast_draw_x = x + _val_vfx_offset_x;
	var _val_beast_draw_y = y + _val_vfx_offset_y;

	//------------------//
	//REFRESH FORM DRAW//
	//------------------//
	scr_battle_refresh_beast_form_draw(self);

	_val_scale_x *= _val_beast_draw_scale_multiplier;
	_val_scale_y *= _val_beast_draw_scale_multiplier;

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
	if (_flag_mouse_hover){

		_val_scale_x *= 1.15;
		_val_scale_y *= 1.15;

		_flag_preview_beast = keyboard_check(vk_lcontrol);

		//---------------------//
		//PRISM TARGETING ICON//
		//---------------------//
		if (
			_flag_state_select_prism_target &&
			_str_team == "ENEMY" &&
			_str_list == "ALIVE" &&
			_val_cur_hp > 0
		){
			draw_sprite(spr_battle_icon_target_hover,0,x,y - 50);
		}

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

			var _val_tame_chance = scr_battle_get_prism_tame_chance(
				obj_battle_player_controller._stct_selected_prism._str_item_id,
				self
			);

			draw_set_font(fnt_gui_small);
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

	//----------------//
	//CASTER PREVIEW//
	//----------------//
	if (
		_flag_state_select_caster &&
		_str_team == "PLAYER" &&
		_str_list == "ALIVE" &&
		_val_cur_hp > 0
	){

		//------------------//
		//VALID CASTER ICON//
		//------------------//
		var _flag_valid_caster = (
			_flag_beast_color_check &&
			_flag_beast_able_check &&
			_flag_beast_archetype_check &&
			_flag_beast_class_check
		);

		if (_flag_valid_caster){
			draw_sprite(spr_battle_icon_caster_hover,0,x,y - 50);
		}

		//-------------------//
		//CASTER STAT RATING//
		//-------------------//
		if (
			instance_exists(global.ref_cast_card) &&
			is_struct(global.ref_cast_card._ref_card)
		){

			var _str_caster_preview = scr_battle_get_card_caster_preview(
				global.ref_cast_card._ref_card,
				self
			);

			if (_str_caster_preview != ""){

				draw_set_font(fnt_gui_small);
				draw_set_colour(c_black);
				draw_set_halign(fa_center);
				draw_set_valign(fa_top);

				draw_text(x,y - 115,_str_caster_preview);

				draw_set_halign(fa_left);
				draw_set_valign(fa_top);
			}
		}
	}

	//----------------//
	//TARGET PREVIEW//
	//----------------//
	if (
		_flag_state_select_card_target &&
		_str_list == "ALIVE" &&
		_val_cur_hp > 0 &&
		_flag_beast_range_check &&
		instance_exists(global.ref_cast_card) &&
		is_struct(global.ref_cast_card._ref_card)
	){

		var _str_target_preview = scr_battle_get_card_target_preview(
			global.ref_cast_card._ref_card,
			self
		);

		if (_str_target_preview != ""){

			draw_set_font(fnt_gui_small);
			draw_set_colour(c_black);
			draw_set_halign(fa_center);
			draw_set_valign(fa_top);

			draw_text(x,y - 115,_str_target_preview);

			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
		}
	}

	//--------//
	//SHADOW//
	//--------//
	var _spr_shadow = scr_beast_get_type_shadow(_ref_unit._str_beast_color_type);

	draw_sprite_ext(
		_spr_shadow,
		0,
		x,
		y + 40,
		1.5,
		1.5,
		0,
		c_white,
		1
	);

	//-------------//
	//BEAST SPRITE//
	//-------------//
	if (_val_cur_hp <= 0){

		draw_sprite_ext(
			_spr_beast,
			0,
			_val_beast_draw_x,
			_val_beast_draw_y,
			_val_scale_x,
			_val_scale_y,
			_val_vfx_angle,
			c_ltgray,
			1
		);

		draw_sprite(spr_battle_beast_dead,0,x,y);
	}

	//--------------------//
	//INVALID CASTER GREY//
	//--------------------//
	else if (
		_flag_state_select_caster &&
		(
			!_flag_beast_able_check ||
			!_flag_beast_color_check ||
			!_flag_beast_archetype_check ||
			!_flag_beast_class_check
		)
	){

		draw_sprite_ext(
			_spr_beast,
			0,
			_val_beast_draw_x,
			_val_beast_draw_y,
			_val_scale_x,
			_val_scale_y,
			_val_vfx_angle,
			c_ltgray,
			1
		);
	}

	//--------------------//
	//INVALID TARGET GREY//
	//--------------------//
	else if (_flag_state_select_any_target && !_flag_beast_range_check){

		draw_sprite_ext(
			_spr_beast,
			0,
			_val_beast_draw_x,
			_val_beast_draw_y,
			_val_scale_x,
			_val_scale_y,
			_val_vfx_angle,
			c_ltgray,
			1
		);
	}

	//-------------//
	//NORMAL BEAST//
	//-------------//
	else{

		draw_sprite_ext(
			_spr_beast,
			0,
			_val_beast_draw_x,
			_val_beast_draw_y,
			_val_scale_x,
			_val_scale_y,
			_val_vfx_angle,
			_c_beast_draw_tint,
			1
		);
	}

	//-------------------//
	//RESET CASTER CHECKS//
	//-------------------//
	if (!_flag_state_select_caster){

		_flag_beast_color_check = true;
		_flag_beast_archetype_check = true;
		_flag_beast_class_check = true;
		_flag_beast_able_check = true;
	}

	//------------------//
	//RESET RANGE CHECK//
	//------------------//
	if (!_flag_state_select_any_target){
		_flag_beast_range_check = true;
	}

	#endregion

	#region HP BAR

	//---------------//
	//BAR DIMENSIONS//
	//---------------//
	var _val_bar_w = 96;
	var _val_bar_h = 10;

	var _val_bar_x1 = x - (_val_bar_w * 0.5);
	var _val_bar_y1 = y - 70;

	var _val_bar_x2 = _val_bar_x1 + _val_bar_w;
	var _val_bar_y2 = _val_bar_y1 + _val_bar_h;

	//------------//
	//BACKGROUND//
	//------------//
	draw_set_colour(c_red);
	draw_rectangle(_val_bar_x1,_val_bar_y1,_val_bar_x2,_val_bar_y2,false);

	//-------------//
	//SECOND LIFE//
	//-------------//
	var _ref_second_life = scr_status_check("SECOND_LIFE",self);

	if (_ref_second_life != -1){

		draw_set_font(fnt_gui_small);
		draw_set_colour(c_black);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);

		draw_text(
			_val_bar_x1 - 16,
			_val_bar_y1 + (_val_bar_h * 0.5),
			"X2"
		);

		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
	}

	//-------//
	//HP FILL//
	//-------//
	var _val_hp_fill = clamp(_val_cur_hp / max(1,_val_max_hp),0,1);

	draw_set_colour(c_green);

	draw_rectangle(
		_val_bar_x1,
		_val_bar_y1,
		_val_bar_x1 + (_val_bar_w * _val_hp_fill),
		_val_bar_y2,
		false
	);

	//------------//
	//OVERHEALTH//
	//------------//
	if (_val_overhealth > 0){

		var _ct_pip = min(ceil(_val_overhealth / 5),10);

		var _val_pip_size = 8;
		var _val_pip_gap = 1;

		var _val_pip_x = _val_bar_x1 + 2;
		var _val_pip_y = _val_bar_y1 + 1;

		for (var _it_pip = 0; _it_pip < _ct_pip; _it_pip++){

			var _val_pip_draw_x =
				_val_pip_x +
				(_it_pip * (_val_pip_size + _val_pip_gap));

			draw_set_colour(c_lime);

			draw_rectangle(
				_val_pip_draw_x,
				_val_pip_y,
				_val_pip_draw_x + _val_pip_size,
				_val_pip_y + _val_pip_size,
				false
			);

			draw_set_colour(c_black);

			draw_rectangle(
				_val_pip_draw_x,
				_val_pip_y,
				_val_pip_draw_x + _val_pip_size,
				_val_pip_y + _val_pip_size,
				true
			);
		}
	}

	//-----------//
	//BAR BORDER//
	//-----------//
	draw_set_colour(c_black);
	draw_rectangle(_val_bar_x1,_val_bar_y1,_val_bar_x2,_val_bar_y2,true);

	//-------//
	//HP TEXT//
	//-------//
	draw_set_font(fnt_gui_small);
	draw_set_colour(c_black);

	var _str_hp_text = string(_val_cur_hp);

	if (_val_overhealth > 0){
		_str_hp_text += " (+" + string(_val_overhealth) + ")";
	}

	_str_hp_text += "/" + string(_val_max_hp);

	draw_text(
		x - (string_width(_str_hp_text) * 0.5),
		_val_bar_y1 - 16,
		_str_hp_text
	);

	#endregion

	#region ARMOR

	//------------//
	//DRAW ARMOR//
	//------------//
	if (_val_armor > 0){

		draw_set_font(fnt_gui_small);
		draw_set_colour(c_white);

		var _val_armor_icon_x = _val_bar_x2 - 16;
		var _val_armor_icon_y = _val_bar_y2 + 16;

		draw_sprite(spr_battle_icon_armor,0,_val_armor_icon_x,_val_armor_icon_y);

		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);

		draw_text(_val_armor_icon_x,_val_armor_icon_y,string(_val_armor));

		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
	}

	#endregion

	#region TARGETING ICONS

	//------------------------------//
	//CASTER ICON WHILE TARGETING//
	//------------------------------//
	if (_flag_state_select_card_target && self == global.ref_caster_beast){
		draw_sprite(spr_battle_icon_caster_hover,0,x,y - 50);
	}

	//-------------------//
	//TARGET PREVIEW ICON//
	//-------------------//
	if (
		_flag_state_select_card_target &&
		_str_list == "ALIVE" &&
		_val_cur_hp > 0
	){

		var _arr_target_preview = obj_battle_player_controller._arr_target_preview;

		for (var _it_preview = 0; _it_preview < array_length(_arr_target_preview); _it_preview++){

			if (_arr_target_preview[_it_preview] == id){
				draw_sprite(spr_battle_icon_target_hover,0,x,y - 50);
				break;
			}
		}
	}

	#endregion

	#region SELECTION

	//----------------//
	//CASTER SELECTION//
	//----------------//
	if (global.ref_caster_beast == self){

		draw_set_colour(c_black);

		draw_rectangle(
			x - 70,
			y - 90,
			x + 70,
			y + 90,
			true
		);
	}

	//----------------//
	//TARGET SELECTION//
	//----------------//
	if (global.ref_target_beast == self){

		draw_set_colour(c_black);

		draw_rectangle(
			x - 75,
			y - 95,
			x + 75,
			y + 95,
			true
		);
	}

	#endregion
}