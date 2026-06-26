//===============================================================================//
//
// DRAW GUI: OBJ_BATTLE_PLAYER_CONTROLLER
// FUNCTION: Draws player battle HUD information.
//           Displays mana, echo count, card pile counts, selection lines,
//           and ctrl inspection data.
//
//===============================================================================//

if (!instance_exists(obj_gui_end_battle_pane)){

	#region MANA COUNTER
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_colour(c_black);
	draw_set_font(fnt_large_gui);

	draw_text(50,50,"MANA: " + string(_val_cur_mana) + "/" + string(_val_max_mana));
	#endregion

	#region ECHO COUNTER
	if (global.ct_echo != 0){
		draw_text(50,150,"ECHO: " + string(global.ct_echo));
	}
	#endregion

	#region CARD PILE COUNTS
	draw_set_font(fnt_small_gui);

	draw_text(50,800,"DCK: " + string(ds_list_size(_list_battle_deck)));
	draw_text(200,800,"HND: " + string(ds_list_size(_list_battle_hand)));
	draw_text(880,800,"DIS: " + string(ds_list_size(_list_battle_discard)));
	draw_text(950,800,"EXH: " + string(ds_list_size(_list_battle_exhaust)));
	#endregion

	#region CARD TO MOUSE
	if (_player_state == PLAYER_STATE.SELECT_CASTER){
		draw_set_colour(c_black);
		draw_line(global.ref_cast_card.x,global.ref_cast_card.y,device_mouse_x_to_gui(0),device_mouse_y_to_gui(0));
	}
	#endregion

	#region CASTER TO MOUSE
	if (_player_state == PLAYER_STATE.SELECT_TARGET){
		draw_set_colour(c_black);

		draw_line(global.ref_cast_card.x,global.ref_cast_card.y,global.ref_caster_beast.x,global.ref_caster_beast.y);
		draw_line(global.ref_caster_beast.x,global.ref_caster_beast.y,device_mouse_x_to_gui(0),device_mouse_y_to_gui(0));

		var _str_card_range = global.ref_cast_card._ref_card._str_card_range;

		if (_str_card_range == "GLOBAL"){
			draw_set_colour(c_black);
			draw_set_font(fnt_small_gui);
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);

			draw_text(device_mouse_x_to_gui(0) - string_width("CLICK TO CAST GLOBAL CARD") * 0.5,device_mouse_y_to_gui(0) - 15,"CLICK TO CAST GLOBAL CARD");
		}
	}
	#endregion

	#region CTRL INSPECTION PANE
	if (keyboard_check(vk_lcontrol) && (_player_state == PLAYER_STATE.SELECT_CASTER || _player_state == PLAYER_STATE.SELECT_TARGET) && !position_meeting(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),obj_battle_card)){

		var _val_x1 = room_width * 0.5 - 180;
		var _val_x2 = room_width * 0.5 + 180;
		var _val_y1 = 750;
		var _val_y2 = 850;

		draw_set_font(fnt_small_gui);

		draw_set_colour(c_dkgray);
		draw_rectangle(_val_x1,_val_y1,_val_x2,_val_y2,false);

		draw_set_colour(c_black);
		draw_rectangle(_val_x1,_val_y1,_val_x2,_val_y2,true);

		draw_set_colour(c_white);

		var _stct_card = global.ref_cast_card._ref_card;

		if (_player_state == PLAYER_STATE.SELECT_CASTER){
			var _arr_colors = _stct_card._arr_card_colors;
			var _str_archetype = _stct_card._str_card_archetype_req;
			var _str_class = _stct_card._str_card_class_req;

			draw_text(_val_x1 + 10,_val_y1 + 10,"REQUIREMENTS TO CAST:");
			draw_text(_val_x1 + 10,_val_y1 + 30,"COLOR(S): " + string(_arr_colors));
			draw_text(_val_x1 + 10,_val_y1 + 50,"ARCHETYPE: " + string(_str_archetype));
			draw_text(_val_x1 + 10,_val_y1 + 70,"CLASS: " + string(_str_class));
		}

		if (_player_state == PLAYER_STATE.SELECT_TARGET){
			var _str_range = _stct_card._str_card_range;

			draw_text(_val_x1 + 10,_val_y1 + 10,"REQUIREMENTS TO CAST:");
			draw_text(_val_x1 + 10,_val_y1 + 30,"RANGE: " + string(_str_range));
		}
	}
	#endregion
}