//===============================================================================//
//
// STEP: OBJ_NPC
// FUNCTION: Updates NPC proximity, path movement state, and sprite facing.
//           Pauses path movement while gameplay is paused.
//           Opens NPC interaction when the player presses the interaction key.
//
//===============================================================================//

//================//
//VALIDATE NPC DATA//
//================//
if (_stct_npc == undefined){
	exit;
}

//================//
//STORE POSITION//
//================//
_val_previous_x = x;
_val_previous_y = y;

//================//
//UPDATE COOLDOWN//
//================//
hscr_npc_update_interaction_cooldown();

//================//
//MANAGE PAUSE STATE//
//================//
if (global.flag_pause){

	hscr_npc_pause_path();
}
else if (!_flag_triggered){

	hscr_npc_resume_path();
}

//================//
//CHECK PLAYER RANGE//
//================//
_flag_player_nearby = false;

if (instance_exists(obj_player) && _stct_npc._flag_interactable && !global.flag_pause){

	var _val_distance_to_player = point_distance(
		x,
		y,
		obj_player.x,
		obj_player.y
	);

	_flag_player_nearby = (_val_distance_to_player <= _val_interaction_distance);
}

//================//
//OPEN INTERACTION//
//================//
if (
	_flag_player_nearby &&
	!_flag_triggered &&
	_ct_interaction_cooldown <= 0 &&
	!global.flag_pause &&
	keyboard_check_pressed(ord("E"))
){
	hscr_npc_open_interaction();
}

//================//
//UPDATE MOVEMENT//
//================//
_flag_moving = (
	abs(x - _val_previous_x) > 0.01 ||
	abs(y - _val_previous_y) > 0.01
);

//================//
//UPDATE FACING//
//================//
if (_flag_moving){
	hscr_npc_update_facing();
}