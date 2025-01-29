function scr_check_one_way_hop(_tile_index, _move_x, _move_y, _prev_x, _prev_y) {
// tile_index: The index of the one-way tile
// move_x, move_y: The target tile coordinates
// prev_x, prev_y: The coordinates of the previous tile (where the player came from)

// Check movement direction
var _dx = _move_x - _prev_x;
var _dy = _move_y - _prev_y;

// Compare movement with allowed directions
switch (_tile_index) {
    case 1: return (_dy > 0); // Must enter from top (moving downward)
    case 2: return (_dx > 0); // Must enter from left (moving right)
    case 3: return (_dy < 0); // Must enter from bottom (moving upward)
    case 4: return (_dx < 0); // Must enter from right (moving left)
    case 5: return (_dx < 0 && _dy < 0); // Bottom-right to Top-left
    case 6: return (_dx > 0 && _dy < 0); // Bottom-left to Top-right
    case 7: return (_dx > 0 && _dy > 0); // Top-left to Bottom-right
    case 8: return (_dx < 0 && _dy > 0); // Top-right to Bottom-left
    default: return false; // Invalid index, deny movement
}
}