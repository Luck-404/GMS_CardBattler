//===============================================================================//
//
// STEP: OBJ_MARKET_PRISM_INTERACTABLE
// FUNCTION: Handles player proximity, highlight state, and interaction input.
//           Opens the generic market pane as a prism vendor.
//           Passes this stall's market type and UID into the pane.
//
//===============================================================================//

//
// HIGHLIGHT AND INTERACTION
//
#region HIGHLIGHT AND INTERACTION
if (instance_exists(obj_player) && distance_to_object(obj_player) < 48 && !global.flag_pause){

	image_index = 1;

	if (!_flag_triggered && _ct_cooldown == 0){

		if (keyboard_check_pressed(ord("E"))){
		audio_play_sound(snd_gui_open,0,false);
			_flag_triggered = true;
			_ct_cooldown = 60;

			obj_gui_controller.hscr_destroy_gui_open();
			obj_gui_controller.hscr_toggle_gui_pause(true);

			var _ref_market_gui = instance_create_layer(
				room_width * 0.5,
				room_height * 0.5,
				"ily_fx",
				obj_gui_market_pane
			);

			_ref_market_gui._str_market_type = "PRISM";
			_ref_market_gui._str_market_uid = _str_market_uid;
			_ref_market_gui._ref_market_owner = self;

			_ref_market_gui.hscr_market_init();

			global.ref_active_gui = _ref_market_gui;
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
if (_ct_cooldown > 0){

	_ct_cooldown--;

	if (_ct_cooldown <= 0){
		_ct_cooldown = 0;
		_flag_triggered = false;
	}
}
#endregion