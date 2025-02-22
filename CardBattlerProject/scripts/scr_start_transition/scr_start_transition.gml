//////////////////////////////////////////////////////////////////////
//						SCR_START_TRANSITION						//
//																	//
// > START THE TRANSITION BY CREATING THE OBJECT					//
//////////////////////////////////////////////////////////////////////
function scr_start_transition(_rm) {
    instance_create_layer(0, 0, "GUI", obj_transition);
    with (obj_transition) {		
        _target_room = _rm;
        _is_fading = true;			
    }
}