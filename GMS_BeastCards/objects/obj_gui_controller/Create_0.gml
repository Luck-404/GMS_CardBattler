//===============================================================================//
//
// CREATE: OBJ_GUI_CONTROLLER
// FUNCTION: Initializes global GUI and music state.
//           Applies window and texture settings.
//           Manages overworld and battle background music.
//           Defines helper scripts for GUI cleanup, pause control, battle end, and music.
//
//===============================================================================//

//---------//
//SINGLETON//
//---------//
if (instance_number(obj_gui_controller) > 1){
	instance_destroy();
	exit;
}

persistent = true;

//---------//
//VARIABLES//
//---------//
global.flag_pause = false;
global.ref_active_gui = undefined;

//-----//
//MUSIC//
//-----//
_arr_music_overworld = [
	bgm_overworld_1,
	bgm_overworld_2,
	bgm_overworld_3,
	bgm_overworld_4,
	bgm_overworld_5,
	bgm_overworld_6,
	bgm_overworld_7,
	bgm_overworld_8,
	bgm_overworld_9,
	bgm_overworld_10
];

_arr_music_battle = [
	bgm_battle_1,
	bgm_battle_2,
	bgm_battle_3
];

_val_music_instance = -1;
_snd_current_music = undefined;

_str_music_mode = "";

_flag_music_silence = false;
_ct_music_silence_timer = 0;

//--------//
//AMBIANCE//
//--------//
_arr_ambiance = [
	snd_ambiance_beasts_1,
	snd_ambiance_beasts_2,
	snd_ambiance_beasts_3,

	snd_ambiance_insects_1,
	snd_ambiance_insects_2,
	snd_ambiance_insects_3,

	snd_ambiance_nature_1,
	snd_ambiance_nature_2,
	snd_ambiance_nature_3,

	snd_ambiance_water_1,
	snd_ambiance_water_2,
	snd_ambiance_water_3,

	snd_ambiance_wind_1,
	snd_ambiance_wind_2,
	snd_ambiance_wind_3
];

_val_ambiance_instance = -1;
_snd_current_ambiance = undefined;

_ct_ambiance_timer = irandom_range(30 * 60,300 * 60);

//----//
//INIT//
//----//
gpu_set_texfilter(true);
window_set_fullscreen(true);

//-------//
//METHODS//
//-------//
#region METHODS

//—------------------------------------------------------------------------------//
// hscr_play_random_music
// FUNCTION: Selects and plays one random track from a music array.
//           Avoids immediately repeating the previous music track.
//—------------------------------------------------------------------------------//
function hscr_play_random_music(_arr_tracks){

	var _ct_tracks = array_length(_arr_tracks);

	if (_ct_tracks <= 0){
		return;
	}

	var _it_track = irandom(_ct_tracks - 1);

	if (_ct_tracks > 1 && _arr_tracks[_it_track] == _snd_current_music){
		_it_track = (_it_track + irandom_range(1,_ct_tracks - 1)) mod _ct_tracks;
	}

	_snd_current_music = _arr_tracks[_it_track];
	_val_music_instance = audio_play_sound(_snd_current_music,0,false);
}


//—------------------------------------------------------------------------------//
// hscr_start_music_silence
// FUNCTION: Starts an overworld music silence period.
//           Randomizes the silence duration between 30 and 90 seconds.
//—------------------------------------------------------------------------------//
function hscr_start_music_silence(){

	_flag_music_silence = true;
	_ct_music_silence_timer = irandom_range(30 * 60,90 * 60);

	_val_music_instance = -1;
}


//—------------------------------------------------------------------------------//
// hscr_play_random_ambiance
// FUNCTION: Selects and plays one random ambiance sound.
//           Avoids immediately repeating the previous ambiance sound.
//—------------------------------------------------------------------------------//
function hscr_play_random_ambiance(){

	var _ct_tracks = array_length(_arr_ambiance);

	if (_ct_tracks <= 0){
		return;
	}

	var _it_track = irandom(_ct_tracks - 1);

	if (_ct_tracks > 1 && _arr_ambiance[_it_track] == _snd_current_ambiance){
		_it_track = (_it_track + irandom_range(1,_ct_tracks - 1)) mod _ct_tracks;
	}

	_snd_current_ambiance = _arr_ambiance[_it_track];
	_val_ambiance_instance = audio_play_sound(_snd_current_ambiance,0,false);
}


//—------------------------------------------------------------------------------//
// hscr_reset_ambiance_timer
// FUNCTION: Randomizes the delay before the next ambiance sound.
//           Uses an interval between 30 and 300 seconds.
//—------------------------------------------------------------------------------//
function hscr_reset_ambiance_timer(){

	_ct_ambiance_timer = irandom_range(30 * 60,300 * 60);
}

//—------------------------------------------------------------------------------//
// hscr_destroy_gui_open
// FUNCTION: Destroys the currently active GUI instance.
//           Clears the active GUI reference after cleanup.
//—------------------------------------------------------------------------------//
function hscr_destroy_gui_open(){

	if (global.ref_active_gui != undefined){
		instance_destroy(global.ref_active_gui);
		global.ref_active_gui = undefined;
	}
}

//—------------------------------------------------------------------------------//
// hscr_toggle_gui_pause
// FUNCTION: Toggles player movement based on current movement state.
//           Stops movement when opening GUI and restores movement when closing GUI.
//—------------------------------------------------------------------------------//
function hscr_toggle_gui_pause(_flag_pause){

	global.flag_pause = _flag_pause;

	if (obj_player._val_player_speed == 0){
		scr_toggle_player_movement("START");
	}
	else{
		scr_toggle_player_movement("STOP");
	}
}

//—------------------------------------------------------------------------------//
// hscr_trigger_end_battle
// FUNCTION: Ends battle flow and removes the current GUI.
//           Toggles pause state, creates the end battle GUI, and assigns result.
//—------------------------------------------------------------------------------//
function hscr_trigger_end_battle(_str_win_type){

	show_debug_message("\n\n\n\n\n\nBATTLE HAS ENDED");

	hscr_destroy_gui_open();
	hscr_toggle_gui_pause(true);

	global.ref_active_gui = instance_create_layer(room_width / 2,room_height / 2,"ily_fx",obj_gui_end_battle_pane);
	global.ref_active_gui._str_condition = _str_win_type;
}

#endregion