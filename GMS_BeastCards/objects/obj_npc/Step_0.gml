//===============================================================================//
//
// STEP: OBJ_NPC
// FUNCTION: Updates NPC proximity, path movement state, and sprite facing.
//           Pauses path movement while gameplay is paused.
//           Opens NPC interaction when the player presses the interaction key.
//
//===============================================================================//

//-------------------//
// VALIDATE NPC DATA //
//-------------------//
if (_stct_npc == undefined){
	exit;
}

//-------------------------//
// STORE PREVIOUS POSITION //
//-------------------------//
_val_previous_x = x;
_val_previous_y = y;

//-----------------------------//
// UPDATE INTERACTION COOLDOWN //
//-----------------------------//
hscr_update_interaction_cooldown();

//---------------------------//
// MANAGE GLOBAL PAUSE STATE //
//---------------------------//
if (global.flag_pause){

	/*
		The interacting NPC is already paused by
		hscr_open_npc_interaction().

		This additional check ensures NPCs also stop when another GUI
		or system pauses the game.
	*/
	hscr_pause_npc_path();
}
else{

	/*
		Do not resume this NPC if it still considers itself actively
		engaged in interaction.
	*/
	if (!_flag_triggered){
		hscr_resume_npc_path();
	}
}

//--------------------//
// PLAYER RANGE CHECK //
//--------------------//
_flag_player_nearby = false;

if (
	instance_exists(obj_player) &&
	_stct_npc._flag_interactable &&
	!global.flag_pause
){
	var _val_distance_to_player = point_distance(
		x,
		y,
		obj_player.x,
		obj_player.y
	);

	_flag_player_nearby = (
		_val_distance_to_player <=
		_val_interaction_distance
	);
}

//------------------//
// OPEN INTERACTION //
//------------------//
if (
	_flag_player_nearby &&
	!_flag_triggered &&
	_ct_interaction_cooldown <= 0 &&
	!global.flag_pause &&
	keyboard_check_pressed(ord("E"))
){
	hscr_open_npc_interaction();
}

//-----------------------//
// UPDATE MOVEMENT STATE //
//-----------------------//
_flag_moving = (
	abs(x - _val_previous_x) > 0.01 ||
	abs(y - _val_previous_y) > 0.01
);

//--------------------//
// UPDATE NPC FACING  //
//--------------------//
if (_flag_moving){
	hscr_update_npc_facing();
}