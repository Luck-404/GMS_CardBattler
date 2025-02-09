show_debug_message("\n\n\n");

enum ENCOUNTER_PIPELINE_STATE	{
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
global.encounter_pipeline_state = ENCOUNTER_PIPELINE_STATE.CREATE_GUI;

global.counter_card_shop_reset = 0; //tracks every 3 encounters, reset card shops.
global.counter_merc_shop_reset = 0; //tracks every 3 encounters, reset merc shops.