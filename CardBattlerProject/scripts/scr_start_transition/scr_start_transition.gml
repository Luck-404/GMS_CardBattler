function scr_start_transition(_rm) {
    instance_create_layer(0, 0, "GUI", obj_transition);
    with (obj_transition) {
		show_debug_message("{{{ SCR_TRANSITION: SETTING UP TRANSITION, ADDING BLANKSPACE HERE }}}\n\n\n\n\n");		
        _target_room = _rm;
        _is_fading = true;			
    }
}