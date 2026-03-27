//////////////////////////////////////////////////////////////////////
//						OBJ_ENC_REWARDS CREATE						//
//																	//
// > END OF ENCOUNTER REWARDS GUI.								    //
//////////////////////////////////////////////////////////////////////
_type = undefined; //STATE (WIN, LOSS, FORFEIT
_flag_init = false; //SETUP COMPLETE FLAG
_clicked = false; //CLICKED FLAG

//CONFIRM BUTTON
_ref_confirm = instance_create_layer(x,y+300,"GUI",obj_confirm);
_ref_confirm.depth = -1000;
