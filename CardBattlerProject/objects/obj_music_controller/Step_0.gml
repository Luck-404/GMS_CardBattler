if (_flag_playing == false){
	_flag_playing = true;
	//var rand = irandom_range(0,10);
	//switch (music)
	//make the zone_trigger objects pass a variable to this
	audio_stop_all();
	audio_play_sound(snd_bgm_meadows,0,true);	
}