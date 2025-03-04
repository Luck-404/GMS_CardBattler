//////////////////////////////////////////////////////////////////////
//						OBJ_END_TURN STEP							//
//																	//
// > HANDLE UPDATING VISUALS BASED ON TURNSTATE						//
//////////////////////////////////////////////////////////////////////
if (global.player_enc_state != PLAYER_ENCOUNTER_STATE.ENEMY_TURN_IDLE && global.player_enc_state != PLAYER_ENCOUNTER_STATE.EXIT_ENC){
	visible = true;
}

else {
	visible = false;
}