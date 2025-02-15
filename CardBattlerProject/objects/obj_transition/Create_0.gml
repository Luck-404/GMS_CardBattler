///////////////////////////////////////////////////////////////////////
//						OBJ_TRANSITION CREATE						//
//																	//
// > CDEFINE CREATE OBJECT VARIABLES								//
//////////////////////////////////////////////////////////////////////

//ENUM for state machine
enum TRANSITION_STATE {
	FADE_OUT,
	TRANSITION,
	CREATE_PIPELINE,
	LOADING,
	FADE_IN,
	DELETE
}

_transition_state_tracker = TRANSITION_STATE.FADE_OUT; //STATE TRACKER
_target_room = undefined;	// TARGET ROOM
	//MM => OW
	//OW => MM

	//OW => OW

	//OW => Encounter
	//Encounter => OW

image_alpha = 0;	// START TRANSPARENT
_fade_speed = 0.06; // FADE SPEED
depth = -10000; //ALWAYS SHOW ON TOP
_rot = 0; //FOR DRAW EVENT SPINNER
enum LOADING_STATE { //DRAW EVENT STATE TRACKER
	CREATE_GUI,
	CREATE_AMBIANCE,
	DATA_RETRIEVAL,
	SPAWN_TREASURES,
	SPAWN_PLAYER,
	SPAWN_LOGGER,
	
	SPAWN_ENEMY_TEAM,
	SPAWN_ALLY_TEAM,
	SPAWN_DECK,
	INIT_LOGGER,
	
	SAVING,
	
	IDLE
}

_ref_pipeline = undefined; //pipeline REFERENCE, TO START THE DRAW EVENT
_loading_step = LOADING_STATE.IDLE;
_pipeline = undefined;
