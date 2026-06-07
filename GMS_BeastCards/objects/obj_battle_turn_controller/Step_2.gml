if (!instance_exists(obj_gui_end_battle_pane)){
//
// CHECK WIN CONDITIONS
//
if (_flag_game_start){
	
	if (_flag_started_game == false){
		_flag_started_game = true;
		_player_controller._player_state = PLAYER_STATE.TURN_START;
	}

	//(FUTURE) QUEST WIN CONDITIONS

	#region PLAYER TEAM DEAD
		if(ds_list_size(_player_controller._beasts_alive) < 1){
			if (_flag_battle_ended == false){
				_flag_battle_ended = true;
				obj_battle_player_controller._player_state = PLAYER_STATE.WAIT;
				obj_battle_enemy_controller._enemy_state = ENEMY_STATE.WAIT;
				var _end_gui = instance_create_layer(room_width/2,room_height/2,"ily_fx",obj_gui_end_battle_pane);
				
				_end_gui._condition = "LOSS";
			}
		}
	#endregion

	#region ENEMY TEAM DEAD
		if(ds_list_size(_enemy_controller._beasts_alive) < 1){
			if (_flag_battle_ended == false){
				_flag_battle_ended = true;
				obj_battle_player_controller._player_state = PLAYER_STATE.WAIT;
				obj_battle_enemy_controller._enemy_state = ENEMY_STATE.WAIT;
				var _end_gui = instance_create_layer(room_width/2,room_height/2,"ily_fx",obj_gui_end_battle_pane);
				
				_end_gui._condition = "WIN";
			}
		}
	#endregion
}
}