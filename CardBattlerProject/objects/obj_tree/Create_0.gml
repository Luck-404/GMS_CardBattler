///////////////
// VARIABLES //
///////////////
_touched = false;   // Tracks if the grass has been touched
_active = true;     // Tracks if the grass is active
_reset_delay = 0;   // Delay timer for resetting grass state
_reset_time = 600;  // Time before grass becomes active again (e.g., 2 seconds)
_deactivation_range = 1500; // Distance to deactivate grass instance

/////////////////
// SPAWN CONES //
/////////////////
function spawn_cones() {
    var _cone_count = irandom_range(1,2); // Random number of leaves
    for (var _i = 0; _i < _cone_count; _i++) {
        var _rand_x_offset = random_range(-5, 5); // Spread around the grass
        var _rand_y_offset = random_range(-5, 5);
        var _cone = instance_create_layer(x+16 + _rand_x_offset, y+12 + _rand_y_offset, "GUI", obj_cone);
        _cone.vspd = random_range(1.2, 2);     // Slow downward speed
    }
}