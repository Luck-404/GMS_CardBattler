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

instance_create_layer(x+150,y-270,"GUI",obj_gui_new_game_close_button);//close

//LIST OF AVAILABLE PATRONS AND THEIR DETAILS (DSLIST - CALL SCRIPT TO POPULATE)
_list_patrons = ds_list_create();
scr_populate_patrons(_list_patrons);

//make an object for each patron
for (var _i = 0; _i < ds_list_size(_list_patrons); _i++){
	//_xloc = spread out along the x coordinate
	var _new_button = instance_create_layer(x+(40*_i),y-200,"GUI",obj_gui_new_game_patron_button);//close
	var _patron = ds_list_find_value(_list_patrons, _i);
	var _sigil = ds_map_find_value(_patron, "Sigil");
	var _name = ds_map_find_value(_patron, "Name");
	_new_button._selection_patron = _name;
	_new_button._tar_sprite = _sigil;
	_new_button._ref_to_patron = _patron;
}

//REFERENCE SELECTED PATRON/PATH, USED TO ACTIVATE BLESSINGS AND TO BE PASSED ONTO THE PASSER
_selected_patron = undefined;
_tar_patron = undefined;

//ARRAY OF BLESSINGS, A PATRON HAS AN ARRAY OF 3 ATTACHED BLESSINGS (A DSMAP OBJECT IN EACH CELL).
_array_blessings = [];

//REFERENCE SELECTED PATRON/PATH, USED TO ACTIVATE THE CONFIRM BUTTON AND TO BE PASSED ONTO THE PASSER
_selected_blessing = undefined;

//THE VARIABLES HAVE BEEN PASSED
_variables_passed = false;
_tar_blessing = undefined;