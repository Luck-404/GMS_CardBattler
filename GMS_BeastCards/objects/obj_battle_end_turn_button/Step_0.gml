//===============================================================================//
//
// STEP: OBJ_BATTLE_END_TURN_BUTTON
// FUNCTION: Hides the End Turn button once the battle-ending GUI is active.
//
//===============================================================================//

//----------------//
//END BATTLE HIDE//
//----------------//
if (instance_exists(obj_gui_end_battle_pane)){
	visible = false;
}