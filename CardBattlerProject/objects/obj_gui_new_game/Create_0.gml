//////////////////////////////////////////////////////////////////////
//					OBJ_GUI_NEW_GAME CREATE							//
//																	//
// > ESTABLISH THE LIST OF PATRONS/PATHS FOR THE PLAYER				//
//////////////////////////////////////////////////////////////////////
depth = -100;	//always show on top

//respawn the passer object, which will later pass on starter values to the player
if (instance_exists(obj_passer)){
	with(obj_passer){
		instance_destroy(obj_passer);	
	}
}
_ref_passer = instance_create_layer(0,0,"GUI",obj_passer);

//LIST OF AVAILABLE PATRONS AND THEIR DETAILS (DSLIST - CALL SCRIPT TO POPULATE)
_list_patrons = ds_list_create();
scr_populate_patrons(_list_patrons);

//CURRENTLY HOVERED PATRON/PATH
_flag_hover_patron = false;

//CURRENTLY SELECTED PATRON/PATH
_selected_patron = undefined;

//LIST OF BLESSINGS (DSLIST - CALL SCRIPT TO POPULATE IN STEP WHEN A PATRON IS SELECTED)
_list_blessings = ds_list_create();

//CURRENTLY HOVERED BLESSING
_flag_hover_blessing = true;

//CURRENTLY SELECTED BLESSING
_selected_blessing = undefined;

//CONFIRM BUTTON IS ACTIVE IF THERE IS A BLESSING AND PATRON SELECTED
_flag_confirm_active = false;

//HOVERING OVER CONFIRM BUTTON
_flag_hover_confirm = false;

//AFTER CLICKING CONFIRM, WAITS FOR THE PASSER TO BE READY TO TRANSITION
_flag_ready_to_transition = false;