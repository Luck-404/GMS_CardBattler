//////////////////////////////////////////////////////////////////////
//				OBJ_GUI_OPTIONS_RESOLUTION_BUTTON					//
//																	//
// > DRAW THE GUI												    //
//////////////////////////////////////////////////////////////////////
image_speed = 0;
depth = -101;
draw_self();
draw_set_color(c_white);
draw_set_font(fnt_fanwood_sm);
draw_text(x-35,y,string(global.res_x) + "x" + string(global.res_y));
draw_set_color(c_black);

if (!instance_exists(obj_gui_options)){
	instance_destroy();	
}