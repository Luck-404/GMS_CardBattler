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

//VARIABLES TO TRACK THE LOCATION OF THE 'CLOSE X' BUTTON
//TODO

//LIST OF AVAILABLE PATRONS AND THEIR DETAILS (DSLIST - CALL SCRIPT TO POPULATE)
_list_patrons = ds_list_create();
scr_populate_patrons(_list_patrons);

//VARIABLES TO TRACK THE START OF THE PATRONS GUI GRIDS
_patrons_start_x = 0; 
_patrons_start_y = 0;
_patrons_box_w = 64;
_patrons_box_h = 64;	
_patrons_x_pos = 0;
_patrons_y_pos = 0;

//REFERENCE SELECTED PATRON/PATH, USED TO ACTIVATE BLESSINGS AND TO BE PASSED ONTO THE PASSER
_selected_patron = undefined;

//ARRAY OF BLESSINGS, A PATRON HAS AN ARRAY OF 3 ATTACHED BLESSINGS (A DSMAP OBJECT IN EACH CELL).
_array_blessings = [];

//VARIABLES TO TRACK THE START OF THE BLESSINGS GUI GRIDS
_blessings_start_x = 0; 
_blessings_start_y = 0;
_blessings_box_w = 32;
_blessings_box_h = 32;	
_blessings_x_pos = 0;
_blessings_y_pos = 0;

//REFERENCE SELECTED PATRON/PATH, USED TO ACTIVATE THE CONFIRM BUTTON AND TO BE PASSED ONTO THE PASSER
_selected_blessing = undefined;

//THE VARIABLES HAVE BEEN PASSED
_variables_passed = false;