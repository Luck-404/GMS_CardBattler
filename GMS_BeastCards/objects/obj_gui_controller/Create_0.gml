//
//
// CREATE: OBJ_UI_CONTROLLER
//
//

//VARIABLES
global.pause = false;
global.active_gui = undefined;

//INIT
window_set_fullscreen(true);

//METHODS
function scr_destroy_gui_open(){
	if (global.active_gui != undefined){
		instance_destroy(global.active_gui);
		global.active_gui = undefined;
	}	
}
function scr_toggle_gui_pause(){
	global.pause = !global.pause;
	
	//UPDATE PLAYER SPEED
	if (obj_player._player_speed == 0){
		obj_player._player_speed = 3;
	} else {
		obj_player._player_speed = 0;
	}	
}