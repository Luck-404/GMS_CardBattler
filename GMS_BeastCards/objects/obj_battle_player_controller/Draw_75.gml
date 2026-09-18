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

//-----------------------//
//PRISM HOVER HIGHLIGHT//
//-----------------------//
var _val_prism_mouse_x = device_mouse_x_to_gui(0);
var _val_prism_mouse_y = device_mouse_y_to_gui(0);
var _flag_prism_hover = hscr_battle_is_mouse_in_box(
    _val_prism_mouse_x,_val_prism_mouse_y,
    _val_prism_button_x1,_val_prism_button_y1,
    _val_prism_button_x2,_val_prism_button_y2
);
var _flag_prism_active = (
    _state_player == ENUM_PLAYER_STATE.SELECT_PRISM ||
    _state_player == ENUM_PLAYER_STATE.SELECT_PRISM_TARGET
);
if (_flag_prism_hover || _flag_prism_active){
    draw_set_colour(_flag_prism_active ? c_yellow : c_white);
    draw_rectangle(_val_prism_button_x1,_val_prism_button_y1,_val_prism_button_x2,_val_prism_button_y2,true);
    draw_set_colour(c_white);
}


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

	//====================//
	//GET HOVERED BEAST//
	//====================//
	var _ref_hovered_beast = instance_position(
		_val_mouse_x,
		_val_mouse_y,
		obj_battle_beast
	);

	//====================//
	//CHECK VALID CORPSE//
	//====================//
	var _flag_valid_corpse = (
		instance_exists(_ref_hovered_beast) &&
		_ref_hovered_beast._str_list == "DEAD" &&
		_ref_hovered_beast._val_cur_hp <= 0 &&
		!_ref_hovered_beast._flag_captured &&
		!_ref_hovered_beast._flag_corpse_consumed
	);

	//=======================//
	//OPTIONAL TARGET RULES//
	//=======================//
	var _flag_allow_empty_target =
		!scr_battle_has_corpse();

	if (
		variable_struct_exists(
			_stct_corpse_card,
			"_flag_allow_empty_corpse_target"
		)
	){

		_flag_allow_empty_target =
			_flag_allow_empty_target ||
			_stct_corpse_card._flag_allow_empty_corpse_target;
	}

	//=====================//
	//CANCEL DESTINATION//
	//=====================//
	var _flag_cancel_to_card_select = false;

	if (
		variable_struct_exists(
			_stct_corpse_card,
			"_flag_corpse_cancel_to_card_select"
		)
	){

		_flag_cancel_to_card_select =
			_stct_corpse_card._flag_corpse_cancel_to_card_select;
	}

	//================//
	//BUILD TOOLTIP//
	//================//
	var _str_global_prompt = "";

	if (_flag_valid_corpse){

		_str_global_prompt = "LEFT CLICK: SACRIFICE CORPSE";
	}
	else if (
		_stct_corpse_card._str_card_range == "CORPSE_OPTIONAL" &&
		_flag_allow_empty_target
	){

		_str_global_prompt = "LEFT CLICK: SACRIFICE 10 HP";
	}
	else{

		_str_global_prompt = "SELECT A CORPSE";
	}

	if (_flag_cancel_to_card_select){
		_str_global_prompt += "  |  RIGHT CLICK: RETURN TO CARDS";
	}
	else{
		_str_global_prompt += "  |  RIGHT CLICK: BACK";
	}

	//================//
	//DRAW TOOLTIP//
	//================//
	draw_set_colour(c_maroon);
	draw_set_font(fnt_gui_small);
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);

	draw_text(
		_val_mouse_x,
		_val_mouse_y - 15,
		_str_global_prompt
	);

	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
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


#region CARD PILE TOOLTIPS

//----------------//
//CHECK PILE HOVER//
//----------------//
var _val_pile_mouse_x = device_mouse_x_to_gui(0);
var _val_pile_mouse_y = device_mouse_y_to_gui(0);
var _str_pile_tooltip = "";

if (hscr_battle_is_mouse_in_box(_val_pile_mouse_x,_val_pile_mouse_y,10,857,85,932)){
    _str_pile_tooltip = "INVENTORY";
}
else if (hscr_battle_is_mouse_in_box(_val_pile_mouse_x,_val_pile_mouse_y,10,969,85,1044)){
    _str_pile_tooltip = "DECK";
}
else if (hscr_battle_is_mouse_in_box(_val_pile_mouse_x,_val_pile_mouse_y,971,857,1046,932)){
    _str_pile_tooltip = "DISCARD";
}
else if (hscr_battle_is_mouse_in_box(_val_pile_mouse_x,_val_pile_mouse_y,971,969,1046,1044)){
    _str_pile_tooltip = "EXHAUST";
}

//----------------//
//DRAW TOOLTIP//
//----------------//
if (_str_pile_tooltip != ""){
    draw_set_font(fnt_gui_small);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);

    var _val_tip_x = min(_val_pile_mouse_x + 5,room_width - string_width(_str_pile_tooltip) - 10);
    var _val_tip_y = max(0,_val_pile_mouse_y - 5 - string_height(_str_pile_tooltip));
    var _val_tip_w = string_width(_str_pile_tooltip) + 12;
    var _val_tip_h = string_height(_str_pile_tooltip) + 8;

    draw_set_colour(global.c_dk_gray);
    draw_rectangle(_val_tip_x - 4,_val_tip_y - 4,_val_tip_x + _val_tip_w,_val_tip_y + _val_tip_h,false);
    draw_set_colour(c_white);
    draw_rectangle(_val_tip_x - 4,_val_tip_y - 4,_val_tip_x + _val_tip_w,_val_tip_y + _val_tip_h,true);
    draw_text(_val_tip_x + 2,_val_tip_y + 1,_str_pile_tooltip);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

#endregion
