//===============================================================================//
//
// END STEP: OBJ_BATTLE_TURN_CONTROLLER
// FUNCTION: Processes battle-entry triggers, begins initiative once battle setup
//           is complete, and checks player/enemy battle-end conditions.
//           Logs the final result and opens the end-battle pane.
//
//===============================================================================//

if (!instance_exists(obj_gui_end_battle_pane)){

	#region BATTLE ENTRY TRIGGERS

	//----------------------//
	//PROCESS ENTRY TRIGGERS//
	//----------------------//
	if (!_flag_entry_triggers_complete){

		var _flag_player_ready =
			(_ref_player_controller._state_player == ENUM_PLAYER_STATE.WAIT);

		var _flag_enemy_ready =
			(_ref_enemy_controller._state_enemy == ENUM_ENEMY_STATE.WAIT);

		//-------------------//
		//BUILD TRIGGER QUEUE//
		//-------------------//
		if (
			!_flag_entry_triggers_init &&
			_flag_player_ready &&
			_flag_enemy_ready
		){
			hscr_battle_build_entry_trigger_queue();
		}

		//---------------------//
		//EXECUTE TRIGGER QUEUE//
		//---------------------//
		if (
			_flag_entry_triggers_init &&
			!instance_exists(obj_battle_wait)
		){

			if (ds_list_size(_list_entry_triggers) > 0){

				var _stct_trigger =
					ds_list_find_value(_list_entry_triggers,0);

				hscr_battle_execute_entry_trigger(_stct_trigger);

				ds_list_delete(_list_entry_triggers,0);

				scr_battle_init_wait(60);
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

	#region BATTLE START

	//----------------//
	//START BATTLE//
	//----------------//
	if (_flag_game_start && !_flag_started_game){

		_flag_started_game = true;

		hscr_battle_set_initial_turn_order();
	}

	#endregion

	#region BATTLE END

	//----------------//
	//CHECK BATTLE END//
	//----------------//
	if (_flag_game_start && !_flag_battle_ended){

		//----------------//
		//PLAYER TEAM DEAD//
		//----------------//
		if (!scr_battle_has_team_combatants("PLAYER")){

			_flag_battle_ended = true;

			_ref_player_controller._state_player =
				ENUM_PLAYER_STATE.WAIT;

			_ref_enemy_controller._state_enemy =
				ENUM_ENEMY_STATE.WAIT;

			//================//
			//DEBUG BATTLE END//
			//================//
			scr_debug_log(
				"BATTLE",
				"END",
				self,
				"BATTLE ENDED | RESULT: LOSS" +
				" | ROUND: " + string(_ct_round) +
				" | PLAYER ACTIVE: " + string(ds_list_size(_ref_player_controller._list_beasts_alive)) +
				" | PLAYER GRAVEYARD: " + string(ds_list_size(_ref_player_controller._list_beasts_graveyard)) +
				" | ENEMY ACTIVE: " + string(ds_list_size(_ref_enemy_controller._list_beasts_alive)) +
				" | ENEMY GRAVEYARD: " + string(ds_list_size(_ref_enemy_controller._list_beasts_graveyard)),
				"BATTLE",
				"OBJ_BATTLE_TURN_CONTROLLER:END_STEP"
			);

			audio_play_sound(
				snd_battle_loss,
				0,
				false
			);

			var _ref_end_battle_pane = instance_create_layer(
				room_width * 0.5,
				room_height * 0.5,
				"ily_fx",
				obj_gui_end_battle_pane
			);

			_ref_end_battle_pane._str_condition = "LOSS";
		}

		//---------------//
		//ENEMY TEAM DEAD//
		//---------------//
		else if (!scr_battle_has_team_combatants("ENEMY")){

			_flag_battle_ended = true;

			_ref_player_controller._state_player =
				ENUM_PLAYER_STATE.WAIT;

			_ref_enemy_controller._state_enemy =
				ENUM_ENEMY_STATE.WAIT;

			//================//
			//DEBUG BATTLE END//
			//================//
			scr_debug_log(
				"BATTLE",
				"END",
				self,
				"BATTLE ENDED | RESULT: WIN" +
				" | ROUND: " + string(_ct_round) +
				" | PLAYER ACTIVE: " + string(ds_list_size(_ref_player_controller._list_beasts_alive)) +
				" | PLAYER GRAVEYARD: " + string(ds_list_size(_ref_player_controller._list_beasts_graveyard)) +
				" | ENEMY ACTIVE: " + string(ds_list_size(_ref_enemy_controller._list_beasts_alive)) +
				" | ENEMY GRAVEYARD: " + string(ds_list_size(_ref_enemy_controller._list_beasts_graveyard)),
				"BATTLE",
				"OBJ_BATTLE_TURN_CONTROLLER:END_STEP"
			);

			audio_play_sound(
				snd_battle_victory,
				0,
				false
			);

			var _ref_end_battle_pane = instance_create_layer(
				room_width * 0.5,
				room_height * 0.5,
				"ily_fx",
				obj_gui_end_battle_pane
			);

			_ref_end_battle_pane._str_condition = "WIN";
		}
	}

	#endregion
}