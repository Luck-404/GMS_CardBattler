//
//
// CREATE: OBJ_TURN_CONTROLLER
//
//

//
//VARIABLES
//
_player_controller = instance_create_layer(x,y,"ily_player",obj_battle_player_controller);
_enemy_controller = instance_create_layer(x,y,"ily_enemy",obj_battle_enemy_controller);

_end_turn_button = instance_create_layer(928,650,"ily_fx",obj_battle_button_end_turn);

_turn_order = [_player_controller,_enemy_controller];
_turn_tracker = 0;

_flag_game_start = false;
_flag_started_game = false;
_flag_battle_ended = false;

//
//INIT
//

//
//METHODS
//
function scr_pass_turn(){
	if(_turn_tracker == 0){ //(player->enemy)
		_turn_tracker++;
		_enemy_controller._enemy_state = ENEMY_STATE.TURN_START;

	}else { //(enemy->player)
		_turn_tracker = 0;	
		_player_controller._player_state = PLAYER_STATE.TURN_START;
	}
}
