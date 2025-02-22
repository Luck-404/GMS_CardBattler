image_speed = 0;
depth = -101;
draw_self();
draw_set_color(c_white);
draw_set_font(fnt_fanwood_sm);
draw_text(x-35,y,"Close");
draw_set_color(c_black);

if (!instance_exists(obj_gui_new_game)){
	instance_destroy();	
}