//===============================================================================//
//
// CLEANUP: OBJ_GUI_MARKET_PANE
// FUNCTION: Releases NPC vendor state even when another GUI controller,
//           room transition, or destruction route closes the market pane.
//           Clears the active GUI reference when this pane owns it.
//
//===============================================================================//

//================//
//RELEASE NPC VENDOR//
//================//
if (_str_market_type == "NPC"){
	hscr_gui_market_release_npc_vendor();
}

//================//
//CLEAR ACTIVE GUI//
//================//
if (variable_global_exists("ref_active_gui") && global.ref_active_gui == id){
	global.ref_active_gui = undefined;
}