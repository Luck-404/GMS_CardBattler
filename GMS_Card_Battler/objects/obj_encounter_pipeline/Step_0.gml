//////////////////////////////////////////////////////////////////////
//					OBJ_ENCOUNTER_PIPELINE STEP						//
//																	//
// > HANDLE LOGIC FROM THE ENCOUNTER SETUP STATES					//
//////////////////////////////////////////////////////////////////////
switch(global.encounter_pipeline_state){
	#region CREATE GUI
	case ENC_PIPELINE_STATE.CREATE_GUI:
	show_debug_message("ENCOUTER PIPELINE: CREATING GUI...");
	show_debug_message("ENCOUTER PIPELINE: FEATURE NOT IMPLEMENTED YET...");
		//TODO
		global.encounter_pipeline_state=ENC_PIPELINE_STATE.CREATE_AMBIANCE;		
	break;
	#endregion
	
	
	
	#region CREATE AMBIANCE
	case ENC_PIPELINE_STATE.CREATE_AMBIANCE:
		show_debug_message("ENCOUTER PIPELINE: CREATING AMBIANCE...");
		show_debug_message("ENCOUTER PIPELINE: FEATURE NOT IMPLEMENTED YET...");
		//MUSIC CONTROLLER TODO
		global.encounter_pipeline_state=ENC_PIPELINE_STATE.CREATE_FIGHT_CONTROLLER;			
	break;
	#endregion
	
	
	
	#region CREATE FIGHT CONTROLLER
	case ENC_PIPELINE_STATE.CREATE_FIGHT_CONTROLLER:
		show_debug_message("ENCOUTER PIPELINE: CREATING FIGHT CONTROLLER...");
		instance_create_layer(room_width/2,room_height/2, "GUI", obj_fight_controller);
		show_debug_message("ENCOUTER PIPELINE: SUCCESS...");
		global.encounter_pipeline_state=ENC_PIPELINE_STATE.INIT_LOGGER;		
	break;
	#endregion
	
	
	
	#region INIT_LOGGER
	case ENC_PIPELINE_STATE.INIT_LOGGER:
		show_debug_message("ENCOUTER PIPELINE: CREATING AMBIANCE...");
		show_debug_message("ENCOUTER PIPELINE: FEATURE NOT IMPLEMENTED YET...");
		//TODO
		global.encounter_pipeline_state=ENC_PIPELINE_STATE.END_INIT;				
	break;
	#endregion
	
	
	
	#region END_INIT
	case ENC_PIPELINE_STATE.END_INIT:
		show_debug_message("ENCOUTER PIPELINE: ENDING INIT...");
		show_debug_message("ENCOUTER PIPELINE: ENDING INIT...");
		obj_transition._transition_state_tracker = TRANSITION_STATE.FADE_IN;
		global.player_enc_state = PLAYER_ENCOUNTER_STATE.INIT;
		global.encounter_pipeline_state=ENC_PIPELINE_STATE.IDLE;
	break;
	#endregion
	
	
	
	#region IDLE
	case ENC_PIPELINE_STATE.IDLE:

	break;
	#endregion	
}