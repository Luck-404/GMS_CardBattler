function get_direction_from_player(_player_x, _player_y, _trigger_x, _trigger_y) {
    var _dx = _player_x - _trigger_x; // Horizontal difference
    var _dy = _player_y - _trigger_y; // Vertical difference

    // Determine which axis has the greater magnitude
    if (abs(_dx) > abs(_dy)) {
        // Horizontal movement
        if (_dx > 0) {
            return "Right"; // Player entered from the left
        } else {
            return "Left"; // Player entered from the right
        }
    } else {
        // Vertical movement
        if (_dy > 0) {
            return "Down"; // Player entered from above
        } else {
            return "Up"; // Player entered from below
        }
    }
}