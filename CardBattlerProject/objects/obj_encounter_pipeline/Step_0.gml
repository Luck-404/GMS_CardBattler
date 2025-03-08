switch(global.encounter_pipeline_state){
	case ENC_PIPELINE_STATE.CREATE_GUI:
	show_debug_message("ENCOUTER PIPELINE: CREATING GUI...");
	show_debug_message("ENCOUTER PIPELINE: FEATURE NOT IMPLEMENTED YET...");
		//TODO
		global.encounter_pipeline_state=ENC_PIPELINE_STATE.CREATE_AMBIANCE;		
	break;
	
	
	case ENC_PIPELINE_STATE.CREATE_AMBIANCE:
		show_debug_message("ENCOUTER PIPELINE: CREATING AMBIANCE...");
		show_debug_message("ENCOUTER PIPELINE: FEATURE NOT IMPLEMENTED YET...");
		//MUSIC CONTROLLER TODO
		global.encounter_pipeline_state=ENC_PIPELINE_STATE.CREATE_FIGHT_CONTROLLER;			
	break;
	
	case ENC_PIPELINE_STATE.CREATE_FIGHT_CONTROLLER:
		show_debug_message("ENCOUTER PIPELINE: CREATING FIGHT CONTROLLER...");
		instance_create_layer(room_width/2,room_height/2, "GUI", obj_fight_controller);
		show_debug_message("ENCOUTER PIPELINE: SUCCESS...");
		global.encounter_pipeline_state=ENC_PIPELINE_STATE.INIT_LOGGER;		
	break;
	
	case ENC_PIPELINE_STATE.INIT_LOGGER:
		show_debug_message("ENCOUTER PIPELINE: CREATING AMBIANCE...");
		show_debug_message("ENCOUTER PIPELINE: FEATURE NOT IMPLEMENTED YET...");
		//TODO
		global.encounter_pipeline_state=ENC_PIPELINE_STATE.END_INIT;				
	break;

	case ENC_PIPELINE_STATE.END_INIT:
		show_debug_message("ENCOUTER PIPELINE: ENDING INIT...");
		show_debug_message("ENCOUTER PIPELINE: ENDING INIT...");
		obj_transition._transition_state_tracker = TRANSITION_STATE.FADE_IN;
		global.player_enc_state = PLAYER_ENCOUNTER_STATE.INIT;
		global.encounter_pipeline_state=ENC_PIPELINE_STATE.IDLE;
	break;
	
	case ENC_PIPELINE_STATE.IDLE:

	break;
}