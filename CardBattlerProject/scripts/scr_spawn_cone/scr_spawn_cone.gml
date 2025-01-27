function scr_spawn_cone() {
    //var _cone_count = irandom_range(1,2); // Random number of cones
	var _cone_count = 1;
    for (var _i = 0; _i < _cone_count; _i++) {
        var _rand_x_offset = random_range(-5, 5); // Spread around the grass
        var _rand_y_offset = random_range(-5, 5);
        var _cone = instance_create_layer(x+16 + _rand_x_offset, y+12 + _rand_y_offset, "GUI", obj_cone);
        _cone.vspd = random_range(1.2, 2);     // Slow downward speed
    }
}