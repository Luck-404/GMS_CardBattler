//===============================================================================//
//
// STEP: OBJ_BATTLE_VFX
// FUNCTION: Handles delayed VFX and synchronized SFX playback.
//           Updates optional anchor following.
//           Destroys temporary VFX and holds persistent VFX on the final frame.
//
//===============================================================================//

//-----------//
//START DELAY//
//-----------//
if (_ct_start_delay > 0){

	_ct_start_delay--;

	if (_ct_start_delay > 0){
		exit;
	}

	_ct_start_delay = 0;

	visible = true;
	image_index = 0;
	image_speed = 1;
}

//--------//
//PLAY SFX//
//--------//
if (!_flag_sfx_played){

	_flag_sfx_played = true;

	if (_snd_sfx != undefined){
		audio_play_sound(_snd_sfx,0,false);
	}
}

//-------------//
//FOLLOW ANCHOR//
//-------------//
if (_flag_follow_anchor){

	if (instance_exists(_ref_anchor)){

		x =
			_ref_anchor.x +
			_val_offset_x;

		y =
			_ref_anchor.y +
			_val_offset_y;
	}
	else{

		instance_destroy();
		exit;
	}
}

//--------------------//
//HANDLE ANIMATION END//
//--------------------//
if (image_index >= image_number - 1){

	if (_flag_persistent){

		image_index =
			image_number - 1;

		image_speed = 0;
	}
	else{

		instance_destroy();
	}
}