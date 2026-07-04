//===============================================================================//
//
// DRAW GUI: OBJ_GUI_INVENTORY_RIGHT_ARROW
// FUNCTION: Draws the inventory page right arrow.
//
//===============================================================================//
if (instance_exists(_ref_gui_pane) && _ref_gui_pane._flag_prompt_active){
	exit;
} else {
	draw_self();
}
