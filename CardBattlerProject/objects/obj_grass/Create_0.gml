///////////////
// VARIABLES //
///////////////
_touched = false;   // Tracks if the grass has been touched
_active = true;     // Tracks if the grass is active
_reset_delay = 0;   // Delay timer for resetting grass state
_reset_time = 600;  // Time before grass becomes active again (e.g., 2 seconds)
_deactivation_range = 1500; // Distance to deactivate grass instance

///////////////////////////////
// SPAWN LEAVES WHEN TOUCHED //
///////////////////////////////
function spawn_leaves() {
    var _leaf_count = irandom_range(3, 6); // Random number of leaves
    for (var _i = 0; _i < _leaf_count; _i++) {
        var _rand_x_offset = random_range(-5, 5); // Spread around the grass
        var _rand_y_offset = random_range(-5, 5);
        var _ref_leaf = instance_create_layer(x+16 + _rand_x_offset, y+12 + _rand_y_offset, "Terrain", obj_leaf);
        _ref_leaf.hsp = random_range(-0.5, 0.5); // Gentle horizontal drift
        _ref_leaf.vspd = random_range(0.3, 0.8);     // Slow downward speed
    }
}