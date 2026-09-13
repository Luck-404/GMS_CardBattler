//===============================================================================//
//
// STEP: OBJ_MARKET_EGG_INTERACTABLE
// FUNCTION: Handles player proximity, highlight state, and interaction input.
//           Opens the generic Market pane as an Egg Market.
//           Passes the stall's persistent Market UID into the pane.
//
//===============================================================================//

//================//
//INTERACTION//
//================//
if (
	instance_exists(obj_player) &&
	distance_to_object(obj_player) < 48 &&
	!global.flag_pause
){

	image_index = 1;

	if (
		!_flag_triggered &&
		_ct_cooldown == 0 &&
		keyboard_check_pressed(ord("E"))
	){

		audio_play_sound(
			snd_gui_open,
			0,
			false
		);

		_flag_triggered = true;
		_ct_cooldown = 60;

		//================//
		//PREPARE GUI//
		//================//
		if (instance_exists(obj_gui_controller)){

			obj_gui_controller.hscr_gui_destroy_active();
			obj_gui_controller.hscr_gui_set_pause(true);
		}

		//================//
		//OPEN MARKET//
		//================//
		var _ref_market_gui = instance_create_layer(
			display_get_gui_width() * 0.5,
			display_get_gui_height() * 0.5,
			"ily_fx",
			obj_gui_market_pane
		);

		_ref_market_gui._str_market_type = _str_market_type;
		_ref_market_gui._str_market_uid = _str_market_uid;
		_ref_market_gui._ref_market_owner = self;

		_ref_market_gui.hscr_gui_market_init();

		global.ref_active_gui = _ref_market_gui;
	}
}
else{
	image_index = 0;
}

//================//
//COOLDOWN//
//================//
if (_ct_cooldown > 0){

	_ct_cooldown--;

	if (_ct_cooldown <= 0){

		_ct_cooldown = 0;
		_flag_triggered = false;
	}
}