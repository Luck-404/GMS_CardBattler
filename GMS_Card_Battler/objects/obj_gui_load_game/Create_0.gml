//////////////////////////////////////////////////////////////////////
//					OBJ_GUI_LOAD_GAME CREATE						//
//																	//
// > LOAD THE GUI, PREPARE SAVEFILES TO LOAD.						//
//////////////////////////////////////////////////////////////////////
depth = -100;
image_index	= 0;
image_speed = 0;
_mx = device_mouse_x_to_gui(0);
_my = device_mouse_y_to_gui(0);

//CREATE CLOSE BUTTON
instance_create_layer(x+150,y-270,"GUI",obj_gui_load_close_button);

//CREATE SAVEFILE BUTTONS
scr_trim_saves(); //TRIMS SAVES DOWN TO 10 ONLY (TMP)
scr_get_saves(); //LOAD THE LATEST 10 SAVES

//DESTROY THE CURRENT PASSER IF THERE IS ONE
if (instance_exists(obj_passer)){
	with(obj_passer){
		instance_destroy(obj_passer);	
	}
}

//CREATE A NEW PASSER
_ref_passer = instance_create_layer(0,0,"GUI",obj_passer);
