//
//
// CREATE: OBJ_UI_CONTROLLER
//
//

//VARIABLES
	#region GUI GLOBALS
	global.pause = false;
	global.active_gui = undefined;
	#endregion

//INIT
gpu_set_texfilter(true);
window_set_fullscreen(true);

//METHODS
function scr_destroy_gui_open(){
	if (global.active_gui != undefined){
		instance_destroy(global.active_gui);
		global.active_gui = undefined;
	}	
}

function scr_toggle_gui_pause(){
	
	//UPDATE PLAYER SPEED
	if (obj_player._player_speed == 0){
		scr_toggle_player_movement("START");
	} else {
		scr_toggle_player_movement("STOP");
	}	
}	

function scr_trigger_end_battle(_win_type){
	show_debug_message("\n\n\n\n\n\nBATTLE HAS ENDED")
	//DESTROY CURRENT GUI
	scr_destroy_gui_open();
	//TOGGLE PAUSE
	scr_toggle_gui_pause();
	//OPEN NEW END BATTLE GUI
	global.active_gui = instance_create_layer(room_width/2,room_height/2,"ily_fx",obj_gui_end_battle_pane);
	global.active_gui._condition = _win_type;
	}