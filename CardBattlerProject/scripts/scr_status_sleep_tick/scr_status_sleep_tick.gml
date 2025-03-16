//////////////////////////////////////////////////////////////////////
//					SCR_status_sleep								//
//																	//
// > xxx															//	
//////////////////////////////////////////////////////////////////////
function scr_status_sleep_tick(_counter,_target,_repeat){		//STACKLESS		//DEFAULT LIFETIME: 2
	////////////////////
	// TRIGGER EFFECT //
	////////////////////
	if (_repeat == true){
		//TODO Effect
		audio_play_sound(snd_effect_snore,0,false);
	} 
	
	/////////////////
	// UNDO EFFECT //
	/////////////////
	else {
		//update effect
		_target._status_sleeping = false;
		scr_create_combat_popup(_target,"Sleep wore off","Default",0,0)
		_counter._counter_delete_flag = true;
	}
}