//////////////////////////////////////////////////////////////////////
//					OBJ_GUI_LOAD_SAVEFILE CREATE					//
//																	//
// > ESTABLISH VARIABLES.											//
//////////////////////////////////////////////////////////////////////
depth = -101;
image_speed = 0;

_savename = undefined; //file reference
_ref_deleter = instance_create_layer(x+115,y,"GUI",obj_gui_load_delete_button); //delete button (will remove the file and object on delete)
_init = false; //connect the _ref_deleter to this object

//TODO
//_ref_renamer = instance_create_layer(x+115,y,"GUI",obj_gui_load_savefile_renamer); //allow renaming