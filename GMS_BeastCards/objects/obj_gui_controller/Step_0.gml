//
//
// STEP: OBJ_UI_CONTROLLER | CONTROL UI COMMANDS
//
//

//FULLSCREEN TOGGLE
if (keyboard_check_pressed(ord("F"))){
	window_set_fullscreen(!window_get_fullscreen());	
}


//ESC EXIT
if (keyboard_check_pressed(vk_escape) && global.active_gui == undefined){
	show_debug_message("\n\n\n\n\n\nPLAYER PRESSED ESCAPE TO END GAME")
	game_end();	
} 

//OTHERWISE ESC CLOSES CURRENT GUI
else {	
	if (keyboard_check_pressed(vk_escape)){
		//DESTROY CURRENT GUI
		scr_destroy_gui_open();
		//TOGGLE PAUSE
		global.pause = false;		
		scr_toggle_gui_pause();		

	}
}

if (room != rm_battle){
	#region PAUSE HANDLING
	if (keyboard_check_pressed(ord("T")) && global.active_gui == undefined){
		show_debug_message("\n\n\n\n\n\nPLAYER PRESSED T TOGGLE PAUSE GAME")
		//TOGGLE PAUSE
		scr_toggle_gui_pause();
	}
	#endregion

	#region ACTIVATE PARTY PANE
	if (keyboard_check_pressed(ord("P"))){
		show_debug_message("\n\n\n\n\n\nPLAYER PRESSED P TOGGLE PARTY PANE")
		//IF PARTY PANE IS ALREADY ACTIVE
		if (global.active_gui != undefined && global.active_gui._type == "PARTY"){
			//DESTROY CURRENT GUI
			scr_destroy_gui_open();
			//TOGGLE PAUSE
			global.pause = false;
			scr_toggle_gui_pause();				
		}
		else {
			//ELSE OPEN PARTY PANE INSTEAD
			//DESTROY CURRENT GUI
			scr_destroy_gui_open();
			//TOGGLE PAUSE
			global.pause = true;
			scr_toggle_gui_pause();	
			//OPEN NEW PARTY GUI
			global.active_gui = instance_create_layer(room_width/2,room_height/2,"ily_fx",obj_gui_party_pane);
		}
	}
	#endregion

	#region PARTY PANE ARROW KEYS
	if (global.active_gui != undefined && global.active_gui.sprite_index == spr_gui_party_pane){
		if (keyboard_check_pressed(vk_left)){
			if (ds_list_find_value(global.player_party,global.active_gui._pos-1) != undefined){
				global.active_gui._pos--;	
				global.active_gui._unit_selected = ds_list_find_value(global.player_party,global.active_gui._pos);
			}
		}
	
		if (keyboard_check_pressed(vk_right)){
			if (ds_list_find_value(global.player_party,global.active_gui._pos+1) != undefined){
				global.active_gui._pos++;	
				global.active_gui._unit_selected = ds_list_find_value(global.player_party,global.active_gui._pos);
			}
		}
	}
	#endregion

	#region ACTIVATE DECK PANE
	if (keyboard_check_pressed(ord("K"))){
		show_debug_message("\n\n\n\n\n\nPLAYER PRESSED K TOGGLE DECK PANE")
		//IF DECK PANE IS ALREADY ACTIVE
		if (global.active_gui != undefined && global.active_gui._type == "DECK"){
			//DESTROY CURRENT GUI
			scr_destroy_gui_open();	
			//TOGGLE PAUSE
			global.pause = false;
			scr_toggle_gui_pause();	
		}
		else {
			//ELSE OPEN DECK PANE INSTEAD
			//DESTROY CURRENT GUI
			scr_destroy_gui_open();
			//TOGGLE PAUSE
			global.pause = true;
			scr_toggle_gui_pause();	
			//OPEN NEW PARTY GUI
			global.active_gui = instance_create_layer(room_width/2,room_height/2,"ily_fx",obj_gui_deck_pane);
		}
	}
	#endregion

//IN RANCH, CLICK TO SHAKE UNIT
if (room == rm_ow_ranch){
	#region CLICK TO SHAKE UNIT
	if (position_meeting(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),obj_ranch_beast_dummy) && mouse_check_button_pressed(mb_left)){
		var _beast = instance_nearest(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),obj_ranch_beast_dummy);
		if (_beast._beast_state != BEAST_STATE.DEAD){
			_beast._emoji = choose(spr_ranch_beast_happy,spr_ranch_beast_love,spr_ranch_beast_excited);
			_beast._emoji_timer = irandom_range(60,120);		
			_beast._beast_state = BEAST_STATE.SHAKE;
		}
	}
	#endregion	
}

//////////////////////////////////////////////////////////////////////
// CAMERA ZOOM TARGET
//////////////////////////////////////////////////////////////////////

if (global.camera != undefined && room != rm_ow_ranch)
{
    var _zoom_step = 128;

    if (mouse_wheel_up())
    {
        global.cam_target_width =
            max(global.cam_min_size,
                global.cam_target_width - _zoom_step);

        global.cam_target_height =
            max(global.cam_min_size,
                global.cam_target_height - _zoom_step);
    }

    if (mouse_wheel_down())
    {
        global.cam_target_width =
            min(global.cam_max_size,
                global.cam_target_width + _zoom_step);

        global.cam_target_height =
            min(global.cam_max_size,
                global.cam_target_height + _zoom_step);
    }
}
}