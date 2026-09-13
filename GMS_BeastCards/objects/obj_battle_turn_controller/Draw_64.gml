//===============================================================================//
//
// DRAW GUI: OBJ_BATTLE_TURN_CONTROLLER
// FUNCTION: Draws the current battle turn indicator.
//           Shows the End Turn button during player turns and hides it during
//           enemy turns. Highlights End Turn when the player has no Mana.
//
//===============================================================================//

if (!instance_exists(obj_gui_end_battle_pane)){

	#region TURN DISPLAY

	//----------------//
	//DRAW TURN LABEL//
	//----------------//
	var _str_turn_text = "";

	switch(_val_turn_tracker){

		case 0:
			_str_turn_text = "PLAYER TURN";
		break;

		case 1:
			_str_turn_text = "ENEMY TURN";
		break;
	}

	draw_set_colour(c_black);
	draw_set_font(fnt_gui_large);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);

	draw_text(
		room_width * 0.5 - (string_width(_str_turn_text) * 0.5),
		100,
		_str_turn_text
	);

	#endregion

	#region END TURN BUTTON

	//----------------------//
	//PLAYER END TURN BUTTON//
	//----------------------//
	if (_val_turn_tracker == 0){

		_ref_end_turn_button.visible = true;

		//----------------//
		//NO MANA PROMPT//
		//----------------//
		if (_ref_player_controller._val_cur_mana == 0){

			draw_sprite(
				spr_battle_end_turn_button_highlight,
				0,
				_ref_end_turn_button.x,
				_ref_end_turn_button.y
			);
		}
	}

	//---------------------//
	//ENEMY END TURN HIDE//
	//---------------------//
	else{
		_ref_end_turn_button.visible = false;
	}

	#endregion
}