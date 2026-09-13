//===============================================================================//
//
// GAME END: OBJ_GUI_CONTROLLER
// FUNCTION: Stops GUI-owned music and ambiance during application shutdown.
//           Clears remaining GUI/audio references without performing persistent
//           player-data cleanup.
//
//===============================================================================//

//================//
//DEBUG SHUTDOWN//
//================//
scr_debug_log(
	"GUI",
	"SHUTDOWN",
	self,
	"GUI CONTROLLER SHUTDOWN STARTED" +
	" | MUSIC ACTIVE: " +
	((_val_music_instance != -1 && audio_is_playing(_val_music_instance)) ? "YES" : "NO") +
	" | AMBIANCE ACTIVE: " +
	((_val_ambiance_instance != -1 && audio_is_playing(_val_ambiance_instance)) ? "YES" : "NO"),
	"INFO",
	"OBJ_GUI_CONTROLLER:GAME_END"
);

//================//
//STOP MUSIC//
//================//
if (_val_music_instance != -1){

	if (audio_is_playing(_val_music_instance)){
		audio_stop_sound(_val_music_instance);
	}

	_val_music_instance = -1;
}

_snd_current_music = undefined;

_flag_music_silence = false;
_ct_music_silence_timer = 0;

//================//
//STOP AMBIANCE//
//================//
if (_val_ambiance_instance != -1){

	if (audio_is_playing(_val_ambiance_instance)){
		audio_stop_sound(_val_ambiance_instance);
	}

	_val_ambiance_instance = -1;
}

_snd_current_ambiance = undefined;
_ct_ambiance_timer = 0;

//================//
//CLEAR GUI STATE//
//================//
global.ref_active_gui = undefined;
global.flag_pause = false;

//================//
//DEBUG COMPLETE//
//================//
scr_debug_log(
	"GUI",
	"SHUTDOWN",
	self,
	"GUI CONTROLLER SHUTDOWN COMPLETE" +
	" | MUSIC STOPPED" +
	" | AMBIANCE STOPPED",
	"INFO",
	"OBJ_GUI_CONTROLLER:GAME_END"
);