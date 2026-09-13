//===============================================================================//
//
// STEP: OBJ_TRANSITION_ZONE
// FUNCTION: Detects player contact and begins a room transition.
//           Waits for the transition fader before positioning the player,
//           logs the completed overworld transition, and changes rooms.
//           Restores player movement as the transition completes.
//
//===============================================================================//

//================//
//INITIAL TRIGGER//
//================//
if (instance_place(x,y,obj_player) && !_flag_triggered){

	_flag_triggered = true;

	scr_player_set_movement_state("STOP");

	_ref_fader = instance_create_layer(room_width / 2,room_height / 2,"ily_fx",obj_transition_fader);
	_ref_fader._ref_transition = self;
}

//=================//
//FINALIZE AND MOVE//
//=================//
if (_flag_continue_transition){

	_flag_continue_transition = false;

	//----------------------//
	//GET TRANSITION DETAILS//
	//----------------------//
	var _arr_room_info = scr_transition_get_room_info(_str_to_id,_str_from_id);

	var _str_from_room = string_upper(room_get_name(room));
	var _str_to_room = string_upper(room_get_name(_arr_room_info[0]));

	var _val_from_x = round(obj_player.x);
	var _val_from_y = round(obj_player.y);

	var _val_to_x = round(_arr_room_info[2]);
	var _val_to_y = round(_arr_room_info[3]);

	//----------------//
	//DEBUG TRANSITION//
	//----------------//
	scr_debug_log(
		"OVERWORLD",
		"TRANSITION",
		obj_player,
		"PLAYER TRANSITION: FROM " + _str_from_room +
		" (" + string(_val_from_x) + "," + string(_val_from_y) + ")" +
		" TO " + _str_to_room +
		" (" + string(_val_to_x) + "," + string(_val_to_y) + ")",
		"TRANSITION",
		"OBJ_TRANSITION_ZONE:STEP"
	);

	//----------------//
	//POSITION PLAYER//
	//----------------//
	obj_player.x = _arr_room_info[2];
	obj_player.y = _arr_room_info[3];

	//----------------//
	//RELEASE FADER//
	//----------------//
	if (instance_exists(_ref_fader)){
		_ref_fader._flag_fade_in = true;
	}

	//----------------//
	//ROOM FEEDBACK//
	//----------------//
	scr_gui_spawn_popup_banner(_arr_room_info[1]);
	global.str_last_player_banner = _arr_room_info[1];

	//----------------//
	//CHANGE ROOM//
	//----------------//
	room_goto(_arr_room_info[0]);

	scr_player_set_movement_state("START");
}