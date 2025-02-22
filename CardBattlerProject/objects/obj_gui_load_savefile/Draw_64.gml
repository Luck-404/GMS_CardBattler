var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);

draw_self();
draw_set_color(c_white);
draw_set_font(fnt_fanwood_sm);
draw_text(x-80,y,string(_savename));
draw_set_color(c_black);

if (!instance_exists(obj_gui_load_game)){
	instance_destroy();	
}

if (position_meeting(_mx,_my,self)){
	image_index = 1;
	if (mouse_check_button_pressed(mb_left)){
		obj_passer._pass_savefile = _savename;
		
		//get the destination room
		ini_open(_savename);
		global.saved_room = ini_read_string("Player","Map",string(rm_overworld_green));
		ini_close();
		
		//close the gui
		global.flag_gui_open = false;						
		scr_transition("overworld","load",0,0);
		instance_destroy();
	}
} else {
	image_index = 0;	
}