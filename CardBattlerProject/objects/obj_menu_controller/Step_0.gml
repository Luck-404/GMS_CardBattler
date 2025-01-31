///////////////
// MAIN MENU //
///////////////
if (room = rm_main_menu){
//spawn the main menu objects if needed
	if (instance_exists(obj_button_new_game) == false){
		instance_create_layer(810,310,"GUI",obj_button_new_game);
	}
	if (instance_exists(obj_button_load) == false){
		instance_create_layer(810,401,"GUI",obj_button_load);	
	}
	if (instance_exists(obj_button_options) == false){
		instance_create_layer(810,484,"GUI",obj_button_options);	
	}
	if (instance_exists(obj_button_exit) == false){
		instance_create_layer(801,568,"GUI",obj_button_exit);	
	}			
	
//check for 'esc' input (closes current pane if one is open)
	if (keyboard_check_pressed(vk_escape) && (global.gui_open = true)){

		if (instance_exists(obj_gui_options)){
			instance_destroy(obj_gui_options);
		}
		global.gui_open = false;
	}
//otherwise end the game if in main menu and pressing esc	
	else if (keyboard_check_pressed(vk_escape)){
		game_end();
	}
}

/////////////////
// OTHER ROOMS //
/////////////////
if (room != rm_main_menu){
//in all other rooms, acts as a way to go to the options- save, load, main menu, exit game

}