enum ENC_PIPELINE_STATE	{
	CREATE_GUI,
	CREATE_AMBIANCE,
	CREATE_FIGHT_CONTROLLER,
	INIT_LOGGER,
	END_INIT,
	IDLE
}

global.encounter_pipeline_state = ENC_PIPELINE_STATE.CREATE_GUI; //track the pipeline state globally