//===============================================================================//
//
// STEP: OBJ_UI_CONTROLLER
// FUNCTION: Handles global UI keyboard commands.
//           Opens, closes, and toggles active GUI panes.
//           Handles ranch click interaction and camera zoom input.
//
//===============================================================================//

//-----------------//
//FULLSCREEN TOGGLE//
//-----------------//
if (keyboard_check_pressed(ord("F"))){
	window_set_fullscreen(!window_get_fullscreen());
}

//--------//
//ESC INPUT//
//--------//
if (keyboard_check_pressed(vk_escape) && global.ref_active_gui == undefined){
	show_debug_message("\n\n\n\n\n\nPLAYER PRESSED ESCAPE TO END GAME");
	game_end();
} else if (keyboard_check_pressed(vk_escape)){
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
		show_debug_message("\n\n\n\n\n\nPLAYER PRESSED T TOGGLE PAUSE GAME");
		hscr_toggle_gui_pause(!global.flag_pause);
	}

	//-------------------//
	//ACTIVATE PARTY PANE//
	//-------------------//
	if (keyboard_check_pressed(ord("P"))){
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
			if (ds_list_find_value(global.list_player_party,global.ref_active_gui._pos - 1) != undefined){
				global.ref_active_gui._pos--;
				global.ref_active_gui._unit_selected = ds_list_find_value(global.list_player_party,global.ref_active_gui._pos);
			}
		}

		if (keyboard_check_pressed(vk_right)){
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