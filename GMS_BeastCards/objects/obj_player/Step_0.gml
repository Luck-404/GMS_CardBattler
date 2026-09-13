//===============================================================================//
//
// STEP: OBJ_PLAYER
// FUNCTION: Processes player movement input.
//           Handles facing, sprinting, collision, and movement effects.
//           Updates player movement state each frame.
//
//===============================================================================//

//================//
//PAUSE STATE//
//================//
if (global.flag_pause){

	_flag_player_moving = false;
	_flag_player_sprinting = false;

	exit;
}

//================//
//MOVEMENT INPUT//
//================//
var _val_move_x = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var _val_move_y = keyboard_check(ord("S")) - keyboard_check(ord("W"));

if (keyboard_check(vk_lshift) && _val_player_speed != 0){

	_flag_player_sprinting = true;

	_val_player_speed = 4 * global.val_bonus_speed_scalar;
}
else if (_val_player_speed != 0){

	_flag_player_sprinting = false;

	_val_player_speed = 3 * global.val_bonus_speed_scalar;
}

//================//
//SPRITE FACING//
//================//
if (_val_move_x == 0 && _val_move_y == 0){

	image_index = 0;
	image_xscale = 1;
}
else{

	//----------------//
	//MOVING UP//
	//----------------//
	if (_val_move_y < 0){

		image_index = 1;

		if (_val_move_x < 0){
			image_xscale = -1;
		}
		else{
			image_xscale = 1;
		}
	}

	//----------------//
	//DOWN OR SIDEWAYS//
	//----------------//
	else{

		image_index = 0;

		if (_val_move_x < 0){
			image_xscale = -1;
		}
		else if (_val_move_x > 0){
			image_xscale = 1;
		}
	}
}

//================//
//NORMALIZE MOVEMENT//
//================//
if (_val_move_x != 0 || _val_move_y != 0){

	_flag_player_moving = true;

	var _val_move_length = point_distance(
		0,
		0,
		_val_move_x,
		_val_move_y
	);

	_val_move_x /= _val_move_length;
	_val_move_y /= _val_move_length;
}
else{

	_flag_player_moving = false;
	_flag_player_sprinting = false;

	_ct_player_bounce_timer = 0;
	_val_player_bounce_offset = 0;
}

//================//
//CALCULATE VELOCITY//
//================//
var _val_velocity_x = _val_move_x * _val_player_speed;
var _val_velocity_y = _val_move_y * _val_player_speed;

//================//
//HORIZONTAL COLLISION//
//================//
if (place_meeting(x + _val_velocity_x,y,obj_overworld_wall)){

	while (!place_meeting(x + sign(_val_velocity_x),y,obj_overworld_wall)){
		x += sign(_val_velocity_x);
	}

	_val_velocity_x = 0;
}

x += _val_velocity_x;

//================//
//VERTICAL COLLISION//
//================//
if (place_meeting(x,y + _val_velocity_y,obj_overworld_wall)){

	while (!place_meeting(x,y + sign(_val_velocity_y),obj_overworld_wall)){
		y += sign(_val_velocity_y);
	}

	_val_velocity_y = 0;
}

y += _val_velocity_y;

//================//
//STEP PARTICLES//
//================//
if (_flag_player_moving){

	if (_ct_player_step_particle_timer <= 0){

		_ct_player_step_particle_timer = 15;

		audio_play_sound(
			snd_player_grass_step,
			0,
			false
		);

		hscr_player_spawn_step_particles();
	}
	else{
		_ct_player_step_particle_timer--;
	}
}
else{
	_ct_player_step_particle_timer = 0;
}