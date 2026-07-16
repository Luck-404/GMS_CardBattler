//===============================================================================//
//
// STEP: OBJ_DECOR_SIGN
// FUNCTION:	Detects nearby player interaction with the sign
//				Displays sign text when activated by the player
//				Handles highlight state and interaction cooldowns
//
//===============================================================================//

//—------------------------------------------------------------------------------//
// IF PLAYER IS NEXT TO, HIGHLIGHT IT
//—------------------------------------------------------------------------------//
#region HIGHLIGHT AND CHECKING
if (distance_to_object(obj_player) < 48){
	if (!_flag_triggered && _ct_cooldown == 0){ //HIGHLIGHT WHEN PLAYER IS NEARBY
		image_index = 1;
		if (keyboard_check(ord("E"))){ //IF PLAYER PRESSES E, SHOW THE TEXT
			audio_play_sound(snd_gui_press,0,false);
			_flag_triggered = true;
			image_index = 0;
			scr_spawn_popup_text_bubble(x,y-64,_str_sign_text);
			_ct_cooldown = 60;
		}
	}
} else {
	image_index = 0;
}
#endregion

//—------------------------------------------------------------------------------//
// COOLDOWN
//—------------------------------------------------------------------------------//
#region COOLDOWN
if (_ct_cooldown > 0){
	_ct_cooldown--;	
	if (_ct_cooldown <= 0){
		_ct_cooldown = 0;
		_flag_triggered = false;	
	}
}
#endregion