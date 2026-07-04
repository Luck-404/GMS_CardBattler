//===============================================================================//
//
// END STEP: OBJ_BATTLE_TURN_CONTROLLER
// FUNCTION: Checks battle start and battle end conditions.
//           Starts the player turn once battle begins.
//           Opens the end battle pane on win or loss.
//
//===============================================================================//

if (!instance_exists(obj_gui_end_battle_pane)){

	//
	// CHECK WIN CONDITIONS
	//
	if (_flag_game_start){

		if (!_flag_started_game){
			_flag_started_game = true;
			_ref_player_controller._state_player = ENUM_PLAYER_STATE.TURN_START;
		}

		// PLAYER TEAM DEAD
		#region PLAYER TEAM DEAD
		if (ds_list_size(_ref_player_controller._list_beasts_alive) < 1){

			if (!_flag_battle_ended){
				_flag_battle_ended = true;

				_ref_player_controller._state_player = ENUM_PLAYER_STATE.WAIT;
				_ref_enemy_controller._state_enemy = ENUM_ENEMY_STATE.WAIT;

				var _ref_end_gui = instance_create_layer(room_width * 0.5,room_height * 0.5,"ily_fx",obj_gui_end_battle_pane);
				_ref_end_gui._str_condition = "LOSS";
			}
		}
		#endregion

		// ENEMY TEAM DEAD
		#region ENEMY TEAM DEAD
		if (ds_list_size(_ref_enemy_controller._list_beasts_alive) < 1){

			if (!_flag_battle_ended){
				_flag_battle_ended = true;

				_ref_player_controller._state_player = ENUM_PLAYER_STATE.WAIT;
				_ref_enemy_controller._state_enemy = ENUM_ENEMY_STATE.WAIT;

				var _ref_end_gui = instance_create_layer(room_width * 0.5,room_height * 0.5,"ily_fx",obj_gui_end_battle_pane);
				_ref_end_gui._str_condition = "WIN";
			}
		}
		#endregion
	}
}