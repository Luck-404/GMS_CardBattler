//////////////////////////////////////////////////////////////////////
//					OBJ_MUSIC_CONTROLLER STEP						//
//																	//
// > PLAY MUSIC BASED ON THE AREA. MUSIC WILL SWITCH BETWEEN AREAS  //
//////////////////////////////////////////////////////////////////////
if (_flag_playing == false && !instance_exists(obj_music_timer)){
	audio_stop_all();	
	_flag_playing = true;	
	//switch (_current_zone) (town, forest, meadows, etc)
		//1-n.. music per _current_zone switch (rand to pick)-- zone banner triggers set the type of this
		audio_play_sound(snd_bgm_meadows,0,false,global.music_vol);
		_music_ref_playing = "meadows1";
	//set a timer for the length of the song + 5 seconds. (gives 5 seconds between songs)
	var _music_timer = instance_create_layer(x,y,"GUI",obj_music_timer);
	_music_timer._life = (audio_sound_length(snd_bgm_meadows) + 5)*60;
	_flag_playing = false;
}

//TODO
//if a new zone has been entered (_current_zone != _music_ref_playing)
	//destroy the old timer/stop the old music (fade out somehow
	//top loop should take over... new ref will set up properly and this wont play again!