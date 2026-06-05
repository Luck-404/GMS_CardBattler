//
//
// DRAW GUI: OBJ_BATTLE_TURN_CONTROLLER | HANDLE TRACKING PLAYER TURNS, ALSO CHECK FOR WIN CONDITIONS
//
//

//
// SWITCH BASED ON WHOSE TURN IT IS
//
switch(_turn_tracker){
	#region PLAYER
	case 0:
		draw_set_colour(c_black);
		draw_set_font(fnt_gui_large);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_text(room_width/2-(string_width("PLAYER TURN")/2), 100,"PLAYER TURN");
	
		if (_player_controller._cur_mana == 0){
			draw_sprite(spr_battle_button_end_turn_highlight,0,_end_turn_button.x,_end_turn_button.y);	
		}
		_end_turn_button.visible = true;
	break;
	#endregion
	
	#region ENEMY
	case 1:
		draw_set_colour(c_black);
		draw_set_font(fnt_gui_large);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_text(room_width/2-(string_width("ENEMY TURN")/2), 100,"ENEMY TURN");
		
		_end_turn_button.visible = false;
	break;
	#endregion
}


//
// CHECK WIN CONDITIONS
//
if (_flag_game_start){
	
	if (_flag_started_game = false){
		_flag_started_game=true;
		_player_controller._player_state = PLAYER_STATE.TURN_START;
	}

	//(FUTURE) QUEST WIN CONDITIONS

	#region PLAYER TEAM DEAD
		if(ds_list_size(_player_controller._beasts_alive) < 1){
			if (_flag_battle_ended == false){
				_flag_battle_ended = true;
				var _end_gui = instance_create_layer(room_width/2,room_height/2,"ily_fx",obj_gui_end_battle_pane);
				
				_end_gui._condition = "LOSS";
			}
		}
	#endregion

	#region ENEMY TEAM DEAD
		if(ds_list_size(_enemy_controller._beasts_alive) < 1){
			if (_flag_battle_ended == false){
				_flag_battle_ended = true;
				var _end_gui = instance_create_layer(room_width/2,room_height/2,"ily_fx",obj_gui_end_battle_pane);
				
				_end_gui._condition = "WIN";
			}
		}
	#endregion
}