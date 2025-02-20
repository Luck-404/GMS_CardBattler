//////////////////////////////////////////////////////////////////////
//						OBJ_GUI_OPTIONS DRAW						//
//																	//
// > DRAW THE GUI												    //
//////////////////////////////////////////////////////////////////////
// Draw the background box
draw_self();

draw_set_font(fnt_fanwood_sm);

// Adjust mouse position based on the current window size
_mx = mouse_x;
_my = mouse_y;


//handle 'close' button
//////////////////
// CLOSE BUTTON //
//////////////////
if (position_meeting(x,y,obj_gui_option_close_button)){
	if (mouse_check_button_pressed(mb_left){
		image_index = 2;
		global.flag_gui_open = false;
		obj_menu_controller._clicked = false;
		instance_destroy();
	}
}

//update ui ever tick
// UI Positions
_menu_x = window_get_width() / 2 - (240*global.ui_scalar);
_menu_y = window_get_height() / 2 - (150*global.ui_scalar);
_menu_width = 300*global.ui_scalar;
_menu_height = 250*global.ui_scalar;
_spacing = 40*global.ui_scalar; // Spacing between elements

// Draw Resolution Dropdown with hover effect
_hover_resolution = point_in_rectangle(_mx, _my, _menu_x + 200, _menu_y + _spacing, _menu_x + 270, _menu_y + _spacing + 20);
draw_text(_menu_x + 20, _menu_y + _spacing, "Resolution:");
draw_set_color(_hover_resolution ? c_yellow : c_white);  // Change color on hover
draw_text(_menu_x + 200, _menu_y + _spacing, string(global.res_x) + "x" + string(global.res_y));
draw_set_color(c_white);

// Draw Sound Slider
draw_text(_menu_x + 20, _menu_y + _spacing + 30, "Sound:");
draw_rectangle(_menu_x + 100, _menu_y + _spacing + 35, _menu_x + 200, _menu_y + _spacing + 45, false);
draw_set_color(c_blue);
draw_rectangle(_menu_x + 100 + global.sound_vol * 100 - 5, _menu_y + _spacing + 30, _menu_x + 100 + global.sound_vol * 100 + 5, _menu_y + _spacing + 50, false);
draw_set_color(c_white);
draw_text(_menu_x + 210, _menu_y + _spacing + 30, string(round(global.sound_vol * 100)) + "%");

// Draw Music Slider
draw_text(_menu_x + 20, _menu_y + _spacing + 60, "Music:");
draw_rectangle(_menu_x + 100, _menu_y + _spacing + 65, _menu_x + 200, _menu_y + _spacing + 75, false);
draw_set_color(c_red);
draw_rectangle(_menu_x + 100 + global.music_vol * 100 - 5, _menu_y + _spacing + 60, _menu_x + 100 + global.music_vol * 100 + 5, _menu_y + _spacing + 80, false);
draw_set_color(c_white);
draw_text(_menu_x + 210, _menu_y + _spacing + 60, string(round(global.music_vol * 100)) + "%");

// Draw Checkbox (Tutorial Toggle)
_hover_checkbox = point_in_rectangle(_mx, _my, _menu_x + 150, _menu_y + _spacing + 90, _menu_x + 170, _menu_y + _spacing + 110);
draw_text(_menu_x + 20, _menu_y + _spacing + 90, "Toggle Tutorials:");
draw_set_color(_hover_checkbox ? c_orange : c_white);
draw_rectangle(_menu_x + 150, _menu_y + _spacing + 90, _menu_x + 170, _menu_y + _spacing + 110, false);
if (global.flag_tutorials) {
    draw_set_color(c_black);
    draw_line(_menu_x + 155, _menu_y + _spacing + 95, _menu_x + 165, _menu_y + _spacing + 105);
    draw_line(_menu_x + 165, _menu_y + _spacing + 95, _menu_x + 155, _menu_y + _spacing + 105);
	draw_set_color(c_white);
}
draw_set_color(c_white);

// Draw Apply Button
_hover_apply = point_in_rectangle(_mx, _my, _menu_x + 50, _menu_y + _spacing + 120, _menu_x + 120, _menu_y + _spacing + 140);
draw_set_color(_hover_apply ? c_green : c_white);
draw_text(_menu_x + 50, _menu_y + _spacing + 120, "Apply");
draw_set_color(c_white);

// Draw Reset to Defaults Button
_hover_reset = point_in_rectangle(_mx, _my, _menu_x + 50, _menu_y + _spacing + 220, _menu_x + 120, _menu_y + _spacing + 240);
draw_set_color(_hover_reset ? c_red : c_white);
draw_text(_menu_x + 50, _menu_y + _spacing + 220, "Reset to Default");
draw_set_color(c_white);

// Draw Save/Exit to MM Button
if (room != rm_main_menu && room != rm_encounter){
	_hover_quit = point_in_rectangle(_mx, _my, _menu_x + 50, _menu_y + _spacing + 140, _menu_x + 120, _menu_y + _spacing + 160);
	draw_set_color(_hover_quit ? c_red : c_white);
	draw_text(_menu_x + 50, _menu_y + _spacing + 120, "Save & Exit");
	draw_set_color(c_white);
}

if (room == rm_encounter){
	_hover_forfeit = point_in_rectangle(_mx, _my, _menu_x + 50, _menu_y + _spacing + 140, _menu_x + 120, _menu_y + _spacing + 160);
	draw_set_color(_hover_quit ? c_red : c_white);
	draw_text(_menu_x + 50, _menu_y + _spacing + 120, "Forfeit");
	draw_set_color(c_white);
}