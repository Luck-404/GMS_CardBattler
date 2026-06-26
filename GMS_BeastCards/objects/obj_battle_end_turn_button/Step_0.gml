//===============================================================================//
//
// STEP: OBJ_BATTLE_END_TURN_BUTTON
// FUNCTION: Hides the end turn button after the battle has ended.
//
//===============================================================================//

if (instance_exists(obj_gui_end_battle_pane)){
	visible = false;
}