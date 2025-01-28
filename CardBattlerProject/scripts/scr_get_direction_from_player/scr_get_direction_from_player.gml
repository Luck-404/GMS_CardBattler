function get_direction_from_player(_player_x, _player_y, _trigger_x, _trigger_y) {
    var _dx = _player_x - _trigger_x; // Horizontal difference
    var _dy = _player_y - _trigger_y; // Vertical difference

    // Check diagonal directions first
    if (_dx < 0 && _dy < 0) return "Left"; //TL
    if (_dx > 0 && _dy < 0) return "Right"; //TR
    if (_dx < 0 && _dy > 0) return "Left"; //BL
    if (_dx > 0 && _dy > 0) return "Right"; //BR

    // Check cardinal directions
    if (_dx == 0 && _dy < 0) return "Up";
    if (_dx == 0 && _dy > 0) return "Down";
    if (_dy == 0 && _dx < 0) return "Left";
    if (_dy == 0 && _dx > 0) return "Right";

    return "None"; // No direction (player is exactly at the trigger)
}