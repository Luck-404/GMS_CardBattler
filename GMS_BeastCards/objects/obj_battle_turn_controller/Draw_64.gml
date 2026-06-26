//===============================================================================//
//
// DRAW GUI: OBJ_BATTLE_TURN_CONTROLLER
// FUNCTION: Draws current turn text.
//           Shows the end-turn button during player turns.
//           Hides the end-turn button during enemy turns.
//
//===============================================================================//

if (!instance_exists(obj_gui_end_battle_pane)){

	switch(_val_turn_tracker){

		#region PLAYER TURN
		case 0:
			draw_set_colour(c_black);
			draw_set_font(fnt_large_gui);
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);

			draw_text(room_width * 0.5 - (string_width("PLAYER TURN") * 0.5),100,"PLAYER TURN");

			if (_ref_player_controller._val_cur_mana == 0){
				draw_sprite(spr_battle_end_turn_button_highlight,0,_ref_end_turn_button.x,_ref_end_turn_button.y);
			}

			_ref_end_turn_button.visible = true;
		break;
		#endregion

		#region ENEMY TURN
		case 1:
			draw_set_colour(c_black);
			draw_set_font(fnt_large_gui);
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);

			draw_text(room_width * 0.5 - (string_width("ENEMY TURN") * 0.5),100,"ENEMY TURN");

			_ref_end_turn_button.visible = false;
		break;
		#endregion
	}
}