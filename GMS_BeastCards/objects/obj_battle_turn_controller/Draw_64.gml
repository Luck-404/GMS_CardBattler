//===============================================================================//
//
// DRAW GUI: OBJ_BATTLE_TURN_CONTROLLER
// FUNCTION: Draws the current battle turn and active turn phase.
//           Displays the active wait timer for timing debugging.
//           T toggles the turn-debug pane.
//           Shows the End Turn button during player turns and hides it during
//           enemy turns.
//
//===============================================================================//

if (!instance_exists(obj_gui_end_battle_pane)){

	#region TURN DEBUG DISPLAY

	//================//
	//DEBUG PANE//
	//================//
	if (_flag_show_turn_debug){

		var _str_turn_text = "BATTLE - INITIALIZING";

		//================//
		//BATTLE STARTUP//
		//================//
		if (!_flag_game_start){

			if (
				_flag_entry_triggers_init &&
				!_flag_entry_triggers_complete
			){
				_str_turn_text = "BATTLE - ENTRY TRIGGERS";
			}
		}

		//================//
		//ACTIVE BATTLE//
		//================//
		else{

			//================//
			//PLAYER TURN//
			//================//
			if (
				_val_turn_tracker == 0 &&
				instance_exists(_ref_player_controller)
			){

				var _str_player_phase = "WAIT";

				switch(_ref_player_controller._state_player){

					case ENUM_PLAYER_STATE.INIT_BEASTS:
						_str_player_phase = "INITIALIZE BEASTS";
					break;

					case ENUM_PLAYER_STATE.INIT_CARDS:
						_str_player_phase = "INITIALIZE CARDS";
					break;

					case ENUM_PLAYER_STATE.WAIT:
						_str_player_phase = "WAIT";
					break;

					case ENUM_PLAYER_STATE.TURN_START:

						if (!_ref_player_controller._flag_turn_start_items_complete){
							_str_player_phase = "TURN START - ITEMS";
						}
						else if (_ref_player_controller._flag_statuses_init){
							_str_player_phase = "TURN START - STATUSES";
						}
						else{
							_str_player_phase = "TURN START";
						}

					break;

					case ENUM_PLAYER_STATE.TRIGGER_MINIONS:
						_str_player_phase = "MINIONS";
					break;

					case ENUM_PLAYER_STATE.SELECT_CARD:
						_str_player_phase = "SELECT CARD";
					break;

					case ENUM_PLAYER_STATE.SELECT_PRISM:
						_str_player_phase = "SELECT PRISM";
					break;

					case ENUM_PLAYER_STATE.SELECT_PRISM_TARGET:
						_str_player_phase = "SELECT PRISM TARGET";
					break;

					case ENUM_PLAYER_STATE.SELECT_CASTER:
						_str_player_phase = "SELECT CASTER";
					break;

					case ENUM_PLAYER_STATE.SELECT_TARGET:
						_str_player_phase = "SELECT TARGET";
					break;

					case ENUM_PLAYER_STATE.SELECT_ENEMY_CARD:
						_str_player_phase = "SELECT ENEMY CARD";
					break;

					case ENUM_PLAYER_STATE.SELECT_CORPSE:
						_str_player_phase = "SELECT CORPSE";
					break;

					case ENUM_PLAYER_STATE.CARD_EXECUTE:
						_str_player_phase = "CAST CARD";
					break;

					case ENUM_PLAYER_STATE.TUTOR_SELECT:
						_str_player_phase = "TUTOR";
					break;

					case ENUM_PLAYER_STATE.TURN_END:

						if (!_ref_player_controller._flag_turn_end_items_complete){
							_str_player_phase = "TURN END - ITEMS";
						}
						else if (_ref_player_controller._flag_statuses_init){
							_str_player_phase = "TURN END - STATUSES";
						}
						else{
							_str_player_phase = "TURN END - DRAW / FINISH";
						}

					break;

					case ENUM_PLAYER_STATE.DISCARD_EFFECT:
						_str_player_phase = "DISCARD EFFECT";
					break;

					case ENUM_PLAYER_STATE.DISCARD_DOWN:
						_str_player_phase = "DISCARD DOWN";
					break;
				}

				_str_turn_text = "PLAYER - " + _str_player_phase;
			}

			//================//
			//ENEMY TURN//
			//================//
			else if (
				_val_turn_tracker == 1 &&
				instance_exists(_ref_enemy_controller)
			){

				var _str_enemy_phase = "WAIT";

				switch(_ref_enemy_controller._state_enemy){

					case ENUM_ENEMY_STATE.INIT_BEASTS:
						_str_enemy_phase = "INITIALIZE BEASTS";
					break;

					case ENUM_ENEMY_STATE.INIT_CARDS:
						_str_enemy_phase = "INITIALIZE CARDS";
					break;

					case ENUM_ENEMY_STATE.WAIT:
						_str_enemy_phase = "WAIT";
					break;

					case ENUM_ENEMY_STATE.TURN_START:

						if (!_ref_enemy_controller._flag_turn_start_items_complete){
							_str_enemy_phase = "TURN START - ITEMS";
						}
						else if (_ref_enemy_controller._flag_statuses_init){
							_str_enemy_phase = "TURN START - STATUSES";
						}
						else{
							_str_enemy_phase = "TURN START";
						}

					break;

					case ENUM_ENEMY_STATE.TRIGGER_MINIONS:
						_str_enemy_phase = "MINIONS";
					break;

					case ENUM_ENEMY_STATE.CAST_CARDS:
						_str_enemy_phase = "CAST CARDS";
					break;

					case ENUM_ENEMY_STATE.NEW_CARDS:
						_str_enemy_phase = "DRAW / ROTATE CARDS";
					break;

					case ENUM_ENEMY_STATE.TURN_END:

						if (!_ref_enemy_controller._flag_turn_end_items_complete){
							_str_enemy_phase = "TURN END - ITEMS";
						}
						else if (_ref_enemy_controller._flag_statuses_init){
							_str_enemy_phase = "TURN END - STATUSES";
						}
						else{
							_str_enemy_phase = "TURN END";
						}

					break;
				}

				_str_turn_text = "ENEMY - " + _str_enemy_phase;
			}
		}

		//================//
		//WAIT TIMER//
		//================//
		if (instance_exists(obj_battle_wait)){

			var _ref_wait = instance_find(obj_battle_wait,0);

			if (instance_exists(_ref_wait)){

				_str_turn_text +=
					" | WAIT " +
					string(max(0,_ref_wait._ct_life)) +
					"F";
			}
		}

		//================//
		//PANE LAYOUT//
		//================//
		var _val_pane_x1 = 200;
		var _val_pane_x2 = room_width - 200;

		var _val_pane_y1 = 88;
		var _val_pane_y2 = 120;

		//================//
		//DRAW GREY PANE//
		//================//
		draw_set_alpha(1);
		draw_set_colour(c_dkgray);

		draw_rectangle(
			_val_pane_x1,
			_val_pane_y1,
			_val_pane_x2,
			_val_pane_y2,
			false
		);

		//================//
		//DRAW TURN TEXT//
		//================//
		draw_set_colour(c_white);
		draw_set_font(fnt_gui_small);

		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);

		draw_text(
			room_width * 0.5,
			(_val_pane_y1 + _val_pane_y2) * 0.5,
			_str_turn_text
		);

		//================//
		//RESET DRAW STATE//
		//================//
		draw_set_alpha(1);
		draw_set_colour(c_white);

		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
	}

	#endregion

	#region END TURN BUTTON

	//----------------------//
	//PLAYER END TURN BUTTON//
	//----------------------//
	if (_val_turn_tracker == 0){

		_ref_end_turn_button.visible = true;

		draw_sprite(
			spr_battle_end_turn_button_highlight,
			0,
			_ref_end_turn_button.x,
			_ref_end_turn_button.y
		);
	}

	//---------------------//
	//ENEMY END TURN HIDE//
	//---------------------//
	else{
		_ref_end_turn_button.visible = false;
	}

	#endregion
}