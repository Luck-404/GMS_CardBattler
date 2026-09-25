//===============================================================================//
//
// CREATE: OBJ_OVERWORLD_BEAST
// FUNCTION: Initializes an overworld Beast instance.
//           Supports player-companion and wild-Beast behavior.
//           Stores Beast data, movement, leash, battle, and sound state.
//
//===============================================================================//

//================//
//VARIABLES//
//================//

//----------------//
//BEAST DATA//
//----------------//
_str_team = "WILD";

_stct_unit = undefined;

_spr_beast = undefined;
_spr_shadow = undefined;

_ref_home = noone;

//----------------//
//ENCOUNTER POOL//
//----------------//
// Optional per-Beast encounter pool override.
// Used by cheat-spawned visible wild Beasts.
_arr_encounter_pool = [];

//----------------//
//WILD BEHAVIOR//
//----------------//
_str_disposition = "CHILL";

_state_scared = "READY";

_ct_scared_timer = 0;

_val_scared_direction = 0;

//----------------//
//HOME LEASH//
//----------------//
_val_home_x = x;
_val_home_y = y;

_val_home_radius = 96;
_val_detect_radius = 96;

//----------------//
//MOVEMENT//
//----------------//
_val_follow_lerp = 0.05;
_val_move_speed = 0.9;

_val_target_x = x;
_val_target_y = y;

_ct_wander_timer = irandom_range(30,90);

//----------------//
//BATTLE//
//----------------//
_ct_battle_cooldown = 30;

_flag_battle_triggered = false;

//----------------//
//AUDIO//
//----------------//
_ct_step_sound_cooldown = 0;

//================//
//INIT//
//================//

//----------------//
//SET HOME//
//----------------//
if (instance_exists(_ref_home)){
	_val_home_x = _ref_home.x;
	_val_home_y = _ref_home.y;
}

//----------------//
//SET BEAST SPRITE//
//----------------//
if (_stct_unit != undefined){
	_spr_beast = _stct_unit._spr_beast;
}
else{
	_spr_beast = spr_beast_viridian_arbrawn;
}

//----------------//
//ROLL DISPOSITION//
//----------------//
if (_str_team == "WILD"){

	var _it_disposition = irandom_range(0,2);

	switch (_it_disposition){

		case 0:
			_str_disposition = "ANGRY";
		break;

		case 1:
			_str_disposition = "CHILL";
		break;

		case 2:
			_str_disposition = "SCARED";
		break;
	}
}

//================//
//METHODS//
//================//