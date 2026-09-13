//===============================================================================//
//
// DRAW GUI: OBJ_BATTLE_PLAYER_CONTROLLER
// FUNCTION: Draws the player battle HUD.
//           Displays Mana, Card-pile counts, Card/caster targeting lines,
//           Global Card feedback, and Ctrl-held casting requirements.
//
// USES:     Player battle Mana/Card state, active Card/caster context,
//           Mana HUD positioning, and player targeting state.
//
//===============================================================================//

if (!instance_exists(obj_gui_end_battle_pane)){

	#region MANA HUD

	//----------------------//
	//REFRESH MANA POSITIONS//
	//----------------------//
	if (array_length(_arr_mana_positions) != _val_max_mana){
		scr_battle_reposition_mana();
	}

	//-------------------//
	//GET DISPLAYED MANA//
	//-------------------//
	var _val_display_mana = clamp(_val_cur_mana,0,_val_max_mana);

	//----------------//
	//DRAW MANA ORBS//
	//----------------//
	for (var _it_mana = 0; _it_mana < array_length(_arr_mana_positions); _it_mana++){

		var _stct_mana_position = _arr_mana_positions[_it_mana];

		//---------------//
		//GET ORB FRAME//
		//---------------//
		var _it_mana_frame = (_it_mana < _val_display_mana) ? 0 : 1;

		//---------//
		//DRAW ORB//
		//---------//
		draw_sprite_ext(
			spr_battle_mana_orb,
			_it_mana_frame,
			_stct_mana_position._val_x,
			_stct_mana_position._val_y,
			_val_mana_orb_scale,
			_val_mana_orb_scale,
			0,
			c_white,
			1
		);
	}

	#endregion

	#region CARD PILE COUNTS

	//------------------//
	//DRAW PILE COUNTS//
	//------------------//
	draw_set_font(fnt_gui_small);

	draw_text(50,800,"DCK: " + string(ds_list_size(_list_battle_deck)));
	draw_text(200,800,"HND: " + string(ds_list_size(_list_battle_hand)));
	draw_text(880,800,"DIS: " + string(ds_list_size(_list_battle_discard)));
	draw_text(950,800,"EXH: " + string(ds_list_size(_list_battle_exhaust)));

	#endregion

	#region CARD TO MOUSE

	//--------------------//
	//DRAW CARD TO MOUSE//
	//--------------------//
	if (
		_state_player == ENUM_PLAYER_STATE.SELECT_CASTER &&
		instance_exists(global.ref_cast_card)
	){

		draw_set_colour(c_black);

		draw_line(
			global.ref_cast_card.x,
			global.ref_cast_card.y,
			device_mouse_x_to_gui(0),
			device_mouse_y_to_gui(0)
		);
	}

	#endregion

	#region CASTER TO MOUSE

	//----------------------//
	//DRAW CASTER TO MOUSE//
	//----------------------//
	if (
		_state_player == ENUM_PLAYER_STATE.SELECT_TARGET &&
		instance_exists(global.ref_cast_card) &&
		instance_exists(global.ref_caster_beast) &&
		is_struct(global.ref_cast_card._ref_card)
	){

		draw_set_colour(c_black);

		draw_line(
			global.ref_cast_card.x,
			global.ref_cast_card.y,
			global.ref_caster_beast.x,
			global.ref_caster_beast.y
		);

		draw_line(
			global.ref_caster_beast.x,
			global.ref_caster_beast.y,
			device_mouse_x_to_gui(0),
			device_mouse_y_to_gui(0)
		);

		var _str_card_range = global.ref_cast_card._ref_card._str_card_range;

		//------------------//
		//GLOBAL CARD PROMPT//
		//------------------//
		if (_str_card_range == "GLOBAL"){

			var _val_mouse_x = device_mouse_x_to_gui(0);
			var _val_mouse_y = device_mouse_y_to_gui(0);
			var _str_global_prompt = "CLICK TO CAST GLOBAL CARD";

			draw_set_colour(c_black);
			draw_set_font(fnt_gui_small);
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);

			draw_text(
				_val_mouse_x - (string_width(_str_global_prompt) * 0.5),
				_val_mouse_y - 15,
				_str_global_prompt
			);
		}
	}

	#endregion

	#region CTRL INSPECTION PANE

	//----------------------//
	//CHECK INSPECTION PANE//
	//----------------------//
	if (
		keyboard_check(vk_lcontrol) &&
		(
			_state_player == ENUM_PLAYER_STATE.SELECT_CASTER ||
			_state_player == ENUM_PLAYER_STATE.SELECT_TARGET
		) &&
		!position_meeting(
			device_mouse_x_to_gui(0),
			device_mouse_y_to_gui(0),
			obj_battle_card
		) &&
		instance_exists(global.ref_cast_card) &&
		is_struct(global.ref_cast_card._ref_card)
	){

		var _val_pane_x1 = room_width * 0.5 - 180;
		var _val_pane_x2 = room_width * 0.5 + 180;
		var _val_pane_y1 = 750;
		var _val_pane_y2 = 850;

		var _stct_card = global.ref_cast_card._ref_card;

		//-------------//
		//DRAW PANE//
		//-------------//
		draw_set_font(fnt_gui_small);

		draw_set_colour(c_dkgray);
		draw_rectangle(_val_pane_x1,_val_pane_y1,_val_pane_x2,_val_pane_y2,false);

		draw_set_colour(c_black);
		draw_rectangle(_val_pane_x1,_val_pane_y1,_val_pane_x2,_val_pane_y2,true);

		draw_set_colour(c_white);

		//--------------------//
		//CASTER REQUIREMENTS//
		//--------------------//
		if (_state_player == ENUM_PLAYER_STATE.SELECT_CASTER){

			var _arr_card_colors = _stct_card._arr_card_colors;
			var _str_card_archetype = _stct_card._str_card_archetype_req;
			var _str_card_class = _stct_card._str_card_class_req;

			draw_text(_val_pane_x1 + 10,_val_pane_y1 + 10,"REQUIREMENTS TO CAST:");
			draw_text(_val_pane_x1 + 10,_val_pane_y1 + 30,"COLOR(S): " + string(_arr_card_colors));
			draw_text(_val_pane_x1 + 10,_val_pane_y1 + 50,"ARCHETYPE: " + string(_str_card_archetype));
			draw_text(_val_pane_x1 + 10,_val_pane_y1 + 70,"CLASS: " + string(_str_card_class));
		}

		//--------------------//
		//TARGET REQUIREMENTS//
		//--------------------//
		if (_state_player == ENUM_PLAYER_STATE.SELECT_TARGET){

			var _str_card_range = _stct_card._str_card_range;

			draw_text(_val_pane_x1 + 10,_val_pane_y1 + 10,"REQUIREMENTS TO CAST:");
			draw_text(_val_pane_x1 + 10,_val_pane_y1 + 30,"RANGE: " + string(_str_card_range));
		}
	}

	#endregion
}