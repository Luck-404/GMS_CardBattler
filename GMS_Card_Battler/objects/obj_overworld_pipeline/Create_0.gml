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
	IDLE
}

global.overworld_pipeline_state = PIPELINE_STATE.CREATE_GUI; //track the pipeline state globally