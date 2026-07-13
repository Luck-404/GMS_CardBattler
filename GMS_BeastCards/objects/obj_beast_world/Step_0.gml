//===============================================================================//
//
// STEP: OBJ_BEAST_WORLD
// FUNCTION: Updates overworld beast movement.
//           Player beasts follow behind the player.
//           Wild beasts wander, chase, flee, or idle based on disposition.
//
//===============================================================================//
var _val_dist_player;

if (global.flag_pause){
	exit;
}

if (_ct_battle_cooldown > 0){
	_ct_battle_cooldown--;
}

if (_str_team == "PLAYER"){

	if (!instance_exists(obj_player)){
		exit;
	}

	var _val_drag_start_dist = 48;
	var _val_drag_stop_dist = 32;
	var _val_dist_player = point_distance(x,y,obj_player.x,obj_player.y);

	// ONLY MOVE IF PLAYER GETS FAR ENOUGH AWAY
	if (_val_dist_player > _val_drag_start_dist){

		var _val_dir = point_direction(x,y,obj_player.x,obj_player.y);

		x = lerp(x,obj_player.x,_val_lerp);
		y = lerp(y,obj_player.y,_val_lerp);

		// STOP BEFORE PERFECTLY CENTERING ON PLAYER
		if (_val_dist_player <= _val_drag_stop_dist){
			x -= lengthdir_x(2,_val_dir);
			y -= lengthdir_y(2,_val_dir);
		}
	}
}
else if (_str_team == "WILD"){

	if (!instance_exists(obj_player)){
		exit;
	}

	var _val_dist_player = point_distance(x,y,obj_player.x,obj_player.y);
	var _val_dist_home = point_distance(x,y,_val_home_x,_val_home_y);

	if (_str_disposition == "ANGRY" && _val_dist_player <= _val_detect_radius && _val_dist_home <= _val_home_radius){
		var _val_dir = point_direction(x,y,obj_player.x,obj_player.y);
		x += lengthdir_x(_val_speed + 0.5,_val_dir);
		y += lengthdir_y(_val_speed + 0.5,_val_dir);
	}
	else if (_str_disposition == "SCARED" && _val_dist_player <= _val_detect_radius){

		switch(_state_scared){

			case "READY":
				_state_scared = "FLEE";
				_ct_scared_timer = irandom_range(60,120);
				_val_scared_dir = point_direction(obj_player.x,obj_player.y,x,y);
			break;

			case "FLEE":
				x += lengthdir_x(_val_speed + 0.35,_val_scared_dir);
				y += lengthdir_y(_val_speed + 0.35,_val_scared_dir);

				_ct_scared_timer--;

				if (_ct_scared_timer <= 0){
					_state_scared = "FROZEN";
				}
			break;

			case "FROZEN":
				// No movement while player remains nearby.
			break;
		}
	}
	else{
		if (_ct_wander_timer <= 0){
			_ct_wander_timer = irandom_range(45,120);

			_val_target_x = _val_home_x + irandom_range(-_val_home_radius,_val_home_radius);
			_val_target_y = _val_home_y + irandom_range(-_val_home_radius,_val_home_radius);
		}
		else{
			_ct_wander_timer--;
		}

		var _val_target_dist = point_distance(x,y,_val_target_x,_val_target_y);

		if (_val_target_dist > 8){
			var _val_dir = point_direction(x,y,_val_target_x,_val_target_y);
			x += lengthdir_x(_val_speed,_val_dir);
			y += lengthdir_y(_val_speed,_val_dir);
		}
	}

	// LIGHT HOME LEASH
	if (_val_dist_home > _val_home_radius + 32){
		var _val_home_dir = point_direction(x,y,_val_home_x,_val_home_y);
		x += lengthdir_x(_val_speed,_val_home_dir);
		y += lengthdir_y(_val_speed,_val_home_dir);
	}

	// BATTLE TRIGGER
	if (!_flag_battle_triggered && _ct_battle_cooldown <= 0 && place_meeting(x,y,obj_player) && !instance_exists(obj_wait)){
		_flag_battle_triggered = true;

		scr_trigger_world_beast_battle(self);
	}
}

// RESET SCARED STATE ONCE PLAYER LEAVES RANGE
if (_str_disposition == "SCARED" && _val_dist_player > _val_detect_radius){
	_state_scared = "READY";
	_ct_scared_timer = 0;
}

// FACE MOVEMENT ROUGHLY
if (xprevious != x){
	image_xscale = (x < xprevious) ? -1 : 1;
}