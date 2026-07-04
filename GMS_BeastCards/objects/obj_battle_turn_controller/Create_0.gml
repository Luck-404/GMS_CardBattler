//===============================================================================//
//
// CREATE: OBJ_BATTLE_TURN_CONTROLLER
// FUNCTION: Initializes battle controllers and turn order.
//           Creates player, enemy, and end-turn button controller objects.
//           Defines helper script for passing turns.
//
//===============================================================================//

//---------//
//VARIABLES//
//---------//
_ref_player_controller = instance_create_layer(x,y,"ily_player",obj_battle_player_controller);
_ref_enemy_controller = instance_create_layer(x,y,"ily_enemy",obj_battle_enemy_controller);

_ref_end_turn_button = instance_create_layer(928,650,"ily_fx",obj_battle_end_turn_button);

_arr_turn_order = [_ref_player_controller,_ref_enemy_controller];
_val_turn_tracker = 0;

_flag_game_start = false;
_flag_started_game = false;
_flag_battle_ended = false;

//----//
//INIT//
//----//

//-------//
//METHODS//
//-------//

//—------------------------------------------------------------------------------//
// hscr_pass_turn
// FUNCTION: Passes turn control between player and enemy controllers.
//—------------------------------------------------------------------------------//
function hscr_pass_turn(){
	if (_val_turn_tracker == 0){
		_val_turn_tracker++;
		_ref_enemy_controller._state_enemy = ENUM_ENEMY_STATE.TURN_START;
	}
	else{
		_val_turn_tracker = 0;
		_ref_player_controller._state_player = ENUM_PLAYER_STATE.TURN_START;
	}
}