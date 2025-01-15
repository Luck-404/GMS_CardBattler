show_debug_message("((o)) OBJ_TURN_COORDINATOR: CREATED AND ALIVE ((o))");
////////////////
// VARIABLES  //
////////////////
show_debug_message("((o)) OBJ_TURN_COORDINATOR: PLAYER TURN TO START ((o))");
global.turn_tracker = obj_player;		
//spawn an 'end turn' button
show_debug_message("((o)) OBJ_TURN_COORDINATOR: SPAWNING OBJ_END_TURN ((o))");
_ref_end_turn = instance_create_layer(1820,860,"GUI",obj_end_turn);
_ref_end_turn.visible = false;
show_debug_message("((o)) OBJ_TURN_COORDINATOR: END_TURN CREATED! ((o))");

_flag_spawned_timer = false;
_enemy_played = false;
_flag_executed_encounter_end = false;