//===============================================================================//
//
// STEP: OBJ_BATTLE_END_TURN_BUTTON
// FUNCTION: Hides the End Turn button once the battle-ending GUI is active.
//           Registers the button name while hovered.
//
//===============================================================================//

//----------------//
//END BATTLE HIDE//
//----------------//
if (
	instance_exists(
		obj_gui_end_battle_pane
	)
){

	visible =
		false;

	exit;
}

//================//
//HOVER TOOLTIP//
//================//
if (
	visible &&
	!scr_gui_check_cheats_active() &&
	position_meeting(
		device_mouse_x_to_gui(0),
		device_mouse_y_to_gui(0),
		self
	)
){

	scr_gui_set_hover_tooltip(
		"END TURN",
		"",
		10
	);
}