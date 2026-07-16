//===============================================================================//
//
// STEP: OBJ_UI_CONTROLLER
// FUNCTION: Handles global UI keyboard commands.
//           Opens, closes, and toggles active GUI panes.
//           Handles ranch click interaction and camera zoom input.
//
//===============================================================================//

//===============================================================================//
//
// STEP: OBJ_GUI_CONTROLLER
// FUNCTION: Manages background music and global GUI input.
//           Switches immediately between overworld and battle music.
//           Plays each music track to completion before selecting another.
//
//===============================================================================//

//-------------//
//MUSIC CONTROL//
//-------------//
#region MUSIC CONTROL

var _str_target_music_mode = (room == rm_battle) ? "BATTLE" : "OVERWORLD";

//-----------//
//MODE CHANGE//
//-----------//
if (_str_music_mode != _str_target_music_mode){

	_str_music_mode = _str_target_music_mode;

	// STOP CURRENT MUSIC
	if (_val_music_instance != -1){
		audio_stop_sound(_val_music_instance);
	}

	_val_music_instance = -1;
	_snd_current_music = undefined;

	_flag_music_silence = false;
	_ct_music_silence_timer = 0;

	// ENTERING BATTLE
	if (_str_music_mode == "BATTLE"){

		if (_val_ambiance_instance != -1){
			audio_stop_sound(_val_ambiance_instance);
		}

		_val_ambiance_instance = -1;
	}

	// RETURNING TO OVERWORLD
	else{
		hscr_reset_ambiance_timer();
	}
}


//------------//
//BATTLE MUSIC//
//------------//
if (_str_music_mode == "BATTLE"){

	if (_val_music_instance == -1 || !audio_is_playing(_val_music_instance)){
		hscr_play_random_music(_arr_music_battle);
	}
}


//---------------//
//OVERWORLD MUSIC//
//---------------//
else{

	// MUSIC SILENCE
	if (_flag_music_silence){

		if (_ct_music_silence_timer > 0){
			_ct_music_silence_timer--;
		}
		else{
			_flag_music_silence = false;
			_ct_music_silence_timer = 0;

			hscr_play_random_music(_arr_music_overworld);
		}
	}

	// MUSIC TRACK FINISHED
	else if (_val_music_instance == -1 || !audio_is_playing(_val_music_instance)){

		// 25% CHANCE FOR SILENCE
		if (irandom_range(1,100) <= 25){
			hscr_start_music_silence();
		}
		else{
			hscr_play_random_music(_arr_music_overworld);
		}
	}
}

#endregion


//----------------//
//AMBIANCE CONTROL//
//----------------//
#region AMBIANCE CONTROL

if (_str_music_mode == "OVERWORLD"){

	if (_ct_ambiance_timer > 0){
		_ct_ambiance_timer--;
	}
	else{

		// DO NOT OVERLAP AMBIANCE SOUNDS
		if (_val_ambiance_instance == -1 || !audio_is_playing(_val_ambiance_instance)){

			hscr_play_random_ambiance();
			hscr_reset_ambiance_timer();
		}
	}
}

#endregion

//-----------------//
//FULLSCREEN TOGGLE//
//-----------------//
if (keyboard_check_pressed(ord("F"))){
	audio_play_sound(snd_gui_press,0,false);
	window_set_fullscreen(!window_get_fullscreen());
}

//--------//
//ESC INPUT//
//--------//
if (keyboard_check_pressed(vk_escape) && global.ref_active_gui == undefined){
	audio_play_sound(snd_error,0,false);
	show_debug_message("\n\n\n\n\n\nPLAYER PRESSED ESCAPE TO END GAME");
	game_end();
} else if (keyboard_check_pressed(vk_escape)){
	audio_play_sound(snd_gui_close,0,false);
	hscr_destroy_gui_open();
	hscr_toggle_gui_pause(false);
}

//--------------//
//ROOM UI INPUTS//
//--------------//
if (room != rm_battle){

	//--------------//
	//PAUSE HANDLING//
	//--------------//
	if (keyboard_check_pressed(ord("T")) && global.ref_active_gui == undefined){
		audio_play_sound(snd_gui_open,0,false);
		show_debug_message("\n\n\n\n\n\nPLAYER PRESSED T TOGGLE PAUSE GAME");
		hscr_toggle_gui_pause(!global.flag_pause);
	}

	//-------------------//
	//ACTIVATE PARTY PANE//
	//-------------------//
	if (keyboard_check_pressed(ord("P"))){
		audio_play_sound(snd_gui_open,0,false);
		show_debug_message("\n\n\n\n\n\nPLAYER PRESSED P TOGGLE PARTY PANE");

		if (global.ref_active_gui != undefined && global.ref_active_gui._str_type == "PARTY"){
			hscr_destroy_gui_open();
			hscr_toggle_gui_pause(false);
		} else {
			hscr_destroy_gui_open();
			hscr_toggle_gui_pause(true);
			global.ref_active_gui = instance_create_layer(room_width / 2,room_height / 2,"ily_fx",obj_gui_party_pane);
		}
	}

	//---------------------------//
	//TOGGLE COMPANION SUMMONING//
	//---------------------------//
	if (keyboard_check_pressed(ord("G")) && global.ref_active_gui == undefined){
		audio_play_sound(snd_beast_summon,0,false);
		global.flag_companion_summoned = !global.flag_companion_summoned;

		if (global.flag_companion_summoned){
			scr_spawn_player_follow_beast();
			var _ref_unit = ds_list_find_value(global.list_player_party,0);
			audio_play_sound(_ref_unit._snd_beast_cry,0,false);
		}
		else{
			with (obj_beast_world){
				if (_str_team == "PLAYER"){
					instance_destroy();
				}
			}
		}
	}

	//---------------------//
	//ACTIVATE LOGBOOK PANE//
	//---------------------//
	if (keyboard_check_pressed(ord("B"))){
		audio_play_sound(snd_gui_open,0,false);
		show_debug_message("\n\n\n\n\n\nPLAYER PRESSED B TOGGLE LOGBOOK PANE");

		if (global.ref_active_gui != undefined && global.ref_active_gui._str_type == "LOGBOOK"){

			hscr_destroy_gui_open();
			hscr_toggle_gui_pause(false);
		}
		else{

			hscr_destroy_gui_open();
			hscr_toggle_gui_pause(true);

			global.ref_active_gui = instance_create_layer(
				room_width / 2,
				room_height / 2,
				"ily_fx",
				obj_gui_logbook_pane
			);
		}
	}

	//-----------------------//
	//ACTIVATE INVENTORY PANE//
	//-----------------------//
	if (keyboard_check_pressed(ord("I"))){
		show_debug_message("\n\n\n\n\n\nPLAYER PRESSED I TOGGLE INVENTORY PANE");
		audio_play_sound(snd_gui_open,0,false);
		if (global.ref_active_gui != undefined && global.ref_active_gui._str_type == "INVENTORY"){
			hscr_destroy_gui_open();
			hscr_toggle_gui_pause(false);
		} else {
			hscr_destroy_gui_open();
			hscr_toggle_gui_pause(true);
			global.ref_active_gui = instance_create_layer(room_width / 2,room_height / 2,"ily_fx",obj_gui_inventory_pane);
		}
	}

	//---------------------//
	//PARTY PANE ARROW KEYS//
	//---------------------//
	if (global.ref_active_gui != undefined && global.ref_active_gui.sprite_index == spr_gui_party_pane){
		if (keyboard_check_pressed(vk_left)){
			audio_play_sound(snd_gui_press,0,false);
			if (ds_list_find_value(global.list_player_party,global.ref_active_gui._pos - 1) != undefined){
				global.ref_active_gui._pos--;
				global.ref_active_gui._unit_selected = ds_list_find_value(global.list_player_party,global.ref_active_gui._pos);
			}
		}

		if (keyboard_check_pressed(vk_right)){
			audio_play_sound(snd_gui_press,0,false);
			if (ds_list_find_value(global.list_player_party,global.ref_active_gui._pos + 1) != undefined){
				global.ref_active_gui._pos++;
				global.ref_active_gui._unit_selected = ds_list_find_value(global.list_player_party,global.ref_active_gui._pos);
			}
		}
	}

	//------------------//
	//ACTIVATE DECK PANE//
	//------------------//
	if (keyboard_check_pressed(ord("K"))){
		show_debug_message("\n\n\n\n\n\nPLAYER PRESSED K TOGGLE DECK PANE");
		audio_play_sound(snd_gui_open,0,false);
		if (global.ref_active_gui != undefined && global.ref_active_gui._str_type == "DECK"){
			hscr_destroy_gui_open();
			hscr_toggle_gui_pause(false);
		} else {
			hscr_destroy_gui_open();
			hscr_toggle_gui_pause(true);
			global.ref_active_gui = instance_create_layer(room_width / 2,room_height / 2,"ily_fx",obj_gui_deck_pane);
		}
	}

	//-------------------//
	//RANCH CLICK TO SHAKE//
	//-------------------//
	if (room == rm_ow_ranch){
		if (position_meeting(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),obj_ranch_beast_dummy) && mouse_check_button_pressed(mb_left)){
			var _ref_beast = instance_nearest(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),obj_ranch_beast_dummy);
			
			if (_ref_beast._state_dummy != ENUM_DUMMY_STATE.REST){
				audio_play_sound(_ref_beast._snd_cry,0,false);
				_ref_beast._spr_emoji = choose(spr_ranch_beast_happy,spr_ranch_beast_love,spr_ranch_beast_excited);
				_ref_beast._ct_emoji_timer = irandom_range(60,120);
				_ref_beast._state_dummy = ENUM_DUMMY_STATE.SHAKE;
			}
		}
	}

	//------------------//
	//CAMERA ZOOM TARGET//
	//------------------//
	if (global.ref_camera != undefined && room != rm_ow_ranch){
		var _val_zoom_step = 128;

		if (mouse_wheel_up()){
			global.val_cam_target_width = max(global.val_cam_min_size,global.val_cam_target_width - _val_zoom_step);
			global.val_cam_target_height = max(global.val_cam_min_size,global.val_cam_target_height - _val_zoom_step);
		}

		if (mouse_wheel_down()){
			global.val_cam_target_width = min(global.val_cam_max_size,global.val_cam_target_width + _val_zoom_step);
			global.val_cam_target_height = min(global.val_cam_max_size,global.val_cam_target_height + _val_zoom_step);
		}
	}
}