//===============================================================================//
//
// STEP: OBJ_OVERWORLD_DECOR_SIGN
// FUNCTION: Detects nearby player interaction with the sign.
//           Displays sign text when activated.
//           Handles highlight state and interaction cooldown.
//
//===============================================================================//

//================//
//PLAYER INTERACTION//
//================//
if (instance_exists(obj_player) && distance_to_object(obj_player) < 48){

	if (!_flag_triggered && _ct_interaction_cooldown <= 0){

		image_index = 1;

		if (keyboard_check_pressed(ord("E"))){

			audio_play_sound(snd_gui_press,0,false);

			_flag_triggered = true;
			_ct_interaction_cooldown = 60;

			image_index = 0;

			scr_overworld_spawn_text_bubble(
				x,
				y - 64,
				_str_sign_text
			);
		}
	}
	else{
		image_index = 0;
	}
}
else{
	image_index = 0;
}

//================//
//INTERACTION COOLDOWN//
//================//
if (_ct_interaction_cooldown > 0){

	_ct_interaction_cooldown--;

	if (_ct_interaction_cooldown <= 0){
		_ct_interaction_cooldown = 0;
		_flag_triggered = false;
	}
}