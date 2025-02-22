switch(global.encounter_pipeline_state){
	case ENC_PIPELINE_STATE.END_INIT:
		obj_transition._transition_state_tracker = TRANSITION_STATE.FADE_IN;
		global.encounter_pipeline_state=ENC_PIPELINE_STATE.IDLE;
	break;

	case ENC_PIPELINE_STATE.IDLE:

	break;
}