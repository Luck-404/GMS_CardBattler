//////////////////////////////////////////////////////////////////////
//					OBJ_FIGHT_CONTROLLER CREATE						//
//																	//
// > ESTABLISH VARIABLES AND SYSTEM NEEDED TO RUN THE ENEMY SIDE OF //
//   THE ENCOUNTER.													//
//////////////////////////////////////////////////////////////////////		
//visuals
image_speed = 0;
image_index = 0;

/////////////////////
// GUI INFORMATION //
/////////////////////
global.turn_counter = 1;
_ref_end_turn = instance_create_layer(1750,729,"GUI",obj_end_turn);
_ref_end_turn.visible = false;
_flag_forfeit = false;
_flag_exit_spawned = false;

////////////////
// ENEMY TEAM //
////////////////
global.enemy_party = ds_list_create(); 
global.enemy_party_in_play = ds_list_create();
global.enemy_party_dead = ds_list_create();

_flag_begin_turn_triggered = false;
//timers for enemy turn

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

//////////////////
// OTHER TIMERS //
//////////////////
_flag_minions_cast = false;
_flag_init_timer = false;
_flag_begin_timer = false;
_flag_minions_timer = false;
_flag_shields_handled = false;
_flag_enc_reward_timer = false;

/////////////////
// STATE ENUMS //
/////////////////
enum FIGHT_CONTROLLER_STATE {
	SPAWN_ENEMIES,
	PLAYER_TURN,
	ENEMY_TURN,
	END_IDLE
}
global.fight_controller_state = FIGHT_CONTROLLER_STATE.SPAWN_ENEMIES;


////////////////////////
// ENCOUTNER STATUSES //
////////////////////////
global.encounter_statuses = ds_list_create();