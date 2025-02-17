//////////////////////////////////////////////////////////////////////
//					OBJ_OVERWORLD_PIPELINE CREATE					//
//																	//
// > ESTABLISH DEFINITIONS FOR THE OVERWOLRD PIPELINE				//
//////////////////////////////////////////////////////////////////////
randomize();

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

global.overworld_pipeline_state = PIPELINE_STATE.CREATE_GUI; //track the pipeline state globally

global.counter_card_shop_reset = 0; //tracks every 3 encounters, reset card shops.
global.counter_merc_shop_reset = 0; //tracks every 3 encounters, reset merc shops.