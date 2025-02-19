//////////////////////////////////////////////////////////////////////
//						OBJ_GUI_OPTIONS STEP						//
//																	//
// > HANDLE CHANGES IN THE SLIDERS								    //
//////////////////////////////////////////////////////////////////////
// Adjust mouse position based on the current window size
_mx = window_mouse_get_x();
_my = window_mouse_get_y();


// Handle sound and music slider dragging
if (_dragging_sound) {
    global.sound_vol = clamp((_mx - (_menu_x + 100)) / 100, 0, 1);
}

if (_dragging_music) {
    global.music_vol = clamp((_mx - (_menu_x + 100)) / 100, 0, 1);
}