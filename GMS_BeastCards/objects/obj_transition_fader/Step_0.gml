
//===============================================================================//
// STEP: OBJ_TRANSITION_FADER
// FUNCTION: Runs the fade, spinner hold, battle reveal, and final fade.
//===============================================================================//

switch (_str_transition_state){

	//================//
	//FADE TO BLACK//
	//================//

	case "FADE_OUT":

		_val_alpha = min(
			1,
			_val_alpha + _val_fade_speed
		);

		if (_val_alpha >= 1){

			_val_alpha = 1;

			_flag_fade_out = true;

			// Battle: 1 second.
			// Ordinary rooms: 0.5 seconds.

			var _val_hold_seconds =
				_flag_wait_for_battle_pane ? 0.5 : 0.5;

			_ct_black_hold = max(
				1,
				ceil(game_get_speed(gamespeed_fps) * _val_hold_seconds)
			);

			_str_transition_state = "BLACK_HOLD";

			// Request room change only after reaching full black.

			if (instance_exists(_ref_transition)){
				_ref_transition._flag_continue_transition = true;
			}
		}

	break;

	//================//
	//BLACK HOLD//
	//================//

	case "BLACK_HOLD":

		_val_spinner_rotation =
			(_val_spinner_rotation + _val_spinner_speed) mod 360;

		if (_ct_black_hold > 0){

			_ct_black_hold--;

			break;
		}

		//----------------//
		//BATTLE ENTRY//
		//----------------//

		if (_flag_wait_for_battle_pane){

			_flag_battle_pane_ready = true;

			_str_transition_state = "WAIT_BATTLE_PANE";
		}

		//----------------//
		//ORDINARY ROOM//
		//----------------//

		else if (_flag_fade_in){

			_str_transition_state = "ROOM_FADE_IN";
		}

	break;

	//=========================//
	//WAIT FOR BATTLE START GUI//
	//=========================//

	case "WAIT_BATTLE_PANE":

		_val_spinner_rotation =
			(_val_spinner_rotation + _val_spinner_speed) mod 360;

		// Keep the screen black and spinner active if battle
		// initialization has not yet completed.

		if (_flag_battle_pane_spawned){

			_str_transition_state = "BATTLE_REVEAL";
		}

	break;

	//========================//
	//REVEAL BATTLE BACKGROUND//
	//========================//

	case "BATTLE_REVEAL":

		_val_alpha = max(
			_val_battle_background_alpha,
			_val_alpha - _val_fade_speed
		);

		if (_val_alpha <= _val_battle_background_alpha){

			_val_alpha = _val_battle_background_alpha;

			_flag_battle_waiting_for_input = true;

			_str_transition_state = "BATTLE_WAIT";
		}

	break;

	//================//
	//WAIT FOR PLAYER//
	//================//

	case "BATTLE_WAIT":

		_val_alpha = _val_battle_background_alpha;

		if (_flag_battle_finish){

			_flag_battle_waiting_for_input = false;

			_str_transition_state = "BATTLE_FINISH";
		}

	break;

	//================//
	//FINAL BATTLE FADE//
	//================//

	case "BATTLE_FINISH":

		_val_alpha = max(
			0,
			_val_alpha - _val_fade_speed
		);

		if (_val_alpha <= 0){

			_val_alpha = 0;

			instance_destroy();
		}

	break;

	//================//
	//ORDINARY ROOM FADE//
	//================//

	case "ROOM_FADE_IN":

		_val_alpha = max(
			0,
			_val_alpha - _val_fade_speed
		);

		if (_val_alpha <= 0){

			_val_alpha = 0;

			instance_destroy();
		}

	break;
}