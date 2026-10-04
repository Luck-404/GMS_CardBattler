//===============================================================================//
//
// STEP: OBJ_NPC
// FUNCTION: Updates NPC proximity, path movement, and directional facing.
//           Allows GameMaker path_action_reverse to control path direction.
//           Forward-facing is the idle/default orientation; backward-facing is
//           used only while actively moving upward.
//
//===============================================================================//

//================//
//VALIDATE NPC DATA//
//================//
if (_stct_npc == undefined){
	exit;
}

//================//
//UPDATE COOLDOWN//
//================//
hscr_npc_update_interaction_cooldown();

//========================//
//POST-INTERACTION PAUSE//
//========================//
if (
	!global.flag_pause &&
	!_flag_triggered &&
	_ct_post_interaction_pause > 0
){

	_ct_post_interaction_pause--;

	if (_ct_post_interaction_pause < 0){
		_ct_post_interaction_pause = 0;
	}
}

//================//
//MANAGE PATH STATE//
//================//
if (global.flag_pause){

	if (!_flag_path_paused){
		hscr_npc_pause_path();
	}
}
else if (
	!_flag_triggered &&
	_ct_post_interaction_pause <= 0 &&
	_flag_path_paused
){

	hscr_npc_resume_path();
}

//================//
//CHECK PLAYER RANGE//
//================//
_flag_player_nearby = false;

if (
	instance_exists(obj_player) &&
	_stct_npc._flag_interactable &&
	!global.flag_pause
){

	var _val_distance_to_player =
		point_distance(
			x,
			y,
			obj_player.x,
			obj_player.y
		);

	_flag_player_nearby =
		(
			_val_distance_to_player <=
			_val_interaction_distance
		);
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
var _val_move_x =
	x - _val_previous_x;

var _val_move_y =
	y - _val_previous_y;

_flag_moving =
	abs(_val_move_x) > 0.01 ||
	abs(_val_move_y) > 0.01;

//================//
//UPDATE FACING//
//================//
if (
	_flag_moving &&
	!_flag_triggered
){

	hscr_npc_update_facing();
}

//================//
//IDLE DEFAULT//
//================//
else if (
	!_flag_triggered &&
	_ct_post_interaction_pause <= 0
){
	_it_facing_frame = 0;
}
//================//
//STORE POSITION//
//================//
_val_previous_x = x;
_val_previous_y = y;