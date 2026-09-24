//===============================================================================//
//
// STEP: OBJ_RANCH_INTERACTABLE
// FUNCTION: Spawns Ranch Beast dummies once when the Ranch loads.
//           Opens the Ranch GUI when the player interacts.
//           Handles highlight state and interaction cooldown.
//
//===============================================================================//

//==========================//
//SPAWN RANCH DUMMIES ONCE//
//==========================//
if (!_flag_spawned){

	if (
		variable_global_exists("list_player_ranch") &&
		ds_exists(global.list_player_ranch,ds_type_list)
	){

		for (var _it_unit = 0;_it_unit < ds_list_size(global.list_player_ranch);_it_unit++){

			var _stct_unit = ds_list_find_value(global.list_player_ranch,_it_unit);

			if (!is_struct(_stct_unit)){
				continue;
			}

			hscr_ranch_spawn_beast_dummy(_stct_unit);
		}

		_flag_spawned = true;
	}
}

//====================//
//HANDLE INTERACTION//
//====================//
if (distance_to_object(obj_player) < 48 && !global.flag_pause){

	image_index = 1;

	if (!_flag_triggered && _ct_cooldown == 0){

		if (keyboard_check(ord("E"))){

			audio_play_sound(snd_gui_open,0,false);

			_flag_triggered = true;
			_ct_cooldown = 60;

			var _ref_ranch_gui = instance_create_layer(
				room_width * 0.5,
				room_height * 0.5,
				"ily_fx",
				obj_gui_ranch_pane
			);

			obj_gui_controller.hscr_gui_destroy_active();
			obj_gui_controller.hscr_gui_set_pause(true,"RANCH");

			global.ref_active_gui = _ref_ranch_gui;
		}
	}
}
else{
	image_index = 0;
}

//================//
//UPDATE COOLDOWN//
//================//
if (_ct_cooldown > 0){

	_ct_cooldown--;

	if (_ct_cooldown <= 0){
		_ct_cooldown = 0;
		_flag_triggered = false;
	}
}