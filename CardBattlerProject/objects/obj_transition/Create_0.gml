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
_ref_pipeline = undefined; //pipeline created in the new room


image_alpha = 0;	// START TRANSPARENT
_fade_speed = 0.06; // FADE SPEED
depth = -10000;

//draw event definitions
_rot = 0;
enum LOADING_STATE {
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
	
	SAVING
}
_loading_step = LOADING_STATE.CREATE_GUI;