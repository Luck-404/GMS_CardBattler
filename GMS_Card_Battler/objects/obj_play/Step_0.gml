/////
//
/////

//MOVEMENT LOGIC
// Get Inputs
var _key_right = keyboard_check(ord("D"));
var _key_left  = keyboard_check(ord("A"));
var _key_up    = keyboard_check(ord("W"));
var _key_down  = keyboard_check(ord("S"));
var _key_shift = keyboard_check(vk_lshift);
var _key_interact = keyboard_check_pressed(ord("E")) || keyboard_check_pressed(vk_space);

// Calculate Movement Direction
var _input_x = _key_right - _key_left;
var _input_y = _key_down - _key_up;

// Check for water (using layer tilemap or object)
flag_swimming = layer_has_instance("ly_water", id); // Adjust based on your specific layer setup

// Determine Base Speed
var _current_spd = _move_spd;

if (flag_swimming) {
    _current_spd *= 0.5; // Move half speed in water
}

if (_key_shift && !flag_swimming) {
    _current_spd *= 2;   // Sprinting (disabled in water for balance)
}


if (_input_x != 0 || _input_y != 0) {
    // Get the angle of movement
    var _dir = point_direction(0, 0, _input_x, _input_y);
    
    // Calculate potential speed
    var _hspd = lengthdir_x(_current_spd, _dir);
    var _vspd = lengthdir_y(_current_spd, _dir);

    // X Collision (Checking ahead by speed + 3 as requested)
    if (place_meeting(x + _hspd + sign(_hspd) * 3, y, obj_wall)) {
        while (!place_meeting(x + sign(_hspd), y, obj_wall)) {
            x += sign(_hspd);
        }
        _hspd = 0;
    }
    x += _hspd;

    // Y Collision (Checking ahead by speed + 3)
    if (place_meeting(x, y + _vspd + sign(_vspd) * 3, obj_wall)) {
        while (!place_meeting(x, y + sign(_vspd), obj_wall)) {
            y += sign(_vspd);
        }
        _vspd = 0;
    }
    y += _vspd;
}

if (_key_interact) {
    // Logic for interacting with objects goes here
}