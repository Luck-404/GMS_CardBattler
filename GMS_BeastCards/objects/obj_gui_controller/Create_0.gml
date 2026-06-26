//===============================================================================//
//
// CREATE: OBJ_UI_CONTROLLER
// FUNCTION: Initializes global GUI state.
//           Applies window and texture settings.
//           Defines helper scripts for GUI cleanup, pause control, and battle end.
//
//===============================================================================//

//---------//
//VARIABLES//
//---------//
global.flag_pause = false;
global.ref_active_gui = undefined;

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
	} else {
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