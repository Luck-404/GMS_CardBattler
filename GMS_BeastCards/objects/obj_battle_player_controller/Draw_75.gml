//===============================================================================//
//
// DRAW GUI END: OBJ_BATTLE_PLAYER_CONTROLLER
// FUNCTION: Draws late-layer battle interaction UI.
//           Displays the Prism button/menu, corpse-selection feedback,
//           and the selected-Prism targeting line above normal battle GUI.
//
// USES:     Player targeting state, Prism selection, corpse availability,
//           battle Card context, and local Prism drawing helpers.
//
//===============================================================================//

//----------------//
//END BATTLE HIDE//
//----------------//
if (instance_exists(obj_gui_end_battle_pane)){
	exit;
}

#region PRISM UI

//----------------//
//DRAW PRISM UI//
//----------------//
hscr_battle_draw_prism_button();
hscr_battle_draw_prism_menu();

#endregion

#region CORPSE TARGETING

//--------------------------//
//DRAW CORPSE TARGETING UI//
//--------------------------//
if (
	_state_player == ENUM_PLAYER_STATE.SELECT_CORPSE &&
	instance_exists(global.ref_cast_card) &&
	is_struct(global.ref_cast_card._ref_card)
){

	var _val_mouse_x = device_mouse_x_to_gui(0);
	var _val_mouse_y = device_mouse_y_to_gui(0);

	var _stct_corpse_card = global.ref_cast_card._ref_card;

	//--------------------//
	//GET HOVERED CORPSE//
	//--------------------//
	var _ref_hovered_corpse = instance_position(
		_val_mouse_x,
		_val_mouse_y,
		obj_battle_beast
	);

	var _flag_valid_corpse =
		instance_exists(_ref_hovered_corpse) &&
		_ref_hovered_corpse._str_list == "DEAD" &&
		_ref_hovered_corpse._val_cur_hp <= 0 &&
		!_ref_hovered_corpse._flag_captured &&
		!_ref_hovered_corpse._flag_corpse_consumed;

	//-------------------------//
	//CHECK EMPTY TARGET OPTION//
	//-------------------------//
	var _flag_allow_empty_target = !scr_battle_has_corpse();

	if (variable_struct_exists(_stct_corpse_card,"_flag_allow_empty_corpse_target")){
		_flag_allow_empty_target =
			_flag_allow_empty_target ||
			_stct_corpse_card._flag_allow_empty_corpse_target;
	}

	//----------------//
	//BUILD TOOLTIP//
	//----------------//
	var _str_corpse_tooltip = "";

	if (_flag_valid_corpse){
		_str_corpse_tooltip = "EXPEND CORPSE";
	}
	else if (
		!instance_exists(_ref_hovered_corpse) &&
		_flag_allow_empty_target &&
		!position_meeting(_val_mouse_x,_val_mouse_y,obj_battle_card) &&
		!position_meeting(_val_mouse_x,_val_mouse_y,obj_battle_end_turn_button)
	){
		_str_corpse_tooltip = "SACRIFICE HP";
	}

	//----------------//
	//DRAW TOOLTIP//
	//----------------//
	if (_str_corpse_tooltip != ""){

		draw_set_font(fnt_gui_small);
		draw_set_colour(c_black);
		draw_set_halign(fa_center);
		draw_set_valign(fa_top);

		draw_text(_val_mouse_x,_val_mouse_y - 20,_str_corpse_tooltip);

		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
	}
}

#endregion

#region PRISM TO MOUSE

//----------------------//
//DRAW PRISM TO MOUSE//
//----------------------//
if (
	_state_player == ENUM_PLAYER_STATE.SELECT_PRISM_TARGET &&
	_stct_selected_prism != undefined
){

	var _val_prism_center_x = (_val_prism_button_x1 + _val_prism_button_x2) * 0.5;
	var _val_prism_center_y = (_val_prism_button_y1 + _val_prism_button_y2) * 0.5;

	var _val_mouse_x = device_mouse_x_to_gui(0);
	var _val_mouse_y = device_mouse_y_to_gui(0);

	draw_set_colour(c_black);

	draw_line(
		_val_prism_center_x,
		_val_prism_center_y,
		_val_mouse_x,
		_val_mouse_y
	);

	draw_set_font(fnt_gui_small);
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);

	draw_text(_val_mouse_x,_val_mouse_y - 20,"SELECT ENEMY");

	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}

#endregion