//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_REKINDLE
// FUNCTION: Sacrifices 20% of the caster's Maximum HP, then queues recovery
//           selection from previously exhausted Vermilion Cards.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is unused for this Global Card.
// RETURNS: No value.
//
//===============================================================================//
function scr_card_vermilion_rekindle(_stct_card,_ref_caster,_ref_target){

	//================//
	//SACRIFICE 20% HP//
	//================//
	scr_battle_sacrifice(
		"HOST_HEALTH",
		_ref_caster,
		20,
		{percent_max_hp: true}
	);

	//================//
	//PLAYER RECOVERY//
	//================//
	if (_ref_caster._str_team != "PLAYER"){
		return;
	}

	//------------------------//
	//CHECK CURRENT EXHAUST//
	//------------------------//
	// The currently cast Rekindle is still in the Hand at this point.
	// Only Cards already exhausted before this resolution qualify.

	var _arr_candidates = scr_battle_get_exhausted_color_candidates(
		"VERMILION"
	);

	if (array_length(_arr_candidates) <= 0){

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"NO EXHAUSTED VERMILION CARDS",
			undefined,
			c_ltgray,
			room_width * 0.5,
			room_height * 0.5
		);

		return;
	}

	//================//
	//QUEUE SELECTION//
	//================//
	obj_battle_player_controller._ct_rekindle_pending++;

	obj_battle_player_controller._ref_rekindle_source_card =
		global.ref_cast_card;
}