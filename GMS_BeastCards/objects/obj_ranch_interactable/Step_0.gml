//===============================================================================//
//
// STEP: OBJ_RANCH_INTERACTABLE
// FUNCTION: Spawns ranch dummy beasts once when the ranch loads.
//           Opens the ranch GUI when the player interacts.
//           Handles highlight state and interaction cooldown.
//
//===============================================================================//

//
// SPAWN RANCH UNITS ONCE
//
#region SPAWN UNITS ONCE
if (!_flag_spawned){

	for (var _it_unit = 0; _it_unit < ds_list_size(global.player_ranch); _it_unit++){

		var _stct_unit = ds_list_find_value(global.player_ranch,_it_unit);

		if (_stct_unit == undefined){
			continue;
		}

		hscr_spawn_ranch_unit(_stct_unit);
	}

	_flag_spawned = true;
}
#endregion

//
// HIGHLIGHT AND INTERACTION
//
#region HIGHLIGHT AND INTERACTION
if (distance_to_object(obj_player) < 48 && !global.pause){

	image_index = 1;

	if (!_flag_triggered && _val_cooldown == 0){

		if (keyboard_check(ord("E"))){

			_flag_triggered = true;
			_val_cooldown = 60;

			var _ref_ranch_gui = instance_create_layer(room_width * 0.5,room_height * 0.5,"ily_fx",obj_gui_ranch_pane);

			obj_gui_controller.hscr_destroy_gui_open();
			obj_gui_controller.hscr_toggle_gui_pause(true);

			global.active_gui = _ref_ranch_gui;
		}
	}
}
else{
	image_index = 0;
}
#endregion

//
// COOLDOWN
//
#region COOLDOWN
if (_val_cooldown > 0){

	_val_cooldown--;

	if (_val_cooldown <= 0){
		_val_cooldown = 0;
		_flag_triggered = false;
	}
}
#endregion