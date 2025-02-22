// Check if the mouse is over the slider bar
if (device_mouse_x_to_gui(0) >= x-5 && device_mouse_x_to_gui(0) <= x + 105 && device_mouse_y_to_gui(0) >= y - 5 && device_mouse_y_to_gui(0) <= y + 5) {
	image_index = 1;
    if ((mouse_check_button_pressed(mb_left) && global._clicked == false)) {
        _dragging = true; // Start dragging when clicked
		image_index = 2;	
    }
} else {
	image_index = 0;	
}

// If dragging, update volume
if (_dragging) {
    // Get the mouse position clamped within the bar
    var _new_x = clamp(device_mouse_x_to_gui(0), x, x + 100);
    
    // Convert position to 0-1 scale
    global.music_vol = (_new_x - x) / 100;
    
    // Stop dragging when the mouse is released
    if (mouse_check_button_released(mb_left)) {
        _dragging = false;
    }
}

if (!instance_exists(obj_gui_options)){
	instance_destroy();	
}