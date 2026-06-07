//
//
// STEP: OBJ_GUI_PARTY_RANCH_INTERACTABLE | HANDLE PLAYER INTERACTION TO TRIGGER THE OPENING OF THE GUI
//
//

//
// SPAWN UNITS INITIALLY | SPAWNS THE DUMMY UNITS LISTED IN THE PLAYER RANCH WHEN THE ROOM FIRST OPENS
//
#region SPAWN UNITS ONCE
if (_flag_spawned == false){
	//SPAWN DUMMIES FOR ALL BEASTS STORED IN THE RANCH
	for (var _i = 0; _i < ds_list_size(global.player_ranch); _i++){
		var _unit = ds_list_find_value(global.player_ranch,_i);
		scr_spawn_ranch_unit(_unit);
	}
	_flag_spawned = true;
}
#endregion

//
// HIGHLIGHT AND INTERACTION | IF PLAYER IS NEXT TO, HIGHLIGHT THE RANCH OBJ AND ALLOW INTERACTION
//
#region HIGHLIGHT AND INTERACTION
if (distance_to_object(obj_player) < 48 && global.pause == false){
	image_index = 1;
	
	//ALLOW FOR TRIGGERING AN INTERACTION
	#region E TO INTERACT
	if (_flag_triggered == false && _cooldown == 0){
		if (keyboard_check(ord("E"))){
			_flag_triggered = true;
			_cooldown = 60;
			
			//SET UP THE NEW GUI
			var _ranch_gui = instance_create_layer(room_width/2,room_height/2,"ily_fx",obj_ranch_gui_pane);
			obj_gui_controller.scr_destroy_gui_open();
			global.pause = true;
			obj_gui_controller.scr_toggle_gui_pause();
			global.active_gui = _ranch_gui;
			

		}
	}
	#endregion
} else {
	image_index = 0;
}
#endregion

//
// COOLDOWN | COOLDOWN SO YOU CANT SPAM THE GUI AND HAVE IT OPEN MANY TIMES
//
#region COOLDOWN
if (_cooldown > 0){
	_cooldown--;	
	if (_cooldown <= 0){
		_cooldown = 0;
		_flag_triggered = false;	
	}
}
#endregion