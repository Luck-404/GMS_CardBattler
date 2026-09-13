//===============================================================================//
//
// CLEANUP: OBJ_GUI_NPC_PANE
// FUNCTION: Releases NPC interaction unless control was transferred
//           directly into the NPC vendor market.
//
//===============================================================================//

//================//
//MARKET TRANSFER//
//================//
if (_flag_transfer_to_market){
	exit;
}

//================//
//RELEASE NPC//
//================//
if (instance_exists(_ref_npc)){
	_ref_npc.hscr_npc_close_interaction();
}
else{

	global.ref_interacting_npc = undefined;
	global.ref_active_gui = undefined;

	if (instance_exists(obj_gui_controller)){
		obj_gui_controller.hscr_gui_set_pause(false);
	}
	else{

		global.flag_pause = false;

		if (instance_exists(obj_player)){
			scr_player_set_movement_state("START");
		}
	}
}