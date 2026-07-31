//===============================================================================//
//
// CLEANUP: OBJ_GUI_NPC_PANE
// FUNCTION: Releases NPC interaction unless control was transferred
//           directly into the NPC vendor market.
//
//===============================================================================//

//--------------------//
// TRANSFER TO MARKET //
//--------------------//
if (_flag_transfer_to_market){
	exit;
}

//-----------------------//
// NORMAL NPC PANE CLOSE //
//-----------------------//
if (
	_ref_npc != undefined &&
	instance_exists(_ref_npc)
){

	_ref_npc.hscr_close_npc_interaction();
}
else{

	global.ref_interacting_npc = undefined;
	global.ref_active_gui = undefined;

	if (instance_exists(obj_gui_controller)){

		obj_gui_controller.hscr_toggle_gui_pause(false);
	}
	else{

		global.flag_pause = false;

		if (instance_exists(obj_player)){
			scr_toggle_player_movement("START");
		}
	}
}