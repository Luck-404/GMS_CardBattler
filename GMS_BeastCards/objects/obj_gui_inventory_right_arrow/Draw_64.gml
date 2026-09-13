//===============================================================================//
//
// DRAW GUI: OBJ_GUI_INVENTORY_RIGHT_ARROW
// FUNCTION: Draws the inventory page right arrow.
//           Hides the arrow while an inventory prompt is active.
//
//===============================================================================//

//================//
//VALIDATE PANE//
//================//
if (!instance_exists(_ref_gui_pane)){
	exit;
}

//================//
//PROMPT ACTIVE//
//================//
if (_ref_gui_pane._flag_prompt_active){
	exit;
}

//================//
//DRAW ARROW//
//================//
draw_self();