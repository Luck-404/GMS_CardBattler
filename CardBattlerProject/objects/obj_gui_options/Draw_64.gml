//////////////////////////////////////////////////////////////////////
//						OBJ_GUI_OPTIONS DRAW						//
//																	//
// > DRAW THE GUI												    //
//////////////////////////////////////////////////////////////////////
// Draw the background box
draw_self();

//FONT
draw_set_font(fnt_fanwood_sm);

////////////////////
// MOUSE POSITION //
////////////////////
_mx = device_mouse_x_to_gui(0);
_my = device_mouse_y_to_gui(0);

//////////////////
// CLOSE BUTTON //
//////////////////
#region Close Button
if (position_meeting(_mx,_my,obj_gui_options_close_button)){
	obj_gui_options_close_button.image_index = 1;
	if (mouse_check_button_pressed(mb_left)){
		obj_gui_options_close_button.image_index = 2;
		global.flag_gui_open = false;
		obj_menu_controller._clicked = false;
		instance_destroy();
	}
} else {
	obj_gui_options_close_button.image_index = 0;
}
#endregion



////////////////
// RESOLUTION //
////////////////
#region Resolution
if (position_meeting(_mx,_my,obj_gui_options_resolution_button)){
	obj_gui_options_resolution_button.image_index = 1;
	if (mouse_check_button_pressed(mb_left)){
		obj_gui_options_resolution_button.image_index = 2;
		global.res_index = (global.res_index + 1) mod array_length(_resolutions);
		global.res_x = _resolutions[global.res_index][0];
		global.res_y = _resolutions[global.res_index][1];
	}
} else {
	obj_gui_options_resolution_button.image_index = 0;
}
#endregion



////////////////////////
// TUTORIALS CHECKBOX //
////////////////////////
#region Tutorials
	if (position_meeting(_mx,_my, obj_gui_options_tutorials_checkbox)){
		obj_gui_options_tutorials_checkbox.image_index = 1;
		if (mouse_check_button_pressed(mb_left)){
			obj_gui_options_tutorials_checkbox.image_index = 2;
			global.flag_tutorials = !(global.flag_tutorials);
		}
	} else {
		obj_gui_options_tutorials_checkbox.image_index = 0;
	}
#endregion



/////////////////////////
// FULLSCREEN CHECKBOX //
/////////////////////////
#region Fullscreen
	if (position_meeting(_mx,_my, obj_gui_options_fullscreen_checkbox)){
		obj_gui_options_fullscreen_checkbox.image_index = 1;
		if (mouse_check_button_pressed(mb_left)){
			obj_gui_options_fullscreen_checkbox.image_index = 2;
			global.flag_fullscreen = !(global.flag_fullscreen);
		}
	} else {
		obj_gui_options_fullscreen_checkbox.image_index = 0;
	}
#endregion



///////////////////////////
// APPLY UPDATED OPTIONS //
///////////////////////////
#region Apply
// Apply Button
	if (position_meeting(_mx,_my,obj_gui_options_apply_button)){
		obj_gui_options_apply_button.image_index = 1;
			if (mouse_check_button_pressed(mb_left)){
				obj_gui_options_apply_button.image_index = 2;

		    ini_open(global.settings_file);
		    ini_write_real("Settings", "res_x", global.res_x);
		    ini_write_real("Settings", "res_y", global.res_y);				
		    ini_write_real("Settings", "res_index", global.res_index);				
		    ini_write_real("Settings", "music_volume", global.music_vol);				
		    ini_write_real("Settings", "sound_volume", global.sound_vol);				
		    ini_write_string("Settings", "tutorials", scr_bool_to_string(global.flag_tutorials));				
			ini_write_string("Settings", "fullscreen", scr_bool_to_string(global.flag_fullscreen));					
		    ini_close();
			
			// Set the updated window size
			window_set_size(global.res_x, global.res_y);

			//DELETE OLD MUSIC
			if (instance_exists(obj_music_timer)){
				audio_stop_all();
				instance_destroy(obj_music_timer);
			}
			
			//SET NEW SOUND
			audio_master_gain(global.sound_vol);
			
			//fullscreen
			window_set_fullscreen(global.flag_fullscreen);
		}
	} else {
		obj_gui_options_apply_button.image_index = 0;	
	}
#endregion



//////////////////////////////////////
// RESET SETTINGS TO DEFAULT BUTTON //
//////////////////////////////////////
#region DEFAULTS
	if (position_meeting(_mx,_my,obj_gui_options_default_button)){
		obj_gui_options_default_button.image_index = 1;
		if (mouse_check_button_pressed(mb_left)){
			obj_gui_options_default_button.image_index = 2;

			file_delete(global.settings_file);
			
			//overwrite old file
			var _result = file_copy(global.default_settings_file, global.settings_file);

			global.res_x = 1920;
			global.res_y = 1080;
			global.res_index = 3;
			global.sound_vol = 1.0;
			global.music_vol = 1.0;
			global.flag_tutorials = true; 
			global.flag_fullscreen = false; 

			// Set the updated window size
			window_set_size(global.res_x, global.res_y);

			//DELETE OLD MUSIC
			if (instance_exists(obj_music_timer)){
				audio_stop_all();
				instance_destroy(obj_music_timer);
			}
			
			//SET NEW SOUND
			audio_master_gain(global.sound_vol);
			
			//fullscreen
			window_set_fullscreen(global.flag_fullscreen);
			} 
		} else {
		obj_gui_options_default_button.image_index = 0;
	}
#endregion



////////////////////////////
// EXIT TO MM (OVERWORLD) //
////////////////////////////
#region EXIT
	if (room != rm_main_menu && room != rm_encounter){
		if (position_meeting(_mx,_my,obj_gui_options_savexit_button)){
			obj_gui_options_savexit_button.image_index = 1;
			if (mouse_check_button_pressed(mb_left)){		
				obj_gui_options_savexit_button.image_index = 2;
			    //start transition to main menu
				scr_transition("main menu","Any","Any","Any");
				//delete self
				instance_destroy();
			}
		} else {
			obj_gui_options_savexit_button.image_index = 0;
		}
	}
#endregion



/////////////////////////
// FORFEIT (ENCOUNTER) //
/////////////////////////
#region FORFEIT
	if (room == rm_encounter){
		if (position_meeting(_mx,_my,obj_gui_options_forfeit_button)){
			obj_gui_options_forfeit_button.image_index = 1;
			if (mouse_check_button_pressed(mb_left)){		
				obj_gui_options_forfeit_button.image_index = 2;
				//take 25% hp from all units
				for (var _creatureindex = 0; _creatureindex < ds_list_size(global.player_team); _creatureindex++){
					var _ref_unit = ds_list_find_value(global.player_team,_creatureindex);
					_ref_unit[?"curhp"] = ceil((_ref_unit[?"curhp"])*0.75);
				}
				//start transition to overworld
				scr_transition("overworld","return","Any","Any");
				//delete self
				instance_destroy();
			}
		} else {
			obj_gui_options_forfeit_button.image_index = 0;
		}
	}
#endregion