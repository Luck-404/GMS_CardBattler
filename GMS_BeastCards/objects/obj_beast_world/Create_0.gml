//===============================================================================//
//
// CREATE: OBJ_BEAST_WORLD
// FUNCTION: Initializes an overworld beast instance.
//           Supports player companion and wild beast behavior.
//           Stores unit reference, team, movement, leash, and battle data.
//
//===============================================================================//

//---------//
//VARIABLES//
//---------//
_str_team = "WILD"; // PLAYER, WILD

_ref_unit = undefined;
_ref_home = noone;

_str_disposition = "CHILL"; // ANGRY, CHILL, SCARED

_val_home_x = x;
_val_home_y = y;

_val_lerp = 0.05;
_val_speed = 0.9;

_state_scared = "READY"; // READY, FLEE, FROZEN
_ct_scared_timer = 0;
_val_scared_dir = 0;

_val_home_radius = 96;
_val_detect_radius = 96;

_val_target_x = x;
_val_target_y = y;

_ct_wander_timer = irandom_range(30,90);
_ct_battle_cooldown = 30;

_flag_battle_triggered = false;

//----//
//INIT//
//----//
if (_ref_home != noone){
	_val_home_x = _ref_home.x;
	_val_home_y = _ref_home.y;
}

if (_ref_unit != undefined){
	_spr_beast = _ref_unit._spr_beast;
}
else{
	_spr_beast = spr_beast_viridian_arbrawn;
}

if (_str_team == "WILD"){
	var _val_roll = irandom_range(0,2);

	switch(_val_roll){
		case 0: _str_disposition = "ANGRY"; break;
		case 1: _str_disposition = "CHILL"; break;
		case 2: _str_disposition = "SCARED"; break;
	}
}