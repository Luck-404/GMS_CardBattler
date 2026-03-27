//////////////////////////////////////////////////////////////////////
//					OBJ_GUI_LOAD_SAVEFILE DRAW GUI					//
//																	//
// > DRAW REF FILENAME, HANDLE CLICKS ON THIS						//
//////////////////////////////////////////////////////////////////////
var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);



//DRAW SELF AND FILENAME
draw_self();
draw_set_color(c_white);
draw_set_font(fnt_fanwood_sm);
draw_text(x-80,y,string(_savename));
draw_set_color(c_black);



//INITIALIZE/CONNECT THE DELETE BUTTON
if (_init == false){
	_ref_deleter._ref_file = _savename;
	_ref_deleter._ref_save_button = self;
	_init = true;
}



//HANDLE CLICKS
if (position_meeting(_mx,_my,self)){
	image_index = 1;
	if (mouse_check_button_pressed(mb_left) && global._clicked == false){
		//PASS THE SAVEFILE TO PASSER
		obj_passer._pass_savefile = _savename;
		
		//GET TRANSITION INFO
		ini_open(global.save_folder + _savename);
			global.start_x = ini_read_string("Player","x_pos","NONEFOUND");	
			global.start_y = ini_read_string("Player","y_pos","NONEFOUND");	
			var _roomin = ini_read_string("Player","Map","NONEFOUND");				
			var _room = scr_load_room(_roomin);			
			global.saved_room = _room;			
		ini_close();
		
		//CLOSE THE GUI
		global.flag_gui_open = false;						
		show_debug_message("			TRANSITION TO OVERWORLD FROM LOAD GAME");				
		scr_transition("overworld","load",0,0);
		instance_destroy(obj_gui_load_game);
	}
} else {
	image_index = 0;	
}



//DESTROY IF THE GUI IS CLOSED
if (!instance_exists(obj_gui_load_game)){
	instance_destroy();	
}