//////////////////////////////////////////////////////////////////////
//				OBJ_FIGHT_CONTROLLER CREATE							//
//																	//
// > ESTABLISH VARIABLES AND SYSTEM NEEDED TO RUN THE ENEMY SIDE OF //
//   THE ENCOUNTER.													//
//////////////////////////////////////////////////////////////////////		
image_speed = 0;
image_index = 0;

global.turn_counter = 1;

//enemy team
global.enemy_party = ds_list_create(); 
global.enemy_party_in_play = ds_list_create();
global.enemy_party_dead = ds_list_create();

//spawn an 'end turn' button
_ref_end_turn = instance_create_layer(1820,860,"GUI",obj_end_turn);
_ref_end_turn.visible = false;

_flag_forfeit = false;
_flag_exit_spawned = false;

//timers for enemy turn
_flag_init_timer = false;
_flag_begin_timer = false;
_flag_minions_timer = false;
_flag_timer_1 = false;
_flag_unit_1_went = false;
_flag_timer_2 = false;
_flag_unit_2_went = false;
_flag_timer_3 = false;
_flag_unit_3_went = false;
_flag_timer_4 = false;
_flag_unit_4_went = false;
_flag_timer_5 = false;
_flag_unit_5_went = false;
_flag_end_timer = false;

//state enumerator
enum FIGHT_CONTROLLER_STATE {
	SPAWN_ENEMIES,
	PLAYER_TURN,
	ENEMY_TURN,
	END_IDLE
}
global.fight_controller_state = FIGHT_CONTROLLER_STATE.SPAWN_ENEMIES;
