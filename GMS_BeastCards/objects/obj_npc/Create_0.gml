//===============================================================================//
//
// CREATE: OBJ_NPC
// FUNCTION: Initializes an overworld NPC from its assigned NPC id.
//           Loads NPC identity, visuals, interaction settings, and pathing data.
//           Tracks front/back facing separately from interaction highlighting.
//
//===============================================================================//

//================//
//VARIABLES//
//================//
#region VARIABLES

//----------------//
//NPC DATA//
//----------------//
_stct_npc = undefined;

//----------------//
//VISUALS//
//----------------//
_spr_npc = undefined;

_flag_moving = false;

_val_previous_x = x;
_val_previous_y = y;

// Base facing frame:
// 0 = Forward
// 1 = Backward
_it_facing_frame = 0;

//----------------//
//INTERACTION//
//----------------//
_flag_player_nearby = false;
_flag_triggered = false;

_ct_interaction_cooldown = 0;

// NPC remains stationary briefly after interaction closes.
_ct_post_interaction_pause = 0;

_val_interaction_distance = 48;

//----------------//
//PATHING//
//----------------//
_str_path_type = "NONE";

_path_npc = undefined;

_val_move_speed = 0;
_val_path_speed_stored = 0;

_flag_path_started = false;
_flag_path_paused = false;

#endregion

//================//
//INIT//
//================//
#region INIT

//----------------//
//LOAD NPC DATA//
//----------------//
_stct_npc = scr_npc_get_info(_str_npc_id);

if (_stct_npc == undefined){

	scr_debug_log(
		"NPC",
		"INIT",
		self,
		"NPC info not found. ID: " +
		string(_str_npc_id) +
		" | UID: " +
		string(_uid_npc)
	);

	instance_destroy();
	exit;
}

//----------------//
//APPLY NPC SPRITE//
//----------------//
_spr_npc = _stct_npc._spr_npc;

if (_spr_npc != undefined){

	sprite_index = _spr_npc;

	image_speed = 0;
	image_index = 0;

	_it_facing_frame = 0;
}

//----------------//
//LOAD PATHING DATA//
//----------------//
_str_path_type = _stct_npc._str_path_type;
_path_npc = _stct_npc._path_npc;
_val_move_speed = _stct_npc._val_move_speed;

_val_path_speed_stored = _val_move_speed;

#endregion

//================//
//METHODS//
//================//
#region METHODS

//-------------------------------------------------------------------------------//
// HSCR_NPC_START_PATH
// FUNCTION: Starts the NPC's assigned GameMaker path.
//           Uses relative positioning and reverses at each endpoint.
//
//-------------------------------------------------------------------------------//
hscr_npc_start_path = function(){

	//----------------//
	//VALIDATE PATH//
	//----------------//
	if (_str_path_type != "PATH"){
		return false;
	}

	if (_path_npc == undefined){

		scr_debug_log(
			"NPC",
			"PATH",
			self,
			"Path is undefined. UID: " + string(_uid_npc)
		);

		return false;
	}

	if (!path_exists(_path_npc)){

		scr_debug_log(
			"NPC",
			"PATH",
			self,
			"Assigned path does not exist. UID: " + string(_uid_npc)
		);

		return false;
	}

	if (_val_move_speed == 0){

		scr_debug_log(
			"NPC",
			"PATH",
			self,
			"Move speed is 0. UID: " + string(_uid_npc)
		);

		return false;
	}

	//----------------//
	//START PATH//
	//----------------//
	path_start(
		_path_npc,
		_val_move_speed,
		path_action_reverse,
		false
	);

	_val_path_speed_stored = _val_move_speed;

	_flag_path_started = true;
	_flag_path_paused = false;

	return true;
};

//-------------------------------------------------------------------------------//
// HSCR_NPC_PAUSE_PATH
// FUNCTION: Pauses active NPC path movement without ending the path.
//           Preserves path position and movement speed for later resumption.
//
//-------------------------------------------------------------------------------//
hscr_npc_pause_path = function(){

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

//-------------------------------------------------------------------------------//
// HSCR_NPC_RESUME_PATH
// FUNCTION: Resumes a paused NPC path from its existing position.
//           Does not overwrite the signed path speed while already moving,
//           allowing path_action_reverse to control endpoint reversals.
//           Restarts the path only if its assignment was lost.
//
// ARGUMENTS: None.
// RETURNS: True when the path is active or successfully resumed.
//
//-------------------------------------------------------------------------------//
hscr_npc_resume_path = function(){

	//----------------//
	//VALIDATE PATH TYPE//
	//----------------//
	if (_str_path_type != "PATH"){
		return false;
	}

	//----------------//
	//RESTART LOST PATH//
	//----------------//
	if (path_index == -1){

		_flag_path_started = false;
		_flag_path_paused = false;

		return hscr_npc_start_path();
	}

	//=====================//
	//ALREADY MOVING NORMALLY//
	//=====================//
	if (!_flag_path_paused){

		_flag_path_started = true;

		return true;
	}

	//================//
	//RESTORE SPEED//
	//================//
	if (_val_path_speed_stored == 0){

		_val_path_speed_stored =
			_val_move_speed;
	}

	/*
		Preserve the SIGN of the stored path speed.

		If path_action_reverse had the NPC moving backward along
		the path before it was paused, this resumes that same
		direction rather than forcing it forward.
	*/
	path_speed =
		_val_path_speed_stored;

	_flag_path_started = true;
	_flag_path_paused = false;

	return true;
};

//-------------------------------------------------------------------------------//
// HSCR_NPC_UPDATE_FACING
// FUNCTION: Updates NPC facing from actual movement.
//           Forward/down-facing is the default.
//           Only active upward movement uses the backward-facing frame.
//           Horizontal movement mirrors the sprite left/right.
//
// ARGUMENTS: None.
// RETURNS: Nothing.
//
//-------------------------------------------------------------------------------//
hscr_npc_update_facing = function(){

	var _val_move_x =
		x - _val_previous_x;

	var _val_move_y =
		y - _val_previous_y;

	//================//
//DEFAULT FORWARD//
//================//
	/*
		Forward is the default presentation.

		Only an NPC actively traveling upward should display
		the backward-facing sprite.
	*/
	_it_facing_frame = 0;

	//================//
//MOVING UPWARD//
//================//
	if (_val_move_y < -0.01){

		_it_facing_frame = 1;
	}

	//==================//
//HORIZONTAL FACING//
//==================//
	if (_val_move_x > 0.01){

		// Moving right.
		image_xscale =
			abs(image_xscale);
	}
	else if (_val_move_x < -0.01){

		// Moving left.
		image_xscale =
			-abs(image_xscale);
	}
};

//-------------------------------------------------------------------------------//
// HSCR_NPC_FACE_PLAYER
// FUNCTION: Turns the NPC toward the player while interaction is active.
//           Vertical separation determines front/back facing.
//           Horizontal separation determines sprite mirroring.
//
//-------------------------------------------------------------------------------//
hscr_npc_face_player = function(){

	if (!instance_exists(obj_player)){
		return false;
	}

	var _val_to_player_x =
		obj_player.x - x;

	var _val_to_player_y =
		obj_player.y - y;

	//================//
//VERTICAL FACING//
//================//
	if (_val_to_player_y > 0.01){

		// Player is below NPC.
		_it_facing_frame = 0;
	}
	else if (_val_to_player_y < -0.01){

		// Player is above NPC.
		_it_facing_frame = 1;
	}

	//==================//
	//HORIZONTAL FACING//
	//==================//
	if (_val_to_player_x > 0.01){

		// Player is right of NPC.
		image_xscale =
			abs(image_xscale);
	}
	else if (_val_to_player_x < -0.01){

		// Player is left of NPC.
		image_xscale =
			-abs(image_xscale);
	}

	return true;
};

//-------------------------------------------------------------------------------//
// HSCR_NPC_OPEN_INTERACTION
// FUNCTION: Pauses NPC movement, faces the NPC toward the player, and opens
//           the NPC interaction GUI.
//
//-------------------------------------------------------------------------------//
hscr_npc_open_interaction = function(){

	//================//
	//VALIDATE NPC//
	//================//
	if (_stct_npc == undefined){
		return false;
	}

	if (!_stct_npc._flag_interactable){
		return false;
	}

	if (_flag_triggered){
		return false;
	}

	//================//
	//INTERACTION STATE//
	//================//
	_flag_triggered = true;
	_ct_interaction_cooldown = 10;

	//================//
	//PAUSE NPC//
	//================//
	hscr_npc_pause_path();

	//================//
	//FACE PLAYER//
	//================//
	hscr_npc_face_player();

	//================//
	//CLOSE ACTIVE GUI//
	//================//
	if (
		instance_exists(obj_gui_controller) &&
		global.ref_active_gui != undefined
	){
		obj_gui_controller.hscr_gui_destroy_active();
	}

	//================//
	//PAUSE GAME//
	//================//
	if (instance_exists(obj_gui_controller)){
		obj_gui_controller.hscr_gui_set_pause(true);
	}
	else{
		global.flag_pause = true;
	}

	//================//
	//STORE ACTIVE NPC//
	//================//
	global.ref_interacting_npc = self;

	//================//
	//CREATE NPC GUI//
	//================//
	var _ref_npc_gui = instance_create_layer(
		display_get_gui_width() * 0.5,
		display_get_gui_height() * 0.5,
		"ily_fx",
		obj_gui_npc_pane
	);

	if (!instance_exists(_ref_npc_gui)){

		scr_debug_log(
			"NPC",
			"INTERACTION",
			self,
			"NPC INTERACTION FAILED" +
			" | NPC: " +
			string_upper(_stct_npc._str_npc_name) +
			" | UID: " +
			string(_uid_npc) +
			" | REASON: NPC GUI CREATION FAILED",
			"ERROR",
			"OBJ_NPC:HSCR_NPC_OPEN_INTERACTION"
		);

		_flag_triggered = false;
		global.ref_interacting_npc = undefined;

		hscr_npc_resume_path();

		return false;
	}

	_ref_npc_gui._ref_npc = self;

	_ref_npc_gui.hscr_gui_npc_init();

	global.ref_active_gui = _ref_npc_gui;

	//================//
	//BUILD OPTION DATA//
	//================//
	var _str_options = "";

	if (_stct_npc._flag_can_talk){
		_str_options = "TALK";
	}

	if (_stct_npc._flag_can_quest){

		if (_str_options != ""){
			_str_options += ",";
		}

		_str_options += "QUEST";
	}

	if (_stct_npc._flag_can_trade){

		if (_str_options != ""){
			_str_options += ",";
		}

		_str_options += "TRADE";
	}

	if (_stct_npc._flag_can_fight){

		if (_str_options != ""){
			_str_options += ",";
		}

		_str_options += "FIGHT";
	}

	if (_str_options == ""){
		_str_options = "NONE";
	}

	//================//
	//DEBUG INTERACTION//
	//================//
	scr_debug_log(
		"NPC",
		"INTERACTION",
		self,
		"NPC INTERACTION OPENED" +
		" | NPC: " +
		string_upper(_stct_npc._str_npc_name) +
		" | ID: " +
		string_upper(_str_npc_id) +
		" | UID: " +
		string(_uid_npc) +
		" | TYPE: " +
		string_upper(_stct_npc._str_npc_type) +
		" | OPTIONS: " +
		_str_options +
		" | ROOM: " +
		room_get_name(room) +
		" | POSITION: (" +
		string(round(x)) +
		"," +
		string(round(y)) +
		")",
		"INFO",
		"OBJ_NPC:HSCR_NPC_OPEN_INTERACTION"
	);

	return true;
};

//-------------------------------------------------------------------------------//
// HSCR_NPC_CLOSE_INTERACTION
// FUNCTION: Fully releases the current NPC interaction.
//           Restores player control, resumes NPC path movement, clears active
//           references, and logs the completed interaction close.
//
//-------------------------------------------------------------------------------//
hscr_npc_close_interaction = function(){

	//================//
	//STORE NPC DATA//
	//================//
	var _str_npc_name = "UNKNOWN";

	if (_stct_npc != undefined){
		_str_npc_name = string_upper(_stct_npc._str_npc_name);
	}

	//================//
	//INTERACTION STATE//
	//================//
	_flag_triggered = false;
	_flag_player_nearby = false;

	_ct_interaction_cooldown = 15;

	//================//
	//GLOBAL REFERENCES//
	//================//
	if (
		variable_global_exists("ref_interacting_npc") &&
		global.ref_interacting_npc == self
	){
		global.ref_interacting_npc = undefined;
	}

	global.ref_active_gui = undefined;

	//================//
	//UNPAUSE PLAYER//
	//================//
	if (instance_exists(obj_gui_controller)){

		obj_gui_controller.hscr_gui_set_pause(false);
	}
	else{

		global.flag_pause = false;

		if (instance_exists(obj_player)){
			scr_player_set_movement_state("START");
		}
	}

	global.flag_pause = false;

	//================//
	//SYNC POSITION//
	//================//
	/*
		Prevents the paused interaction interval from being interpreted
		as movement on the first resumed frame.
	*/
	_val_previous_x = x;
	_val_previous_y = y;

	//========================//
	//POST-INTERACTION PAUSE//
	//========================//
	_ct_post_interaction_pause = 60;

	// Keep the NPC's path paused.
	// STEP will resume it once this timer reaches 0.
	var _flag_path_resumed = false;

	//================//
	//DEBUG INTERACTION//
	//================//
	scr_debug_log(
		"NPC",
		"INTERACTION",
		self,
		"NPC INTERACTION CLOSED" +
		" | NPC: " +
		_str_npc_name +
		" | ID: " +
		string_upper(_str_npc_id) +
		" | UID: " +
		string(_uid_npc) +
		" | PATH RESUMED: " +
		(_flag_path_resumed ? "YES" : "NO"),
		"INFO",
		"OBJ_NPC:HSCR_NPC_CLOSE_INTERACTION"
	);

	return true;
};

//-------------------------------------------------------------------------------//
// HSCR_NPC_UPDATE_INTERACTION_COOLDOWN
// FUNCTION: Updates the NPC interaction cooldown.
//           Prevents the same input from immediately reopening interaction.
//
//-------------------------------------------------------------------------------//
hscr_npc_update_interaction_cooldown = function(){

	if (_ct_interaction_cooldown > 0){
		_ct_interaction_cooldown--;
	}

	if (_ct_interaction_cooldown <= 0){
		_ct_interaction_cooldown = 0;
	}
};

#endregion

//================//
//START PATHING//
//================//
hscr_npc_start_path();