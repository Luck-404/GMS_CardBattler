//===============================================================================//
//
// STEP: OBJ_OVERWORLD_BEAST
// FUNCTION: Updates overworld Beast movement and behavior.
//           Player Beasts follow the player.
//           Wild Beasts wander, chase, flee, and trigger encounters.
//           Plays nearby Beast footsteps while moving.
//
//===============================================================================//

//================//
//PAUSE CHECK//
//================//
if (global.flag_pause){
	exit;
}

//================//
//UPDATE COOLDOWNS//
//================//
if (_ct_battle_cooldown > 0){
	_ct_battle_cooldown--;
}

if (_ct_step_sound_cooldown > 0){
	_ct_step_sound_cooldown--;
}

//================//
//VALIDATE PLAYER//
//================//
if (!instance_exists(obj_player)){
	exit;
}

var _val_dist_player = point_distance(x,y,obj_player.x,obj_player.y);

//================//
//PLAYER COMPANION//
//================//
if (_str_team == "PLAYER"){

	var _val_follow_start_distance = 48;

	if (_val_dist_player > _val_follow_start_distance){

		x = lerp(x,obj_player.x,_val_follow_lerp);
		y = lerp(y,obj_player.y,_val_follow_lerp);
	}
}

//================//
//WILD BEAST//
//================//
else if (_str_team == "WILD"){

	var _val_dist_home = point_distance(x,y,_val_home_x,_val_home_y);

	//----------------//
	//ANGRY CHASE//
	//----------------//
	if (
		_str_disposition == "ANGRY" &&
		_val_dist_player <= _val_detect_radius &&
		_val_dist_home <= _val_home_radius
	){

		var _val_direction = point_direction(x,y,obj_player.x,obj_player.y);

		x += lengthdir_x(_val_move_speed + 0.5,_val_direction);
		y += lengthdir_y(_val_move_speed + 0.5,_val_direction);
	}

	//----------------//
	//SCARED FLEE//
	//----------------//
	else if (
		_str_disposition == "SCARED" &&
		_val_dist_player <= _val_detect_radius
	){

		switch (_state_scared){

			case "READY":

				_state_scared = "FLEE";
				_ct_scared_timer = irandom_range(60,120);

				_val_scared_direction = point_direction(
					obj_player.x,
					obj_player.y,
					x,
					y
				);

			break;

			case "FLEE":

				x += lengthdir_x(_val_move_speed + 0.35,_val_scared_direction);
				y += lengthdir_y(_val_move_speed + 0.35,_val_scared_direction);

				_ct_scared_timer--;

				if (_ct_scared_timer <= 0){
					_state_scared = "FROZEN";
				}

			break;

			case "FROZEN":

				// Remain stationary while the player stays nearby.

			break;
		}
	}

	//----------------//
	//WANDER//
//----------------//
	else{

		if (_ct_wander_timer <= 0){

			_ct_wander_timer = irandom_range(45,120);

			_val_target_x = _val_home_x + irandom_range(-_val_home_radius,_val_home_radius);
			_val_target_y = _val_home_y + irandom_range(-_val_home_radius,_val_home_radius);
		}
		else{
			_ct_wander_timer--;
		}

		var _val_target_distance = point_distance(
			x,
			y,
			_val_target_x,
			_val_target_y
		);

		if (_val_target_distance > 8){

			var _val_direction = point_direction(
				x,
				y,
				_val_target_x,
				_val_target_y
			);

			x += lengthdir_x(_val_move_speed,_val_direction);
			y += lengthdir_y(_val_move_speed,_val_direction);
		}
	}

	//----------------//
	//HOME LEASH//
	//----------------//
	_val_dist_home = point_distance(x,y,_val_home_x,_val_home_y);

	if (_val_dist_home > _val_home_radius + 32){

		var _val_home_direction = point_direction(
			x,
			y,
			_val_home_x,
			_val_home_y
		);

		x += lengthdir_x(_val_move_speed,_val_home_direction);
		y += lengthdir_y(_val_move_speed,_val_home_direction);
	}

	//----------------//
	//RESET SCARED STATE//
	//----------------//
	if (
		_str_disposition == "SCARED" &&
		_val_dist_player > _val_detect_radius
	){
		_state_scared = "READY";
		_ct_scared_timer = 0;
	}

	//----------------//
	//BATTLE TRIGGER//
	//----------------//
	if (
		!_flag_battle_triggered &&
		_ct_battle_cooldown <= 0 &&
		place_meeting(x,y,obj_player) &&
		!instance_exists(obj_battle_wait)
	){

		_flag_battle_triggered = true;

		scr_overworld_trigger_wild_beast_battle(self);
	}
}

//================//
//BEAST STEP SOUND//
//================//
var _flag_beast_moving = (
	abs(x - xprevious) > 0.01 ||
	abs(y - yprevious) > 0.01
);

if (
	_flag_beast_moving &&
	_val_dist_player <= 64 &&
	_ct_step_sound_cooldown <= 0
){

	audio_play_sound(
		snd_overworld_beast_step,
		0,
		false
	);

	_ct_step_sound_cooldown = 15;
}

//================//
//UPDATE FACING//
//================//
if (abs(x - xprevious) > 0.01){
	image_xscale = (x < xprevious) ? -1 : 1;
}