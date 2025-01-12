function scr_start_transition(room) {
    instance_create_layer(0, 0, "GUI", obj_transition);
    with (obj_transition) {
        target_room = argument0;
        is_fading = true;
		obj_player._move_speed = 0;
    }
}