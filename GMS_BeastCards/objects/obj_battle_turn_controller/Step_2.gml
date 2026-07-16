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
	// BATTLE ENTRY TRIGGERS
	//
	#region BATTLE ENTRY TRIGGERS

	if (!_flag_entry_triggers_complete){

		var _flag_player_ready = (
			_ref_player_controller._state_player == ENUM_PLAYER_STATE.WAIT
		);

		var _flag_enemy_ready = (
			_ref_enemy_controller._state_enemy == ENUM_ENEMY_STATE.WAIT
		);

		//-------------------//
		//BUILD TRIGGER QUEUE//
		//-------------------//
		if (!_flag_entry_triggers_init && _flag_player_ready && _flag_enemy_ready){
			hscr_build_entry_trigger_queue();
		}

		//---------------------//
		//EXECUTE TRIGGER QUEUE//
		//---------------------//
		if (_flag_entry_triggers_init && !instance_exists(obj_wait)){

			if (ds_list_size(_list_entry_triggers) > 0){

				var _stct_trigger = ds_list_find_value(_list_entry_triggers,0);

				hscr_execute_entry_trigger(_stct_trigger);

				ds_list_delete(_list_entry_triggers,0);

				scr_init_battle_wait(60);
			}
			else{

				ds_list_destroy(_list_entry_triggers);
				_list_entry_triggers = undefined;

				_flag_entry_triggers_complete = true;
				_flag_game_start = true;
			}
		}
	}

	#endregion

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
				
				audio_play_sound(snd_battle_loss,0,false);
				
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
				
				audio_play_sound(snd_battle_victory,0,false);

				var _ref_end_gui = instance_create_layer(room_width * 0.5,room_height * 0.5,"ily_fx",obj_gui_end_battle_pane);
				_ref_end_gui._str_condition = "WIN";
			}
		}
		#endregion
	}
}