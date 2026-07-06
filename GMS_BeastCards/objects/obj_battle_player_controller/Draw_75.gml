//===============================================================================//
//
// DRAW GUI END: OBJ_BATTLE_PLAYER_CONTROLLER
// FUNCTION: Draws late-layer battle prism UI.
//           Displays the prism button, prism menu, and selected-prism targeting line.
//           Hides prism UI while the end battle pane is open.
//
//===============================================================================//

//----------------//
//END BATTLE HIDE//
//----------------//
if (instance_exists(obj_gui_end_battle_pane)){
	exit;
}

//-------------//
//PRISM BUTTON//
//-------------//
#region PRISM BUTTON
hscr_draw_prism_button();
hscr_draw_prism_menu();
#endregion

//---------------//
//PRISM TO MOUSE//
//---------------//
#region PRISM TO MOUSE
if (_state_player == ENUM_PLAYER_STATE.SELECT_PRISM_TARGET && _stct_selected_prism != undefined){

	var _val_button_center_x = (_val_prism_button_x1 + _val_prism_button_x2) * 0.5;
	var _val_button_center_y = (_val_prism_button_y1 + _val_prism_button_y2) * 0.5;

	draw_set_colour(c_black);
	draw_line(_val_button_center_x,_val_button_center_y,device_mouse_x_to_gui(0),device_mouse_y_to_gui(0));

	draw_set_font(fnt_small_gui);
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);

	draw_text(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0) - 20,"SELECT ENEMY");

	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}
#endregion