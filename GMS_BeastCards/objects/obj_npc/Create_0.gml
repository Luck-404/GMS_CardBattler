//===============================================================================//
//
// CREATE: OBJ_NPC
// FUNCTION: Initializes an overworld NPC from its assigned NPC ID.
//           Loads NPC identity, visuals, interaction settings, and pathing data.
//           Defines path start, pause, resume, and interaction helper scripts.
//
//===============================================================================//

//---------//
//VARIABLES//
//---------//
#region VARIABLES

	//----------//
	// NPC DATA //
	//----------//
	_stct_npc = undefined;

	//---------//
	// VISUALS //
	//---------//
	_spr_npc = undefined;

	_flag_moving = false;

	_val_previous_x = x;
	_val_previous_y = y;

	//-------------//
	// INTERACTION //
	//-------------//
	_flag_player_nearby = false;
	_flag_triggered = false;

	_ct_interaction_cooldown = 0;

	_val_interaction_distance = 48;

	//---------//
	// PATHING //
	//---------//
	_str_path_type = "NONE";

	_path_npc = undefined;

	_val_move_speed = 0;
	_val_path_speed_stored = 0;

	_flag_path_started = false;
	_flag_path_paused = false;

#endregion

//----//
//INIT//
//----//
#region INIT

	//----------------//
	// LOAD NPC DATA //
	//----------------//
	_stct_npc = scr_get_npc_info(_str_npc_id);

	if (_stct_npc == undefined){

		show_debug_message(
			"NPC ERROR: NPC INFO NOT FOUND | ID: " +
			string(_str_npc_id) +
			" | UID: " +
			string(_uid_npc)
		);

		instance_destroy();
		exit;
	}

	//-------------------//
	// APPLY NPC SPRITE //
	//-------------------//
	_spr_npc = _stct_npc._spr_npc;

	if (_spr_npc != undefined){
		sprite_index = _spr_npc;
	}

	//--------------------//
	// LOAD PATHING DATA //
	//--------------------//
	_str_path_type = _stct_npc._str_path_type;
	_path_npc = _stct_npc._path_npc;
	_val_move_speed = _stct_npc._val_move_speed;

	_val_path_speed_stored = _val_move_speed;


#endregion

//-------//
//METHODS//
//-------//
#region METHODS

//—------------------------------------------------------------------------------//
// hscr_start_npc_path
// FUNCTION: Starts the NPC's assigned GameMaker path.
//           Uses relative path positioning and reverses direction at each endpoint.
//           Does nothing when the NPC has no valid path assignment.
//—------------------------------------------------------------------------------//
hscr_start_npc_path = function(){

	if (_str_path_type != "PATH"){
		return false;
	}

	if (_path_npc == undefined){
		show_debug_message(
			"NPC PATH WARNING: PATH UNDEFINED | UID: " +
			string(_uid_npc)
		);

		return false;
	}

	if (!path_exists(_path_npc)){
		show_debug_message(
			"NPC PATH WARNING: PATH DOES NOT EXIST | UID: " +
			string(_uid_npc)
		);

		return false;
	}

	if (_val_move_speed == 0){
		show_debug_message(
			"NPC PATH WARNING: MOVE SPEED IS 0 | UID: " +
			string(_uid_npc)
		);

		return false;
	}

	/*
		FALSE makes the path relative to the NPC's room position.

		The path's first point effectively becomes anchored around where
		the NPC instance was placed in the room.
	*/
	path_start(
		_path_npc,
		_val_move_speed,
		path_action_reverse,
		false
	);

	_val_path_speed_stored = _val_move_speed;

	_flag_path_started = true;
	_flag_path_paused = false;

	//show_debug_message(
	//	"NPC PATH STARTED | UID: " +
	//	string(_uid_npc)
	//);

	return true;
};


//—------------------------------------------------------------------------------//
// hscr_pause_npc_path
// FUNCTION: Pauses active NPC path movement without ending the path.
//           Preserves path position so movement can resume from the same location.
//—------------------------------------------------------------------------------//
hscr_pause_npc_path = function(){

	if (!_flag_path_started){
		return false;
	}

	if (path_index == -1){
		return false;
	}

	if (_flag_path_paused){
		return true;
	}

	if (path_speed != 0){
		_val_path_speed_stored = path_speed;
	}

	path_speed = 0;

	_flag_path_paused = true;
	_flag_moving = false;

	return true;
};


//—------------------------------------------------------------------------------//
// hscr_resume_npc_path
// FUNCTION: Resumes the NPC's current path from its existing position.
//           Repairs inconsistent paused-state flags when path_speed remains zero.
//—------------------------------------------------------------------------------//
hscr_resume_npc_path = function(){

	if (_str_path_type != "PATH"){
		return false;
	}

	/*
		If the path was somehow removed, restart it.
		This is a fallback rather than the normal resume behavior.
	*/
	if (path_index == -1){

		_flag_path_started = false;
		_flag_path_paused = false;

		return hscr_start_npc_path();
	}

	if (_val_path_speed_stored == 0){
		_val_path_speed_stored = _val_move_speed;
	}

	/*
		Do not return early based only on _flag_path_paused.

		The trade-pane transfer can leave path_speed at zero even if
		the custom flag becomes inconsistent.
	*/
	path_speed = _val_path_speed_stored;

	_flag_path_started = true;
	_flag_path_paused = false;

	//show_debug_message(
	//	"NPC PATH RESUMED | UID: " +
	//	string(_uid_npc) +
	//	" | SPEED: " +
	//	string(path_speed) +
	//	" | POSITION: " +
	//	string(path_position)
	//);

	return true;
};


//—------------------------------------------------------------------------------//
// hscr_stop_npc_path
// FUNCTION: Completely ends NPC path movement.
//           Unlike pausing, this removes the active path assignment.
//—------------------------------------------------------------------------------//
hscr_stop_npc_path = function(){

	if (path_index != -1){
		path_end();
	}

	_flag_path_started = false;
	_flag_path_paused = false;
	_flag_moving = false;
};


//—------------------------------------------------------------------------------//
// hscr_update_npc_facing
// FUNCTION: Updates NPC horizontal sprite facing from actual movement.
//           Preserves current facing while the NPC is stationary.
//—------------------------------------------------------------------------------//
hscr_update_npc_facing = function(){

	var _val_move_x = x - _val_previous_x;

	if (_val_move_x > 0.01){
		image_xscale = abs(image_xscale);
	}
	else if (_val_move_x < -0.01){
		image_xscale = -abs(image_xscale);
	}
};


//—------------------------------------------------------------------------------//
// hscr_open_npc_interaction
// FUNCTION: Pauses NPC movement and opens the NPC interaction GUI.
//           Passes this NPC instance to the GUI pane.
//—------------------------------------------------------------------------------//
hscr_open_npc_interaction = function(){

	if (_stct_npc == undefined){
		return;
	}

	if (!_stct_npc._flag_interactable){
		return;
	}

	if (_flag_triggered){
		return;
	}

	_flag_triggered = true;
	_ct_interaction_cooldown = 10;

	//-------------------//
	// PAUSE NPC PATH   //
	//-------------------//
	hscr_pause_npc_path();

	//-------------------//
	// CLOSE ACTIVE GUI //
	//-------------------//
	if (
		instance_exists(obj_gui_controller) &&
		global.ref_active_gui != undefined
	){
		obj_gui_controller.hscr_destroy_gui_open();
	}

	//--------------//
	// PAUSE GAME   //
	//--------------//
	if (instance_exists(obj_gui_controller)){
		obj_gui_controller.hscr_toggle_gui_pause(true);
	}
	else{
		global.flag_pause = true;
	}

	//-----------------------//
	// STORE ACTIVE NPC REF  //
	//-----------------------//
	global.ref_interacting_npc = self;

	//----------------//
	// CREATE GUI     //
	//----------------//
	var _ref_npc_gui = instance_create_layer(
		room_width * 0.5,
		room_height * 0.5,
		"ily_fx",
		obj_gui_npc_pane
	);

	_ref_npc_gui._ref_npc = self;
	_ref_npc_gui.hscr_npc_init();

	global.ref_active_gui = _ref_npc_gui;

	show_debug_message(
		"NPC INTERACTION OPENED | ID: " +
		string(_str_npc_id) +
		" | UID: " +
		string(_uid_npc)
	);
};


//—------------------------------------------------------------------------------//
// hscr_close_npc_interaction
// FUNCTION: Fully releases the current NPC interaction.
//           Restores player control and forces NPC path movement to resume.
//—------------------------------------------------------------------------------//
hscr_close_npc_interaction = function(){

	//-------------------//
	// INTERACTION STATE //
	//-------------------//
	_flag_triggered = false;
	_flag_player_nearby = false;

	_ct_interaction_cooldown = 15;

	//-------------------//
	// GLOBAL REFERENCES //
	//-------------------//
	if (
		variable_global_exists("ref_interacting_npc") &&
		global.ref_interacting_npc == self
	){
		global.ref_interacting_npc = undefined;
	}

	global.ref_active_gui = undefined;

	//----------------//
	// UNPAUSE PLAYER //
	//----------------//
	if (instance_exists(obj_gui_controller)){

		obj_gui_controller.hscr_toggle_gui_pause(false);
	}
	else{

		global.flag_pause = false;

		if (instance_exists(obj_player)){
			scr_toggle_player_movement("START");
		}
	}

	/*
		Set this explicitly in case the GUI controller's helper does
		not update the global before the path is resumed.
	*/
	global.flag_pause = false;

	//-----------------//
	// RESUME NPC PATH //
	//-----------------//
	hscr_resume_npc_path();

	show_debug_message(
		"NPC INTERACTION CLOSED | UID: " +
		string(_uid_npc) +
		" | PATH INDEX: " +
		string(path_index) +
		" | PATH SPEED: " +
		string(path_speed) +
		" | PAUSED FLAG: " +
		string(_flag_path_paused)
	);
};


//—------------------------------------------------------------------------------//
// hscr_update_interaction_cooldown
// FUNCTION: Updates the NPC interaction cooldown.
//           Prevents the same input from immediately reopening the interaction.
//—------------------------------------------------------------------------------//
hscr_update_interaction_cooldown = function(){

	if (_ct_interaction_cooldown > 0){
		_ct_interaction_cooldown--;
	}

	if (_ct_interaction_cooldown <= 0){
		_ct_interaction_cooldown = 0;
	}
};

#endregion


//----------------//
// START PATHING //
//----------------//
hscr_start_npc_path();