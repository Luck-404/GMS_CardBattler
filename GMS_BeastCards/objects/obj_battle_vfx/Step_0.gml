//===============================================================================//
//
// STEP: OBJ_BATTLE_VFX
// FUNCTION: Handles delayed VFX startup, synchronized SFX playback,
//           and optional anchor following.
//           Animation completion is handled by the Animation End event.
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

	_ct_start_delay =
		0;

	visible =
		true;

	image_index =
		0;

	image_speed =
		1;
}

//--------//
//PLAY SFX//
//--------//
if (!_flag_sfx_played){

	_flag_sfx_played = true;

	if (_snd_sfx != undefined){

		scr_battle_play_sfx(
			_snd_sfx
		);
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