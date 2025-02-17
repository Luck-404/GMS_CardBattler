//////////////////////////////////////////////////////////////////////
//						OBJ_GUI_OPTIONS STEP						//
//																	//
// > HANDLE CHANGES IN THE SLIDERS								    //
//////////////////////////////////////////////////////////////////////
// Adjust mouse position based on the current window size
_mx = device_mouse_x_to_gui(0);
_my = device_mouse_y_to_gui(0);

// Handle sound and music slider dragging
if (_dragging_sound) {
    _sound_volume = clamp((_mx - (_menu_x + 100)) / 100, 0, 1);
}

if (_dragging_music) {
    _music_volume = clamp((_mx - (_menu_x + 100)) / 100, 0, 1);
}