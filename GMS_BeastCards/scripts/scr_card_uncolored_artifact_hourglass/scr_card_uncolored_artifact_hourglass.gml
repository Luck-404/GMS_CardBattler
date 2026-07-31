//===============================================================================//
//
// SCRIPT: SCR_CARD_UNCOLORED_ARTIFACT_HOURGLASS
// FUNCTION: Resolves the Artifact Hourglass card effect.
//           Schedules another complete player turn after the current turn ends.
//           Does not stack with another pending extra turn.
//           Plays the associated animation, sound, and popup effects.
//
//===============================================================================//
function scr_card_uncolored_artifact_hourglass(
	_stct_card,
	_ref_caster,
	_ref_target
){

	//--------------------//
	// SCHEDULE EXTRA TURN
	//--------------------//
	if (instance_exists(obj_battle_player_controller)){

		obj_battle_player_controller
			._flag_extra_turn_pending = true;
	}

	//----------------//
	// PLAY ANIMATION
	//----------------//

	//-----------//
	// PLAY SOUND
	//-----------//
	audio_play_sound(snd_buff,0,false);

	//-------------//
	// SPAWN POPUP
	//-------------//
	scr_spawn_popup_scrolling(
		"TEXT",
		"+EXTRA TURN",
		undefined,
		c_white,
		_ref_caster.x,
		_ref_caster.y - 48
	);
}