////////////////
// VARIABLES  //
////////////////
global.turn_tracker = obj_player;
show_debug_message("\n\n[[ PLAYER TURN FIRST ]]\n\n");		
//spawn an 'end turn' button
_ref_end_turn = instance_create_layer(1820,860,"GUI",obj_end_turn);
_ref_end_turn.visible = false;
show_debug_message("\n\n[[ CREATED TURN BUTTON ]]\n\n");
_flag_spawned_timer = false;
_enemy_played = false;
_flag_executed_encounter_end = false;