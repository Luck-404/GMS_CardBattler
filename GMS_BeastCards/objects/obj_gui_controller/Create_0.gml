//===============================================================================//
//
// CREATE: OBJ_GUI_CONTROLLER
// FUNCTION: Initializes global GUI, music, and ambiance state.
//           Applies window and texture settings.
//           Defines helpers for GUI cleanup, pause control, battle end,
//           music playback, and overworld ambiance.
//
//===============================================================================//

//================//
//SINGLETON//
//================//
if (instance_number(obj_gui_controller) > 1){

	scr_debug_log(
		"GUI",
		"CONTROLLER",
		self,
		"DUPLICATE GUI CONTROLLER DETECTED - DESTROYING DUPLICATE",
		"WARNING",
		"OBJ_GUI_CONTROLLER:CREATE"
	);

	instance_destroy();
	exit;
}

persistent = true;

//================//
//VARIABLES//
//================//
global.flag_pause = false;
global.ref_active_gui = undefined;

//================//
//MUSIC//
//================//
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

_arr_music_overworld_names = [
	"BGM_OVERWORLD_1",
	"BGM_OVERWORLD_2",
	"BGM_OVERWORLD_3",
	"BGM_OVERWORLD_4",
	"BGM_OVERWORLD_5",
	"BGM_OVERWORLD_6",
	"BGM_OVERWORLD_7",
	"BGM_OVERWORLD_8",
	"BGM_OVERWORLD_9",
	"BGM_OVERWORLD_10"
];

_arr_music_battle_names = [
	"BGM_BATTLE_1",
	"BGM_BATTLE_2",
	"BGM_BATTLE_3"
];

_val_music_instance = -1;
_snd_current_music = undefined;

_str_music_mode = "";

_flag_music_silence = false;
_ct_music_silence_timer = 0;

//================//
//AMBIANCE//
//================//
_arr_ambiance = [
	snd_overworld_ambiance_beasts_1,
	snd_overworld_ambiance_beasts_2,
	snd_overworld_ambiance_beasts_3,

	snd_overworld_ambiance_insects_1,
	snd_overworld_ambiance_insects_2,
	snd_overworld_ambiance_insects_3,

	snd_overworld_ambiance_nature_1,
	snd_overworld_ambiance_nature_2,
	snd_overworld_ambiance_nature_3,

	snd_overworld_ambiance_water_1,
	snd_overworld_ambiance_water_2,
	snd_overworld_ambiance_water_3,

	snd_overworld_ambiance_wind_1,
	snd_overworld_ambiance_wind_2,
	snd_overworld_ambiance_wind_3
];

_val_ambiance_instance = -1;
_snd_current_ambiance = undefined;

_ct_ambiance_timer = irandom_range(30 * 60,300 * 60);

//================//
//INIT//
//================//
gpu_set_texfilter(true);
window_set_fullscreen(true);

//----------------//
//DEBUG INITIALIZE//
//----------------//
scr_debug_log(
	"GUI",
	"CONTROLLER",
	self,
	"GUI CONTROLLER INITIALIZED | OVERWORLD MUSIC: " + string(array_length(_arr_music_overworld)) +
	" | BATTLE MUSIC: " + string(array_length(_arr_music_battle)) +
	" | AMBIANCE: " + string(array_length(_arr_ambiance)) +
	" | FULLSCREEN: TRUE",
	"INIT",
	"OBJ_GUI_CONTROLLER:CREATE"
);

//================//
//METHODS//
//================//
#region METHODS

//-------------------------------------------------------------------------------//
// HSCR_GUI_PLAY_RANDOM_MUSIC
// FUNCTION: Selects and plays one random track from a supplied music array.
//           Avoids immediately repeating the previously played music track.
//           Logs the selected BGM asset name when playback begins.
//
// ARGUMENTS: _arr_tracks is the array of available music assets.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
function hscr_gui_play_random_music(_arr_tracks){

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

	//----------------//
	//GET TRACK NAME//
	//----------------//
	var _str_track_name = "UNKNOWN_BGM";

	if (_str_music_mode == "OVERWORLD" && _it_track < array_length(_arr_music_overworld_names)){
		_str_track_name = _arr_music_overworld_names[_it_track];
	}
	else if (_str_music_mode == "BATTLE" && _it_track < array_length(_arr_music_battle_names)){
		_str_track_name = _arr_music_battle_names[_it_track];
	}

	//----------------//
	//DEBUG BGM START//
	//----------------//
	scr_debug_log(
		"AUDIO",
		"BGM",
		self,
		"PLAYING " + _str_track_name + " | MODE: " + _str_music_mode,
		"MUSIC",
		"OBJ_GUI_CONTROLLER:HSCR_GUI_PLAY_RANDOM_MUSIC"
	);
}

//-------------------------------------------------------------------------------//
// HSCR_GUI_START_MUSIC_SILENCE
// FUNCTION: Starts an overworld music silence period.
//           Randomizes the silence duration between 30 and 90 seconds.
//           Logs the intentional silence period.
//
// ARGUMENTS: None.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
function hscr_gui_start_music_silence(){

	_flag_music_silence = true;
	_ct_music_silence_timer = irandom_range(30 * 60,90 * 60);

	_val_music_instance = -1;

	//-------------------//
	//DEBUG MUSIC SILENCE//
	//-------------------//
	var _val_silence_seconds = round(_ct_music_silence_timer / 60);

	scr_debug_log(
		"AUDIO",
		"BGM",
		self,
		"MUSIC SILENCE STARTED | DURATION: " + string(_val_silence_seconds) + " SEC",
		"MUSIC",
		"OBJ_GUI_CONTROLLER:HSCR_GUI_START_MUSIC_SILENCE"
	);
}

//-------------------------------------------------------------------------------//
// HSCR_GUI_PLAY_RANDOM_AMBIANCE
// FUNCTION: Selects and plays one random ambiance sound.
//           Avoids immediately repeating the previous ambiance sound.
//
// ARGUMENTS: None.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
function hscr_gui_play_random_ambiance(){

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

//-------------------------------------------------------------------------------//
// HSCR_GUI_RESET_AMBIANCE_TIMER
// FUNCTION: Randomizes the delay before the next ambiance sound.
//           Uses an interval between 30 and 300 seconds.
//
// ARGUMENTS: None.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
function hscr_gui_reset_ambiance_timer(){

	_ct_ambiance_timer = irandom_range(30 * 60,300 * 60);
}

//-------------------------------------------------------------------------------//
// HSCR_GUI_DESTROY_ACTIVE
// FUNCTION: Destroys the currently active GUI instance.
//           Clears the global active-GUI reference.
//           Logs the closed GUI type when an active pane exists.
//
// ARGUMENTS: _str_source optionally identifies what requested the close.
// RETURNS: True when an active GUI was destroyed; otherwise false.
//
//-------------------------------------------------------------------------------//
function hscr_gui_destroy_active(_str_source="SYSTEM"){

	//================//
	//CHECK ACTIVE GUI//
	//================//
	if (!instance_exists(global.ref_active_gui)){

		global.ref_active_gui = undefined;

		return false;
	}

	//================//
	//GET GUI TYPE//
	//================//
	var _ref_closing_gui = global.ref_active_gui;
	var _str_gui_type = "UNKNOWN";

	if (variable_instance_exists(_ref_closing_gui,"_str_type")){
		_str_gui_type = string_upper(_ref_closing_gui._str_type);
	}

	//================//
	//CLEAR REFERENCE//
	//================//
	global.ref_active_gui = undefined;

	//================//
	//DESTROY GUI//
	//================//
	instance_destroy(_ref_closing_gui);

	//================//
	//DEBUG GUI CLOSE//
	//================//
	scr_debug_log(
		"GUI",
		"PANE",
		self,
		"GUI CLOSED" +
		" | TYPE: " + _str_gui_type +
		" | SOURCE: " + string_upper(_str_source),
		"INFO",
		"OBJ_GUI_CONTROLLER:HSCR_GUI_DESTROY_ACTIVE"
	);

	return true;
}

//-------------------------------------------------------------------------------//
// HSCR_GUI_SET_PAUSE
// FUNCTION: Explicitly pauses or resumes the game and player movement.
//           Logs only genuine pause-state changes.
//
// ARGUMENTS: _flag_pause is the requested GUI pause state.
//            _str_source optionally identifies what requested the change.
// RETURNS: True when the pause state changes; otherwise false.
//
//-------------------------------------------------------------------------------//
function hscr_gui_set_pause(_flag_pause,_str_source="SYSTEM"){

	//================//
	//STORE OLD STATE//
	//================//
	var _flag_pause_before = global.flag_pause;

	//================//
	//SET PAUSE STATE//
	//================//
	global.flag_pause = _flag_pause;

	//================//
	//PLAYER MOVEMENT//
	//================//
	if (instance_exists(obj_player)){

		if (_flag_pause){
			scr_player_set_movement_state("STOP");
		}
		else{
			scr_player_set_movement_state("START");
		}
	}

	//================//
	//NO STATE CHANGE//
	//================//
	if (_flag_pause_before == _flag_pause){
		return false;
	}

	//================//
	//DEBUG PAUSE//
	//================//
	scr_debug_log(
		"GUI",
		"PAUSE",
		self,
		(_flag_pause ? "GAME PAUSED" : "GAME RESUMED") +
		" | SOURCE: " +
		string_upper(_str_source) +
		" | ROOM: " +
		room_get_name(room),
		"INFO",
		"OBJ_GUI_CONTROLLER:HSCR_GUI_SET_PAUSE"
	);

	return true;
}

//-------------------------------------------------------------------------------//
// HSCR_GUI_TRIGGER_END_BATTLE
// FUNCTION: Ends battle flow and removes the current GUI.
//           Pauses gameplay, creates the end-battle GUI, and assigns its result.
//
// ARGUMENTS: _str_win_type is the battle result condition.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
function hscr_gui_trigger_end_battle(_str_win_type){

	//----------------//
	//CLOSE ACTIVE GUI//
	//----------------//
	hscr_gui_destroy_active();
	hscr_gui_set_pause(true);

	//---------------------//
	//OPEN END-BATTLE GUI//
	//---------------------//
	global.ref_active_gui = instance_create_layer(
		room_width / 2,
		room_height / 2,
		"ily_fx",
		obj_gui_end_battle_pane
	);

	global.ref_active_gui._str_condition = _str_win_type;
}

#endregion