show_debug_message("\n\n\n");

enum PIPELINE_STATE	{
	CREATE_GUI,
	CREATE_AMBIANCE,
	CHECK_NPC,
	SPAWN_TREASURE,
	SPAWN_PLAYER,
	SPAWN_STATS,
	END_INIT_TRANSITION,
	IDLE,
	TRANSITION_OUT,
	TRANSITION_IN,
	RESET
}

//track the pipeline state globally
global.overworld_pipeline_state = PIPELINE_STATE.CREATE_GUI;

global.counter_shop_reset = 3; //tracks every 3 encounters, reset all shops.