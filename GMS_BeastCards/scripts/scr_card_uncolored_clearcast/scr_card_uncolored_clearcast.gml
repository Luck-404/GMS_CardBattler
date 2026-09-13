//===============================================================================//
//
// SCRIPT: SCR_CARD_UNCOLORED_CLEARCAST
// FUNCTION: Resolves Clearcast.
//           Removes the active Weather and runs its normal cleanup behavior.
//           Spawns a Weather-cleared popup.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_uncolored_clearcast(_stct_card,_ref_caster,_ref_target){

	//======================//
	//REMOVE ACTIVE WEATHER//
	//======================//
	scr_status_clear_weather();

	//================//
	//SPAWN POPUP//
	//================//
	scr_gui_spawn_popup_scrolling(
		"TEXT",
		"WEATHER CLEARED",
		undefined,
		c_black,
		room_width / 2 - 300,
		room_height / 2
	);
}