//////////////////////////////////////////////////////////////////////
//						SCR_RESET_PLAYSTATE							//
//																	//
// > RESETS ENCOUNTER RELATED VARIABLES								//
//////////////////////////////////////////////////////////////////////
function scr_reset_playstate(){
/////////////////////////////////////////
// RESET PLAYER VARIABLES FOR NEW CAST //
/////////////////////////////////////////
//reset player's selected and such
obj_player._card_selected = undefined;	
obj_player._channel_selected = undefined;
obj_player._target_selected = undefined;
			
with(obj_card){
	obj_card._active = false;
	obj_card._selected = false;
}
			
with(obj_creature){
	obj_creature._active = false;
	obj_creature._selected_channel = false;
	obj_creature._selected_target = false;
}			
	
obj_player._flag_check_card = false;
obj_player._flag_check_channel = false;
obj_player._flag_check_target = false;
}