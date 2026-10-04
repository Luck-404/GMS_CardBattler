//===============================================================================//
//
// END STEP: OBJ_BATTLE_TURN_CONTROLLER
// FUNCTION: Prepares battle-entry triggers, waits for Start Battle confirmation,
//           executes battle-entry effects only after confirmation, begins initiative
//           after all entry effects resolve, and checks battle-end conditions.
//
//===============================================================================//

//================//
//CHEATS GUI LOCK//
//================//
var _flag_cheats_gui_active =
	instance_exists(global.ref_active_gui) &&
	variable_instance_exists(
		global.ref_active_gui,
		"_str_type"
	) &&
	global.ref_active_gui._str_type == "CHEATS";

if (_flag_cheats_gui_active){

	//--------------------------//
	//ALLOW BATTLE-END DETECTION//
	//--------------------------//
	var _flag_player_defeated =
		_flag_started_game &&
		!scr_battle_has_team_combatants(
			"PLAYER"
		);

	var _flag_enemy_defeated =
		_flag_started_game &&
		!scr_battle_has_team_combatants(
			"ENEMY"
		);

	/*
		The Cheats GUI pauses normal End Step battle progression,
		but must not suppress win/loss resolution after a Cheat
		changes combatant state.
	*/

	if (
		!_flag_player_defeated &&
		!_flag_enemy_defeated
	){
		exit;
	}
}

//=========================//
//TOGGLE TURN DEBUG DISPLAY//
//=========================//
if (keyboard_check_pressed(ord("T"))){
	_flag_show_turn_debug = !_flag_show_turn_debug;
}

if (!instance_exists(obj_gui_end_battle_pane)){

	#region BATTLE ENTRY TRIGGERS

	//==========================//
	//PREPARE ENTRY TRIGGER QUEUE//
	//==========================//
	if (!_flag_entry_triggers_init){

		var _flag_player_ready =
			(
				instance_exists(_ref_player_controller) &&
				_ref_player_controller._state_player ==
				ENUM_PLAYER_STATE.WAIT
			);

		var _flag_enemy_ready =
			(
				instance_exists(_ref_enemy_controller) &&
				_ref_enemy_controller._state_enemy ==
				ENUM_ENEMY_STATE.WAIT
			);

		//-------------------//
		//BUILD TRIGGER QUEUE//
		//-------------------//
		if (
			_flag_player_ready &&
			_flag_enemy_ready
		){

			//==========================//
			//INITIALIZE LEVEL DISPARITY//
			//==========================//
			scr_battle_refresh_outleveled();

			//====================//
			//BUILD ENTRY TRIGGERS//
			//====================//
			/*
				This prepares the ENTRY queue only.

				Nothing in the queue executes until the player
				presses START BATTLE.
			*/
			hscr_battle_build_entry_trigger_queue();

			//=====================//
			//BATTLE SETUP IS READY//
			//=====================//
			/*
				_flag_game_start now means that battle initialization
				is complete enough to display the Start Battle pane.

				It does NOT mean ENTRY triggers have resolved.
			*/
			_flag_game_start = true;
		}
	}

	//======================//
	//EXECUTE ENTRY TRIGGERS//
	//======================//
	if (
		_flag_entry_triggers_init &&
		!_flag_entry_triggers_complete &&
		_flag_start_confirmation_accepted &&
		!instance_exists(obj_battle_wait)
	){

		//--------------------//
		//EXECUTE NEXT TRIGGER//
		//--------------------//
		if (
			_list_entry_triggers != undefined &&
			ds_exists(
				_list_entry_triggers,
				ds_type_list
			) &&
			ds_list_size(
				_list_entry_triggers
			) > 0
		){

			var _stct_trigger =
				ds_list_find_value(
					_list_entry_triggers,
					0
				);

			hscr_battle_execute_entry_trigger(
				_stct_trigger
			);

			ds_list_delete(
				_list_entry_triggers,
				0
			);

			scr_battle_init_wait(5);
		}

		//----------------//
		//QUEUE COMPLETE//
		//----------------//
		else{

			if (
				_list_entry_triggers != undefined &&
				ds_exists(
					_list_entry_triggers,
					ds_type_list
				)
			){

				ds_list_destroy(
					_list_entry_triggers
				);
			}

			_list_entry_triggers =
				undefined;

			_flag_entry_triggers_complete =
				true;
		}
	}

	#endregion

	#region BATTLE START

	//================//
	//FIND ENTRY FADER//
	//================//

	var _ref_entry_fader = noone;

	if (instance_exists(obj_transition_fader)){

		_ref_entry_fader = instance_find(
			obj_transition_fader,
			0
		);
	}

	//============================//
	//CHECK START PANE READINESS//
	//============================//

	var _flag_entry_visual_ready = true;

	if (instance_exists(_ref_entry_fader)){

		if (_ref_entry_fader._flag_wait_for_battle_pane){

			_flag_entry_visual_ready =
				_ref_entry_fader._flag_battle_pane_ready;
		}
	}

	//=========================//
	//CREATE START CONFIRMATION//
	//=========================//
	/*
		IMPORTANT:

		Do NOT require _flag_entry_triggers_complete here.

		The Start Battle pane must exist BEFORE entry triggers
		can execute, because pressing its button sets
		_flag_start_confirmation_accepted.
	*/
	if (
		_flag_game_start &&
		!_flag_started_game &&
		!_flag_start_confirmation_created &&
		_flag_entry_visual_ready
	){

		//=======================//
		//REFRESH LEVEL DISPARITY//
		//=======================//

		var _stct_disparity =
			scr_battle_refresh_outleveled();

		//---------------------//
		//CALCULATE INITIATIVE//
		//---------------------//

		hscr_battle_set_initial_turn_order();

		//-------------------//
		//CREATE START PANE//
		//-------------------//

		_ref_start_battle_pane = instance_create_layer(
			display_get_gui_width() * 0.5,
			display_get_gui_height() * 0.5,
			"ily_fx",
			obj_gui_battle_start_pane
		);

		_ref_start_battle_pane._ref_turn_controller =
			self;

		_ref_start_battle_pane._ref_player_controller =
			_ref_player_controller;

		_ref_start_battle_pane._ref_enemy_controller =
			_ref_enemy_controller;

		_ref_start_battle_pane._val_player_avg_speed =
			_val_player_opening_speed;

		_ref_start_battle_pane._val_enemy_avg_speed =
			_val_enemy_opening_speed;

		_ref_start_battle_pane._str_first_team =
			_str_opening_team;

		//=====================//
		//ASSIGN AVERAGE LEVELS//
		//=====================//

		_ref_start_battle_pane._val_player_avg_level =
			_stct_disparity._val_player_avg_level;

		_ref_start_battle_pane._val_enemy_avg_level =
			_stct_disparity._val_enemy_avg_level;

		//------------------------//
		//MARK PANE AS INITIALIZED//
		//------------------------//

		_flag_start_confirmation_created =
			true;

		//-------------------------//
		//REMOVE SPINNER AND REVEAL//
		//-------------------------//

		if (instance_exists(_ref_entry_fader)){

			if (_ref_entry_fader._flag_wait_for_battle_pane){

				_ref_entry_fader._flag_battle_pane_spawned =
					true;
			}
		}
	}

	//================//
	//START CONFIRMED//
	//================//
	/*
		The Start Battle button may already have been pressed,
		but actual battle initiative cannot begin until every
		queued ENTRY trigger has resolved.
	*/
	if (
		_flag_game_start &&
		!_flag_started_game &&
		_flag_start_confirmation_accepted &&
		_flag_entry_triggers_complete
	){

		var _flag_final_fade_complete =
			true;

		//----------------------//
		//REQUEST FINAL FADE OUT//
		//----------------------//

		if (instance_exists(_ref_entry_fader)){

			if (_ref_entry_fader._flag_wait_for_battle_pane){

				_ref_entry_fader._flag_battle_finish =
					true;

				_flag_final_fade_complete =
					false;
			}
		}

		//------------------------------//
		//BEGIN ONLY AFTER FADE FINISHES//
		//------------------------------//

		if (_flag_final_fade_complete){

			//================//
			//START BATTLE TIMER//
			//================//
			_val_battle_start_time =
				current_time;

			_flag_started_game =
				true;

			if (instance_exists(_ref_start_battle_pane)){

				instance_destroy(
					_ref_start_battle_pane
				);
			}

			hscr_battle_begin_initial_turn();
		}
	}

	#endregion

	#region BATTLE END

	//----------------//
	//CHECK BATTLE END//
	//----------------//
	if (
		_flag_started_game &&
		!_flag_battle_ended
	){

		//----------------//
		//PLAYER TEAM DEAD//
		//----------------//
		if (!scr_battle_has_team_combatants("PLAYER")){

			_flag_battle_ended =
				true;

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
				" | PLAYER ACTIVE: " +
				string(
					ds_list_size(
						_ref_player_controller._list_beasts_alive
					)
				) +
				" | PLAYER GRAVEYARD: " +
				string(
					ds_list_size(
						_ref_player_controller._list_beasts_graveyard
					)
				) +
				" | ENEMY ACTIVE: " +
				string(
					ds_list_size(
						_ref_enemy_controller._list_beasts_alive
					)
				) +
				" | ENEMY GRAVEYARD: " +
				string(
					ds_list_size(
						_ref_enemy_controller._list_beasts_graveyard
					)
				),
				"BATTLE",
				"OBJ_BATTLE_TURN_CONTROLLER:END_STEP"
			);

			audio_play_sound(
				snd_battle_loss,
				0,
				false
			);

			var _ref_end_battle_pane =
				instance_create_layer(
					room_width * 0.5,
					room_height * 0.5,
					"ily_fx",
					obj_gui_end_battle_pane
				);
				
				var _val_battle_elapsed_seconds = 0;

				if (_val_battle_start_time >= 0){

					_val_battle_elapsed_seconds =
						max(
							0,
							(current_time - _val_battle_start_time) /
							1000
						);
				}

				_ref_end_battle_pane._val_battle_elapsed_seconds =
					_val_battle_elapsed_seconds;

				_ref_end_battle_pane._ct_battle_rounds =
					_ct_round;

			_ref_end_battle_pane._str_condition =
				"LOSS";
		}

		//---------------//
		//ENEMY TEAM DEAD//
		//---------------//
		else if (!scr_battle_has_team_combatants("ENEMY")){

			_flag_battle_ended =
				true;

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
				" | PLAYER ACTIVE: " +
				string(
					ds_list_size(
						_ref_player_controller._list_beasts_alive
					)
				) +
				" | PLAYER GRAVEYARD: " +
				string(
					ds_list_size(
						_ref_player_controller._list_beasts_graveyard
					)
				) +
				" | ENEMY ACTIVE: " +
				string(
					ds_list_size(
						_ref_enemy_controller._list_beasts_alive
					)
				) +
				" | ENEMY GRAVEYARD: " +
				string(
					ds_list_size(
						_ref_enemy_controller._list_beasts_graveyard
					)
				),
				"BATTLE",
				"OBJ_BATTLE_TURN_CONTROLLER:END_STEP"
			);

			audio_play_sound(
				snd_battle_victory,
				0,
				false
			);

			var _ref_end_battle_pane =
				instance_create_layer(
					room_width * 0.5,
					room_height * 0.5,
					"ily_fx",
					obj_gui_end_battle_pane
				);

			var _val_battle_elapsed_seconds = 0;

			if (_val_battle_start_time >= 0){

				_val_battle_elapsed_seconds =
					max(
						0,
						(current_time - _val_battle_start_time) /
						1000
					);
			}

			_ref_end_battle_pane._val_battle_elapsed_seconds =
				_val_battle_elapsed_seconds;

			_ref_end_battle_pane._ct_battle_rounds =
				_ct_round;

			_ref_end_battle_pane._str_condition =
				"WIN";
		}
	}

	#endregion
}