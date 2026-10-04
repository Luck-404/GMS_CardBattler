//===============================================================================//
//
// DRAW GUI END: OBJ_GUI_END_BATTLE_PANE
// FUNCTION: Draws battle result, grade, normalized rewards, and Party outcome.
//           Applies win/loss results once.
//           Resolves WIN rewards through SCR_REWARD_RESOLVE_BATTLE.
//           Handles the confirmed transition out of battle.
//
//===============================================================================//

//----------------------//
//VALIDATE BATTLE STATE//
//----------------------//
if (!instance_exists(obj_battle_player_controller)){
	exit;
}

if (!ds_exists(global.list_player_party,ds_type_list)){
	exit;
}

if (!ds_exists(
	obj_battle_player_controller._list_beasts,
	ds_type_list
)){
	exit;
}

//---------------------//
//CHECK CONFIRM INPUT//
//---------------------//
var _flag_confirm_pressed = false;

if (instance_exists(_ref_confirm_button)){

	_flag_confirm_pressed =
		mouse_check_button_pressed(mb_left) &&
		position_meeting(
			device_mouse_x_to_gui(0),
			device_mouse_y_to_gui(0),
			_ref_confirm_button
		);
}

//================//
//BATTLE RESULT//
//================//
switch (_str_condition){

	//======//
	//LOSS//
	//======//
	#region LOSS

	case "LOSS":

		//-------------//
		//RESULT TEXT//
		//-------------//
		draw_set_font(
			fnt_gui_large
		);

		draw_set_halign(
			fa_center
		);

		draw_set_valign(
			fa_top
		);

		draw_set_colour(
			c_red
		);

		draw_text(
			x,
			_val_pane_top + 25,
			"DEFEATED..."
		);

		draw_text(
			x,
			_val_pane_top + 85,
			"YOU LIMP BACK TO THE RANCH"
		);

		draw_set_halign(
			fa_left
		);

		draw_set_colour(
			c_black
		);

		//-----------------//
		//APPLY LOSS ONCE//
		//-----------------//
		if (!_flag_finished){

			_flag_finished = true;

			for (
				var _it_beast = 0;
				_it_beast <
					ds_list_size(
						global.list_player_party
					);
				_it_beast++
			){

				var _stct_beast =
					ds_list_find_value(
						global.list_player_party,
						_it_beast
					);

				if (!is_struct(_stct_beast)){
					continue;
				}

				_stct_beast._val_beast_hp_cur =
					0;
			}

			//===================//
			//DEBUG LOSS RESULT//
			//===================//
			scr_debug_log(
				"BATTLE",
				"RESULT",
				self,
				"LOSS RESULT APPLIED | PARTY HP SET TO 0" +
				" | PARTY: " +
				string(
					ds_list_size(
						global.list_player_party
					)
				),
				"BATTLE",
				"OBJ_GUI_END_BATTLE_PANE:DRAW_GUI_END"
			);
		}

		//============//
		//DRAW PARTY//
		//============//
		hscr_gui_end_battle_draw_party(
			false
		);

		//---------//
		//CONFIRM//
		//---------//
		if (_flag_confirm_pressed){

			audio_play_sound(
				snd_gui_press,
				0,
				false
			);

			scr_market_register_battle_completion();

			//=================//
			//DEBUG BATTLE EXIT//
			//=================//
			scr_debug_log(
				"BATTLE",
				"EXIT",
				self,
				"BATTLE EXIT CONFIRMED | RESULT: LOSS" +
				" | DESTINATION: " +
				room_get_name(
					rm_ow_ranch
				) +
				" | POSITION: (530,980)",
				"BATTLE",
				"OBJ_GUI_END_BATTLE_PANE:DRAW_GUI_END"
			);

			var _ref_transition =
				instance_create_layer(
					room_width * 0.5,
					room_height * 0.5,
					"ily_fx",
					obj_transition
				);

			_ref_transition._rm_destination =
				rm_ow_ranch;

			scr_gui_spawn_popup_banner(
				"RANCH ROOM"
			);

			obj_player.x = 530;
			obj_player.y = 980;

			scr_player_set_movement_state(
				"START"
			);

			obj_player.visible =
				true;
		}

	break;

	#endregion

	//=====//
	//WIN//
	//=====//
	#region WIN

	case "WIN":

		//-------------//
		//RESULT TEXT//
		//-------------//
		draw_set_font(
			fnt_gui_large
		);

		draw_set_halign(
			fa_center
		);

		draw_set_valign(
			fa_top
		);

		draw_set_colour(
			c_black
		);

		draw_text(
			x,
			_val_pane_top + 15,
			"YOU WON!"
		);

		draw_set_halign(
			fa_left
		);

		//----------------//
		//APPLY WIN ONCE//
		//----------------//
		if (!_flag_finished){

			_flag_finished =
				true;

			//-------------------//
			//HEAL RANCH BEASTS//
			//-------------------//
			scr_ranch_heal_beasts(
				0.33
			);

			//=======================//
			//RESOLVE BATTLE REWARDS//
			//=======================//
			_stct_reward_result =
				scr_reward_resolve_battle(
					obj_battle_player_controller,
					obj_battle_enemy_controller,
					_val_battle_elapsed_seconds,
					_ct_battle_rounds
				);

			//----------------------//
			//STORE REWARD RESULTS//
			//----------------------//
			if (is_struct(_stct_reward_result)){

				_stct_battle_grade =
					_stct_reward_result
						._stct_grade;

				_arr_reward_entries =
					_stct_reward_result
						._arr_rewards;

				//======================//
				//BUILD DISPLAY-ONLY LIST//
				//======================//
				hscr_gui_end_battle_build_reward_display();
			}
			else{

				_stct_battle_grade =
					undefined;

				_arr_reward_entries =
					[];

				_arr_reward_display =
					[];

				scr_debug_log(
					"BATTLE",
					"REWARD",
					self,
					"BATTLE REWARD RESOLUTION FAILED" +
					" | RESULT: INVALID REWARD STRUCT",
					"ERROR",
					"OBJ_GUI_END_BATTLE_PANE:DRAW_GUI_END"
				);
			}

			//==================//
			//DEBUG WIN RESULT//
			//==================//
			scr_debug_log(
				"BATTLE",
				"RESULT",
				self,
				"WIN RESULT APPLIED | POST-BATTLE PARTY STATE SAVED" +
				" | PARTY: " +
				string(
					ds_list_size(
						global.list_player_party
					)
				) +
				" | DISPLAY REWARDS: " +
				string(
					array_length(
						_arr_reward_display
					)
				),
				"BATTLE",
				"OBJ_GUI_END_BATTLE_PANE:DRAW_GUI_END"
			);
		}
		
	//============//
	//DRAW SCORE//
	//============//
	hscr_gui_end_battle_draw_score();

	//=============//
	//DRAW REWARDS//
	//=============//
	hscr_gui_end_battle_draw_rewards();

	//============//
	//DRAW PARTY//
	//============//
	hscr_gui_end_battle_draw_party(
		true
	);

	//=================//
	//DRAW SCORE TOOLTIP//
	//=================//
	hscr_gui_end_battle_draw_score_tooltip();

	//==================//
	//DRAW REWARD TOOLTIP//
	//==================//
	hscr_gui_end_battle_draw_reward_tooltip();
		
		//---------//
		//CONFIRM//
		//---------//
		if (_flag_confirm_pressed){

			audio_play_sound(
				snd_gui_press,
				0,
				false
			);

			scr_market_register_battle_completion();

			//=================//
			//DEBUG BATTLE EXIT//
			//=================//
			scr_debug_log(
				"BATTLE",
				"EXIT",
				self,
				"BATTLE EXIT CONFIRMED | RESULT: WIN" +
				" | DESTINATION: " +
				room_get_name(
					global.rm_last_player
				) +
				" | POSITION: (" +
				string(
					round(
						global.val_last_player_x
					)
				) +
				"," +
				string(
					round(
						global.val_last_player_y
					)
				) +
				")",
				"BATTLE",
				"OBJ_GUI_END_BATTLE_PANE:DRAW_GUI_END"
			);

			var _ref_transition =
				instance_create_layer(
					room_width * 0.5,
					room_height * 0.5,
					"ily_fx",
					obj_transition
				);

			_ref_transition._rm_destination =
				global.rm_last_player;

			scr_gui_spawn_popup_banner(
				global.str_last_player_banner
			);

			obj_player.x =
				global.val_last_player_x;

			obj_player.y =
				global.val_last_player_y;

			scr_player_set_movement_state(
				"START"
			);

			obj_player.visible =
				true;
		}

	break;

	#endregion
}

//================//
//RESET DRAW STATE//
//================//
draw_set_alpha(
	1
);

draw_set_colour(
	c_white
);

draw_set_halign(
	fa_left
);

draw_set_valign(
	fa_top
);