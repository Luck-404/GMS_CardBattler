//////////////////////////////////////////////////////////////////////
//					OBJ_OVERWORLD_PIPELINE CREATE					//
//																	//
// > ESTABLISH DEFINITIONS FOR THE OVERWOLRD PIPELINE				//
//////////////////////////////////////////////////////////////////////
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

//the tileset to focus on in certian bits of code (placing treasures and such)
_tileset = layer_tilemap_get_id("tl_overworld");
global.saved_ts = tilemap_get_tileset(_tileset);