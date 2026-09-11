//===============================================================================//
//
// STEP: OBJ_TRANSITION_ZONE
// FUNCTION: Detects player contact and starts room transition.
//           Waits for transition fader before moving player and changing rooms.
//           Restores player control after destination room is loaded.
//
//===============================================================================//

//---------------//
//INITIAL TRIGGER//
//---------------//
if (instance_place(x,y,obj_player) && !_flag_triggered){
	_flag_triggered = true;

	scr_player_set_movement_state("STOP");

	_ref_fader = instance_create_layer(room_width / 2,room_height / 2,"ily_fx",obj_transition_fader);
	_ref_fader._ref_transition = self;
}

//-----------------//
//FINALIZE AND MOVE//
//-----------------//
if (_flag_continue_transition){
	_flag_continue_transition = false;

	var _arr_room = scr_transition_get_room_info(_str_to_id,_str_from_id);

	obj_player.x = _arr_room[2];
	obj_player.y = _arr_room[3];

	_ref_fader._flag_fade_in = true;

	scr_gui_spawn_popup_banner(_arr_room[1]);
	global.str_last_player_banner = _arr_room[1];

	room_goto(_arr_room[0]);

	scr_player_set_movement_state("START");
}