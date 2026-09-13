//===============================================================================//
//
// SCRIPT: SCR_CARD_UNCOLORED_ARTIFACT_HOURGLASS
// FUNCTION: Resolves Artifact Hourglass.
//           Schedules another complete player turn after the current turn ends.
//           Does not stack with another pending extra turn.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_uncolored_artifact_hourglass(_stct_card,_ref_caster,_ref_target){

	//====================//
	//SCHEDULE EXTRA TURN//
	//====================//
	if (instance_exists(obj_battle_player_controller)){
		obj_battle_player_controller._flag_extra_turn_pending = true;
	}

	//================//
	//SPAWN POPUP//
	//================//
	scr_gui_spawn_popup_scrolling(
		"TEXT",
		"+EXTRA TURN",
		undefined,
		c_white,
		_ref_caster.x,
		_ref_caster.y - 48
	);
}