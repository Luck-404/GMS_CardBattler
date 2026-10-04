//===============================================================================//
//
// STEP: OBJ_BATTLE_VFX
// FUNCTION: Handles battle VFX lifetime, delayed startup, synchronized SFX,
//           and optional anchor following.
//           Destroys all battle VFX once the end-battle pane is active.
//           Animation completion is handled by the Animation End event.
//
//===============================================================================//

//==================//
//END BATTLE CLEANUP//
//==================//
if (instance_exists(obj_gui_end_battle_pane)){

	instance_destroy();

	exit;
}

#region START DELAY

//-----------//
//START DELAY//
//-----------//
if (_ct_start_delay > 0){

	_ct_start_delay--;

	if (_ct_start_delay > 0){
		exit;
	}

	//-----------//
	//START VFX//
	//-----------//
	_ct_start_delay = 0;

	visible = true;

	image_index = 0;
	image_speed = 1;
}

#endregion

#region SFX

//--------//
//PLAY SFX//
//--------//
if (!_flag_sfx_played){

	_flag_sfx_played = true;

	if (_snd_sfx != undefined){
		scr_battle_play_sfx(_snd_sfx);
	}
}

#endregion

#region ANCHOR

//-------------//
//FOLLOW ANCHOR//
//-------------//
if (_flag_follow_anchor){

	if (!instance_exists(_ref_anchor)){

		instance_destroy();

		exit;
	}

	x =
		_ref_anchor.x +
		_val_offset_x;

	y =
		_ref_anchor.y +
		_val_offset_y;
}

#endregion