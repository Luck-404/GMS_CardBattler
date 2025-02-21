image_speed = 0;
depth = -101;
draw_self();
draw_set_color(c_white);
draw_set_font(fnt_fanwood_sm);
draw_text(x+25,y,"Tutorials");
draw_set_color(c_black);

if (global.flag_tutorials == true){
	draw_set_color(c_white);
	draw_line(x-10,y-10,x+10,y+10);
	draw_line(x-10,y+10,x+10,y-10);
	draw_set_color(c_black);
}

if (!instance_exists(obj_gui_options)){
	instance_destroy();	
}