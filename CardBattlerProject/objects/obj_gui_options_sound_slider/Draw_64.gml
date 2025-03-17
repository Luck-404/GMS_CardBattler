//////////////////////////////////////////////////////////////////////
//					OBJ_GUI_OPTIONS_SOUND_SLIDER					//
//																	//
// > DRAW THE GUI												    //
//////////////////////////////////////////////////////////////////////
image_speed = 0;
depth = -101;

// Set color and font
draw_set_color(c_white);
draw_set_font(fnt_fanwood_sm);

// Draw label
draw_text(x - 50, y, "Sound");

// Draw background bar
draw_rectangle(x, y - 3, x + 100, y + 3, false);

// Draw slider knob at the correct position
draw_sprite(spr_slider_bar, image_index, x + (global.sound_vol * 100) - 10, y);

// Draw volume percentage
draw_text(x + 125, y, string(round(global.sound_vol * 100)) + "%");