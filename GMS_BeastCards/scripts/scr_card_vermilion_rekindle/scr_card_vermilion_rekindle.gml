//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_REKINDLE
// FUNCTION: Resolves Rekindle.
//           Sacrifices 20% of the caster's Maximum HP.
//           Queues a selection from previously exhausted Vermilion Cards.
//           The selected Card returns to the draw pile after cast resolution.
//
// ARGUMENTS: _stct_card is the Rekindle Card struct.
//            _ref_caster is the casting Beast.
//            _ref_target is unused for this Self-target Card.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_rekindle(_stct_card,_ref_caster,_ref_target){

	//================//
	//SACRIFICE 20% HP//
	//================//
	var _val_hp_cost = ceil(_ref_caster._val_max_hp * 0.20);

	var _val_hp_loss = min(
		_val_hp_cost,
		_ref_caster._val_cur_hp
	);

	_ref_caster._val_cur_hp = max(
		0,
		_ref_caster._val_cur_hp - _val_hp_loss
	);

	//================//
	//HP LOSS FEEDBACK//
	//================//
	if (_val_hp_loss > 0){

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"-" + string(_val_hp_loss) + " HP",
			undefined,
			c_red,
			_ref_caster.x,
			_ref_caster.y - 48
		);
	}

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