//===============================================================================//
//
// END STEP: OBJ_GUI_END_BATTLE_PANE
// FUNCTION: Keeps the battle-result screen authoritative while active.
//           Immediately closes any Cheats Menu reopened during the result screen
//           and clears the GUI pause state it created.
//
//===============================================================================//

//================//
//CHECK CHEATS//
//================//
var _flag_cheats_active =
	variable_global_exists("ref_active_gui") &&
	instance_exists(global.ref_active_gui) &&
	variable_instance_exists(global.ref_active_gui,"_str_type") &&
	global.ref_active_gui._str_type == "CHEATS";

if (!_flag_cheats_active){
	exit;
}

//================//
//CLOSE CHEATS//
//================//
if (instance_exists(obj_gui_controller)){

	obj_gui_controller.hscr_gui_destroy_active(
		"BATTLE END LOCK"
	);

	obj_gui_controller.hscr_gui_set_pause(
		false,
		"BATTLE END LOCK"
	);
}
else{

	var _ref_cheats =
		global.ref_active_gui;

	global.ref_active_gui =
		undefined;

	instance_destroy(
		_ref_cheats
	);

	global.flag_pause =
		false;
}