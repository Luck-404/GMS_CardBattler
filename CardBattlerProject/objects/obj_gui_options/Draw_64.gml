//////////////////////////////////////////////////////////////////////
//						OBJ_GUI_OPTIONS DRAW						//
//																	//
// > DRAW THE GUI												    //
//////////////////////////////////////////////////////////////////////
// Draw the background box
draw_self();

draw_set_font(fnt_fanwood_sm);

// Adjust mouse position based on the current window size
_mx = device_mouse_x_to_gui(0);
_my = device_mouse_y_to_gui(0);

// Draw Resolution Dropdown with hover effect
_hover_resolution = point_in_rectangle(_mx, _my, _menu_x + 200, _menu_y + _spacing, _menu_x + 270, _menu_y + _spacing + 20);
draw_text(_menu_x + 20, _menu_y + _spacing, "Resolution:");
draw_set_color(_hover_resolution ? c_yellow : c_white);  // Change color on hover
draw_text(_menu_x + 200, _menu_y + _spacing, string(_resolutions[_res_index][0]) + "x" + string(_resolutions[_res_index][1]));
draw_set_color(c_white);

// Draw Sound Slider
draw_text(_menu_x + 20, _menu_y + _spacing + 30, "Sound:");
draw_rectangle(_menu_x + 100, _menu_y + _spacing + 35, _menu_x + 200, _menu_y + _spacing + 45, false);
draw_set_color(c_blue);
draw_rectangle(_menu_x + 100 + _sound_volume * 100 - 5, _menu_y + _spacing + 30, _menu_x + 100 + _sound_volume * 100 + 5, _menu_y + _spacing + 50, false);
draw_set_color(c_white);
draw_text(_menu_x + 210, _menu_y + _spacing + 30, string(round(_sound_volume * 100)) + "%");

// Draw Music Slider
draw_text(_menu_x + 20, _menu_y + _spacing + 60, "Music:");
draw_rectangle(_menu_x + 100, _menu_y + _spacing + 65, _menu_x + 200, _menu_y + _spacing + 75, false);
draw_set_color(c_red);
draw_rectangle(_menu_x + 100 + _music_volume * 100 - 5, _menu_y + _spacing + 60, _menu_x + 100 + _music_volume * 100 + 5, _menu_y + _spacing + 80, false);
draw_set_color(c_white);
draw_text(_menu_x + 210, _menu_y + _spacing + 60, string(round(_music_volume * 100)) + "%");

// Draw Checkbox (Tutorial Toggle)
draw_text(_menu_x + 20, _menu_y + _spacing + 90, "Toggle Tutorials:");
draw_rectangle(_menu_x + 150, _menu_y + _spacing + 90, _menu_x + 170, _menu_y + _spacing + 110, false);
if (global.toggle_tutorials) {
    draw_set_color(c_black);
    draw_line(_menu_x + 155, _menu_y + _spacing + 95, _menu_x + 165, _menu_y + _spacing + 105);
    draw_line(_menu_x + 165, _menu_y + _spacing + 95, _menu_x + 155, _menu_y + _spacing + 105);
	draw_set_color(c_white);
}

// Draw Apply Button (only in rm_main_menu)
if (room == rm_main_menu) {
    _hover_apply = point_in_rectangle(_mx, _my, _menu_x + 50, _menu_y + _spacing + 120, _menu_x + 120, _menu_y + _spacing + 140);
    draw_set_color(_hover_apply ? c_green : c_white);
    draw_text(_menu_x + 50, _menu_y + _spacing + 120, "Apply");
}
draw_set_color(c_white);

// Draw Quit Button
_hover_quit = point_in_rectangle(_mx, _my, _menu_x + 200, _menu_y + _spacing + 120, _menu_x + 270, _menu_y + _spacing + 140);
draw_set_color(_hover_quit ? c_red : c_white);
draw_text(_menu_x + 200, _menu_y + _spacing + 120, "Quit");
draw_set_color(c_white);