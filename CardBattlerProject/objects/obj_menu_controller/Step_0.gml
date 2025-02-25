//////////////////////////////////////////////////////////////////////
//					OBJ_MENU_CONTROLLER STEP						//
//																	//
// > MAIN MENU FUNCTIONALITY: GENERATE MAIN MENU BUTTONS, WATCH FOR	//
//   ESC INPUT, END GAME ON NO GUI ESC.								//
// > OTHER ROOM FUNCITONALITY: 'ESC' SUMMMONS THE OPTIONS MENU.		//
//////////////////////////////////////////////////////////////////////
if (mouse_check_button_released(mb_left)){
	global._clicked = false;
}

///////////////
///////////////
// MAIN MENU //
///////////////
///////////////
#region Main Menu
if (room = rm_main_menu){
	
	audio_stop_sound(snd_bgm_meadows);
	
	////////////////////////////////////
	// SPAWN MAIN MENU BUTTON OBJECTS //
	////////////////////////////////////
		//NEW GAME BUTTON
	if (instance_exists(obj_button_new_game) == false){
		instance_create_layer(810,310,"GUI",obj_button_new_game);
	}
		//LOAD BUTTON
	if (instance_exists(obj_button_load) == false){
		instance_create_layer(810,401,"GUI",obj_button_load);	
	}
		//OPTIONS BUTTON
	if (instance_exists(obj_button_options) == false){
		instance_create_layer(810,484,"GUI",obj_button_options);	
	}
		//EXIT BUTTON
	if (instance_exists(obj_button_exit) == false){
		instance_create_layer(801,568,"GUI",obj_button_exit);	
	}			
	
	//////////////////////////////////////////////////////////
	// CHECK FOR GUI BUTTONS (ALL BESIDES EXIT) - SPAWN GUI //
	//////////////////////////////////////////////////////////
	if (global._clicked == false && global.flag_gui_open == false){
		///////////////
		// NEW GAME //
		//////////////
		if (position_meeting(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),obj_button_new_game)){
			
			 ///OPEN GUI ON LEFT CLICK
			 if (mouse_check_button_pressed(mb_left)){
				 global._clicked = true;
				global.flag_gui_open = true;			
				//DISPLAY THE GUI
				instance_create_layer(display_get_gui_width()/2,display_get_gui_height()/2,"GUI",obj_gui_new_game);
			}
		}
		
		if (position_meeting(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),obj_button_load)){
			
			 ///OPEN GUI ON LEFT CLICK
			 if (mouse_check_button_pressed(mb_left)){
				 global._clicked = true;				 
				global.flag_gui_open = true;
				//DISPLAY THE GUI
				instance_create_layer(display_get_gui_width()/2,display_get_gui_height()/2,"GUI",obj_gui_load_game);
			
			 }
		}
		
		if (position_meeting(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),obj_button_options)){
			 ///OPEN GUI ON LEFT CLICK
			 if (mouse_check_button_pressed(mb_left)){
				 global._clicked = true;				 
				global.flag_gui_open = true;		
				//DISPLAY THE GUI
				instance_create_layer(display_get_gui_width()/2,display_get_gui_height()/2,"GUI",obj_gui_options);
			 }
		}		
	}
	
	////////////////////////////////////////////
	// ESCAPE WILL CLOSE A GUI IF ONE IS OPEN //
	////////////////////////////////////////////
	if (keyboard_check_pressed(vk_escape) && (global.flag_gui_open == true)){
		
		//DESTROY THE OPTIONS PANE IF OPEN
		if (instance_exists(obj_gui_options)){
			with(obj_gui_options){
				instance_destroy(obj_gui_options);
			}
		}
		
		//DESTROY THE NEW GAME PANE IF OPEN
		if (instance_exists(obj_gui_new_game)){
			with(obj_gui_new_game){
				instance_destroy(obj_gui_new_game);
			}
		}
		
		//DESTROY THE LOAD GAME PANE IF OPEN
		if (instance_exists(obj_gui_load_game)){
			with(obj_gui_load_game){
				instance_destroy(obj_gui_load_game);
			}
		}
		
		//UPDATE GLOBAL
		global.flag_gui_open = false;
	}
	
	//////////////////////////////////////////////////
	// ESCAPE WILL CLOSE THE GAME IF NO GUI IS OPEN //
	//////////////////////////////////////////////////
	else if (keyboard_check_pressed(vk_escape) && global.flag_gui_open == false){
		game_end();
	}
}
#endregion

/////////////////
/////////////////
// OTHER ROOMS //
/////////////////
/////////////////
#region Other Rooms
if (room != rm_main_menu){
	/////////////////////////////////////////
	// ESCAPE OPENS/CLOSES THE OPTIONS GUI //
	/////////////////////////////////////////
	if (keyboard_check_pressed(vk_escape)){
		 if (global.flag_gui_open == false){
			 obj_player._move_speed = 0;
			 //CREATE THE OPTIONS MENU		 
			instance_create_layer(display_get_gui_width()/2,display_get_gui_height()/2,"GUI",obj_gui_options);
			
			//UPDATE GLOBAL
			global.flag_gui_open = true;
		 }
		 
		 else {
			 //DESTROY THE OPTIONS BUTTON IF OPEN
			if (instance_exists(obj_gui_options)){
				instance_destroy(obj_gui_options);
			}
			obj_player._move_speed = 3;
			
			//UPDATE GLOBAL
			global.flag_gui_open = false;
		 }
	}
	
	//////////////////
	// DEV MENU GUI //
	//////////////////
	//TODO
}
#endregion

///////////////////////////////
// KB "F" TOGGLES FULLSCREEN //
///////////////////////////////
if (keyboard_check_pressed(ord("F"))){	
	global.flag_fullscreen = !global.flag_fullscreen;
	window_set_fullscreen(global.flag_fullscreen);
}

//////////////////
// F1 ENDS GAME //
//////////////////
if (keyboard_check_pressed(vk_f1)){
	show_debug_message("PLAYER: ENDING GAME VIA 'F1'");		
	game_end();	
}

////////////////
// F4 to SAVE //
////////////////
if (room != rm_encounter && room != rm_main_menu && (keyboard_check(vk_f4) == true)){
	scr_save();
}