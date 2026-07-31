//===============================================================================//
//
// CLEANUP: OBJ_GUI_MARKET_PANE
// FUNCTION: Releases NPC vendor state even when another GUI controller,
//           room transition, or destruction route closes the market pane.
//
//===============================================================================//

if (_str_market_type == "NPC"){
	hscr_release_npc_vendor();
}

if (
	variable_global_exists("ref_active_gui") &&
	global.ref_active_gui == id
){
	global.ref_active_gui = undefined;
}