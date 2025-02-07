//////////////////////////////////////////////////////////////////////
//					OBJ_MENU_CONTROLLER STEP						//
//																	//
// > MAIN MENU FUNCTIONALITY: GENERATE MAIN MENU BUTTONS, WATCH FOR	//
//   ESC INPUT, END GAME ON NO GUI ESC.								//
// > OTHER ROOM FUNCITONALITY: 'ESC' SUMMMONS THE OPTIONS MENU.		//
//////////////////////////////////////////////////////////////////////

///////////////
///////////////
// MAIN MENU //
///////////////
///////////////
#region Main Menu
if (room = rm_main_menu){
	
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
	if (_clicked == false){
		///////////////
		// NEW GAME //
		//////////////
		if (position_meeting(mouse_x,mouse_y,obj_button_new_game)){
			 ///OPEN GUI ON LEFT CLICK
			 if (mouse_check_button_pressed(mb_left)){
				 _clicked = true;
				global.flag_gui_open = true;
				global.gui_active = "New Game";				
				//DISPLAY THE GUI
				instance_create_layer(display_get_gui_width()/2,display_get_gui_height()/2,"GUI",obj_gui_new_game);
			}
		}
		
		if (position_meeting(mouse_x,mouse_y,obj_gui_load_game)){
			 ///OPEN GUI ON LEFT CLICK
			 if (mouse_check_button_pressed(mb_left)){
				 _clicked = true;				 
				global.flag_gui_open = true;
				global.gui_active = "Load";
				//DISPLAY THE GUI
				instance_create_layer(display_get_gui_width()/2,display_get_gui_height()/2,"GUI",obj_gui_load_game);
			
			 }
		}
		
		if (position_meeting(mouse_x,mouse_y,obj_gui_options)){
			 ///OPEN GUI ON LEFT CLICK
			 if (mouse_check_button_pressed(mb_left)){
				 _clicked = true;				 
				global.flag_gui_open = true;
				global.gui_active = "Options";				
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
		global.gui_active = undefined;
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
	// ESCAPE OPENs/CLOSES THE OPTIONS GUI //
	/////////////////////////////////////////
	if (keyboard_check_pressed(vk_escape)){
		 if (global.flag_gui_open == false){
			 //CREATE THE OPTIONS MENU		 
			instance_create_layer(display_get_gui_width()/2,display_get_gui_height()/2,"GUI",obj_gui_options);
			
			//UPDATE GLOBAL
			global.flag_gui_open = true;
			global.gui_active = "Options";
		 }
		 
		 else {
			 //DESTROY THE OPTIONS BUTTON IF OPEN
			if (instance_exists(obj_gui_options)){
				instance_destroy(obj_gui_options);
			}
			
			//UPDATE GLOBAL
			global.flag_gui_open = false;
			global.gui_active = undefined;
		 }
	}
	
	//////////////////
	// DEV MENU GUI //
	//////////////////
	//FUTURE
}
#endregion