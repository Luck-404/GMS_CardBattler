//===============================================================================//
//
// STEP: OBJ_GUI_CONTROLLER
// FUNCTION: Manages background music, overworld ambiance, and global GUI input.
//           Switches immediately between overworld and battle music.
//           Opens and closes player GUI panes, controls pause/fullscreen,
//           toggles the overworld companion, and handles Ranch/camera input.
//
//===============================================================================//

//================//
//MUSIC CONTROL//
//================//
#region MUSIC CONTROL

var _str_target_music_mode = (room == rm_battle) ? "BATTLE" : "OVERWORLD";

//----------------//
//MODE CHANGE//
//----------------//
if (_str_music_mode != _str_target_music_mode){

	_str_music_mode = _str_target_music_mode;

	if (_val_music_instance != -1){
		audio_stop_sound(_val_music_instance);
	}

	_val_music_instance = -1;
	_snd_current_music = undefined;

	_flag_music_silence = false;
	_ct_music_silence_timer = 0;

	//----------------//
	//ENTERING BATTLE//
	//----------------//
	if (_str_music_mode == "BATTLE"){

		if (_val_ambiance_instance != -1){
			audio_stop_sound(_val_ambiance_instance);
		}

		_val_ambiance_instance = -1;
	}

	//----------------------//
	//RETURNING TO OVERWORLD//
	//----------------------//
	else{
		hscr_gui_reset_ambiance_timer();
	}
}

//----------------//
//BATTLE MUSIC//
//----------------//
if (_str_music_mode == "BATTLE"){

	if (
		_val_music_instance == -1 ||
		!audio_is_playing(_val_music_instance)
	){
		hscr_gui_play_random_music(_arr_music_battle);
	}
}

//----------------//
//OVERWORLD MUSIC//
//----------------//
else{

	//----------------//
	//MUSIC SILENCE//
	//----------------//
	if (_flag_music_silence){

		if (_ct_music_silence_timer > 0){

			_ct_music_silence_timer--;
		}
		else{

			_flag_music_silence = false;
			_ct_music_silence_timer = 0;

			hscr_gui_play_random_music(_arr_music_overworld);
		}
	}

	//--------------------//
	//MUSIC TRACK FINISHED//
	//--------------------//
	else if (
		_val_music_instance == -1 ||
		!audio_is_playing(_val_music_instance)
	){

		if (irandom_range(1,100) <= 25){
			hscr_gui_start_music_silence();
		}
		else{
			hscr_gui_play_random_music(_arr_music_overworld);
		}
	}
}

#endregion

//================//
//AMBIANCE CONTROL//
//================//
#region AMBIANCE CONTROL

if (_str_music_mode == "OVERWORLD"){

	if (_ct_ambiance_timer > 0){

		_ct_ambiance_timer--;
	}
	else{

		if (
			_val_ambiance_instance == -1 ||
			!audio_is_playing(_val_ambiance_instance)
		){

			hscr_gui_play_random_ambiance();
			hscr_gui_reset_ambiance_timer();
		}
	}
}

#endregion

//================//
//FULLSCREEN TOGGLE//
//================//
#region FULLSCREEN TOGGLE

if (keyboard_check_pressed(ord("F"))){

	audio_play_sound(
		snd_gui_press,
		0,
		false
	);

	var _flag_fullscreen = !window_get_fullscreen();

	window_set_fullscreen(_flag_fullscreen);

	scr_debug_log(
		"GUI",
		"INPUT",
		self,
		"FULLSCREEN " +
		(_flag_fullscreen ? "ENABLED" : "DISABLED"),
		"INFO",
		"OBJ_GUI_CONTROLLER:STEP"
	);
}

#endregion

//================//
//ESC INPUT//
//================//
#region ESC INPUT

if (keyboard_check_pressed(vk_escape)){

	//================//
	//END GAME//
	//================//
	if (!instance_exists(global.ref_active_gui)){

		audio_play_sound(
			snd_gui_error,
			0,
			false
		);

		scr_debug_log(
			"PLAYER",
			"INPUT",
			self,
			"END GAME REQUESTED" +
			" | SOURCE: ESCAPE" +
			" | ROOM: " +
			room_get_name(room) +
			" | POSITION: (" +
			string(round(obj_player.x)) +
			"," +
			string(round(obj_player.y)) +
			")",
			"INFO",
			"OBJ_GUI_CONTROLLER:STEP"
		);

		game_end();
	}

	//================//
	//CLOSE ACTIVE GUI//
	//================//
	else{

		audio_play_sound(
			snd_gui_close,
			0,
			false
		);

		hscr_gui_destroy_active("ESCAPE");
		hscr_gui_set_pause(false,"ESCAPE");
	}
}

#endregion

//================//
//ROOM UI INPUTS//
//================//
#region ROOM UI INPUTS

if (room != rm_battle){

	//================//
	//PAUSE HANDLING//
	//================//
	if (
		keyboard_check_pressed(ord("T")) &&
		!instance_exists(global.ref_active_gui)
	){

		audio_play_sound(
			snd_gui_open,
			0,
			false
		);

		hscr_gui_set_pause(
			!global.flag_pause,
			"HOTKEY T"
		);
	}

	//===================//
	//ACTIVATE PARTY PANE//
	//===================//
	if (keyboard_check_pressed(ord("P"))){

		audio_play_sound(
			snd_gui_open,
			0,
			false
		);

		var _flag_party_open = false;

		if (
			instance_exists(global.ref_active_gui) &&
			variable_instance_exists(global.ref_active_gui,"_str_type")
		){
			_flag_party_open =
				global.ref_active_gui._str_type == "PARTY";
		}

		//----------------//
		//CLOSE PARTY//
		//----------------//
		if (_flag_party_open){

			hscr_gui_destroy_active("HOTKEY P");
			hscr_gui_set_pause(false,"HOTKEY P");
		}

		//----------------//
		//OPEN PARTY//
		//----------------//
		else{

			hscr_gui_destroy_active("HOTKEY P");
			hscr_gui_set_pause(true,"HOTKEY P");

			global.ref_active_gui = instance_create_layer(
				display_get_gui_width() * 0.5,
				display_get_gui_height() * 0.5,
				"ily_fx",
				obj_gui_party_pane
			);

			scr_debug_log(
				"GUI",
				"PANE",
				self,
				"GUI OPENED" +
				" | TYPE: PARTY" +
				" | SOURCE: HOTKEY P",
				"INFO",
				"OBJ_GUI_CONTROLLER:STEP"
			);
		}
	}

	//================//
	//TOGGLE COMPANION//
	//================//
	if (
		keyboard_check_pressed(ord("G")) &&
		!instance_exists(global.ref_active_gui)
	){

		//----------------//
		//SUMMON COMPANION//
		//----------------//
		if (!global.flag_companion_summoned){

			if (
				!ds_exists(global.list_player_party,ds_type_list) ||
				ds_list_size(global.list_player_party) <= 0
			){

				audio_play_sound(
					snd_gui_error,
					0,
					false
				);

				scr_debug_log(
					"PLAYER",
					"COMPANION",
					self,
					"COMPANION SUMMON BLOCKED" +
					" | REASON: PARTY EMPTY",
					"WARNING",
					"OBJ_GUI_CONTROLLER:STEP"
				);
			}
			else{

				global.flag_companion_summoned = true;

				audio_play_sound(
					snd_overworld_summon_companion_beast,
					0,
					false
				);

				scr_overworld_spawn_companion_beast();

				var _stct_unit = ds_list_find_value(
					global.list_player_party,
					0
				);

				if (is_struct(_stct_unit)){

					audio_play_sound(
						_stct_unit._snd_beast_cry,
						0,
						false
					);

					scr_debug_log(
						"PLAYER",
						"COMPANION",
						self,
						"COMPANION SUMMONED" +
						" | BEAST: " +
						string_upper(_stct_unit._str_beast_name) +
						" | LEVEL: " +
						string(_stct_unit._val_beast_level) +
						" | UID: " +
						string(_stct_unit._uid_beast),
						"INFO",
						"OBJ_GUI_CONTROLLER:STEP"
					);
				}
			}
		}

		//-----------------//
		//DISMISS COMPANION//
		//-----------------//
		else{

			var _str_companion_name = "UNKNOWN";

			if (
				ds_exists(global.list_player_party,ds_type_list) &&
				ds_list_size(global.list_player_party) > 0
			){

				var _stct_unit = ds_list_find_value(
					global.list_player_party,
					0
				);

				if (is_struct(_stct_unit)){
					_str_companion_name = string_upper(_stct_unit._str_beast_name);
				}
			}

			global.flag_companion_summoned = false;

			audio_play_sound(
				snd_overworld_summon_companion_beast,
				0,
				false
			);

			with (obj_overworld_beast){

				if (_str_team == "PLAYER"){
					instance_destroy();
				}
			}

			scr_debug_log(
				"PLAYER",
				"COMPANION",
				self,
				"COMPANION DISMISSED" +
				" | BEAST: " +
				_str_companion_name,
				"INFO",
				"OBJ_GUI_CONTROLLER:STEP"
			);
		}
	}

	//=====================//
	//ACTIVATE LOGBOOK PANE//
	//=====================//
	if (keyboard_check_pressed(ord("B"))){

		audio_play_sound(
			snd_gui_open,
			0,
			false
		);

		var _flag_logbook_open = false;

		if (
			instance_exists(global.ref_active_gui) &&
			variable_instance_exists(global.ref_active_gui,"_str_type")
		){
			_flag_logbook_open =
				global.ref_active_gui._str_type == "LOGBOOK";
		}

		//----------------//
		//CLOSE LOGBOOK//
		//----------------//
		if (_flag_logbook_open){

			hscr_gui_destroy_active("HOTKEY B");
			hscr_gui_set_pause(false,"HOTKEY B");
		}

		//----------------//
		//OPEN LOGBOOK//
		//----------------//
		else{

			hscr_gui_destroy_active("HOTKEY B");
			hscr_gui_set_pause(true,"HOTKEY B");

			global.ref_active_gui = instance_create_layer(
				display_get_gui_width() * 0.5,
				display_get_gui_height() * 0.5,
				"ily_fx",
				obj_gui_logbook_pane
			);

			scr_debug_log(
				"GUI",
				"PANE",
				self,
				"GUI OPENED" +
				" | TYPE: LOGBOOK" +
				" | SOURCE: HOTKEY B",
				"INFO",
				"OBJ_GUI_CONTROLLER:STEP"
			);
		}
	}

	//=======================//
	//ACTIVATE INVENTORY PANE//
	//=======================//
	if (keyboard_check_pressed(ord("I"))){

		audio_play_sound(
			snd_gui_open,
			0,
			false
		);

		var _flag_inventory_open = false;

		if (
			instance_exists(global.ref_active_gui) &&
			variable_instance_exists(global.ref_active_gui,"_str_type")
		){
			_flag_inventory_open =
				global.ref_active_gui._str_type == "INVENTORY";
		}

		//----------------//
		//CLOSE INVENTORY//
		//----------------//
		if (_flag_inventory_open){

			hscr_gui_destroy_active("HOTKEY I");
			hscr_gui_set_pause(false,"HOTKEY I");
		}

		//----------------//
		//OPEN INVENTORY//
		//----------------//
		else{

			hscr_gui_destroy_active("HOTKEY I");
			hscr_gui_set_pause(true,"HOTKEY I");

			global.ref_active_gui = instance_create_layer(
				display_get_gui_width() * 0.5,
				display_get_gui_height() * 0.5,
				"ily_fx",
				obj_gui_inventory_pane
			);

			scr_debug_log(
				"GUI",
				"PANE",
				self,
				"GUI OPENED" +
				" | TYPE: INVENTORY" +
				" | SOURCE: HOTKEY I",
				"INFO",
				"OBJ_GUI_CONTROLLER:STEP"
			);
		}
	}

	//=====================//
	//PARTY PANE ARROW KEYS//
	//=====================//
	if (
		instance_exists(global.ref_active_gui) &&
		variable_instance_exists(global.ref_active_gui,"_str_type") &&
		global.ref_active_gui._str_type == "PARTY"
	){

		//-------------------//
		//MOVE SELECTION LEFT//
		//-------------------//
		if (keyboard_check_pressed(vk_left)){

			audio_play_sound(
				snd_gui_press,
				0,
				false
			);

			var _val_target_pos =
				global.ref_active_gui._val_pos -
				1;

			if (
				_val_target_pos >= 0 &&
				_val_target_pos < ds_list_size(global.list_player_party)
			){

				global.ref_active_gui._val_pos = _val_target_pos;

				global.ref_active_gui._stct_unit_selected =
					ds_list_find_value(
						global.list_player_party,
						_val_target_pos
					);
			}
		}

		//--------------------//
		//MOVE SELECTION RIGHT//
		//--------------------//
		if (keyboard_check_pressed(vk_right)){

			audio_play_sound(
				snd_gui_press,
				0,
				false
			);

			var _val_target_pos =
				global.ref_active_gui._val_pos +
				1;

			if (
				_val_target_pos >= 0 &&
				_val_target_pos < ds_list_size(global.list_player_party)
			){

				global.ref_active_gui._val_pos = _val_target_pos;

				global.ref_active_gui._stct_unit_selected =
					ds_list_find_value(
						global.list_player_party,
						_val_target_pos
					);
			}
		}
	}

	//==================//
	//ACTIVATE DECK PANE//
	//==================//
	if (keyboard_check_pressed(ord("K"))){

		audio_play_sound(
			snd_gui_open,
			0,
			false
		);

		var _flag_deck_open = false;

		if (
			instance_exists(global.ref_active_gui) &&
			variable_instance_exists(global.ref_active_gui,"_str_type")
		){
			_flag_deck_open =
				global.ref_active_gui._str_type == "DECK";
		}

		//----------------//
		//CLOSE DECK//
		//----------------//
		if (_flag_deck_open){

			hscr_gui_destroy_active("HOTKEY K");
			hscr_gui_set_pause(false,"HOTKEY K");
		}

		//----------------//
		//OPEN DECK//
		//----------------//
		else{

			hscr_gui_destroy_active("HOTKEY K");
			hscr_gui_set_pause(true,"HOTKEY K");

			global.ref_active_gui = instance_create_layer(
				display_get_gui_width() * 0.5,
				display_get_gui_height() * 0.5,
				"ily_fx",
				obj_gui_deck_pane
			);

			scr_debug_log(
				"GUI",
				"PANE",
				self,
				"GUI OPENED" +
				" | TYPE: DECK" +
				" | SOURCE: HOTKEY K",
				"INFO",
				"OBJ_GUI_CONTROLLER:STEP"
			);
		}
	}

	//=====================//
	//RANCH CLICK TO SHAKE//
	//=====================//
	if (room == rm_ow_ranch){

		if (
			position_meeting(
				device_mouse_x_to_gui(0),
				device_mouse_y_to_gui(0),
				obj_ranch_beast_dummy
			) &&
			mouse_check_button_pressed(mb_left)
		){

			var _ref_beast = instance_nearest(
				device_mouse_x_to_gui(0),
				device_mouse_y_to_gui(0),
				obj_ranch_beast_dummy
			);

			if (
				instance_exists(_ref_beast) &&
				_ref_beast._state_dummy != ENUM_RANCH_BEAST_DUMMY_STATE.REST
			){

				audio_play_sound(
					_ref_beast._snd_cry,
					0,
					false
				);

				_ref_beast._spr_emoji = choose(
					spr_ranch_beast_happy,
					spr_ranch_beast_love,
					spr_ranch_beast_excited
				);

				_ref_beast._ct_emoji_timer = irandom_range(
					60,
					120
				);

				_ref_beast._state_dummy =
					ENUM_RANCH_BEAST_DUMMY_STATE.SHAKE;
			}
		}
	}

	//==================//
	//CAMERA ZOOM TARGET//
	//==================//
	if (
		global.ref_camera != undefined &&
		room != rm_ow_ranch
	){

		var _val_zoom_step = 128;

		if (mouse_wheel_up()){

			global.val_cam_target_width = max(
				global.val_cam_min_size,
				global.val_cam_target_width -
					_val_zoom_step
			);

			global.val_cam_target_height = max(
				global.val_cam_min_size,
				global.val_cam_target_height -
					_val_zoom_step
			);
		}

		if (mouse_wheel_down()){

			global.val_cam_target_width = min(
				global.val_cam_max_size,
				global.val_cam_target_width +
					_val_zoom_step
			);

			global.val_cam_target_height = min(
				global.val_cam_max_size,
				global.val_cam_target_height +
					_val_zoom_step
			);
		}
	}
}

#endregion