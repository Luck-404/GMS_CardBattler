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
	if (mouse_check_button_pressed(mb_left) && global._clicked == false){
		obj_passer._pass_savefile = _savename;
		
		//get the destination room
		ini_open(global.save_folder + _savename);
			global.start_x = ini_read_string("Player","x_pos","NONEFOUND");	
			global.start_y = ini_read_string("Player","y_pos","NONEFOUND");	
			var _roomin = ini_read_string("Player","Map","NONEFOUND");				
			var _room = scr_load_room(_roomin);			
			global.saved_room = _room;			
		ini_close();
		
		//close the gui
		global.flag_gui_open = false;						
		scr_transition("overworld","load",0,0);
		instance_destroy(obj_gui_load_game);
	}
} else {
	image_index = 0;	
}