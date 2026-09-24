//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_BRAMBLE_ERUPTION
// FUNCTION: Resolves Bramble Eruption.
//           Damages the selected target and adjacent living Beasts.
//           Hits up to 3 targets.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_bramble_eruption(_stct_card,_ref_caster,_ref_target){

	//======================//
	//GET ADJACENT TARGETS//
	//======================//
	var _ref_left_target = scr_battle_get_left_target(_ref_target);
	var _ref_right_target = scr_battle_get_right_target(_ref_target);

	//==================//
	//HIT LEFT ADJACENT//
	//==================//
	if (_ref_left_target != undefined){
		scr_battle_damage_target(
			"LINEAR",
			_ref_caster,
			_ref_left_target,
			_stct_card._val_card_magnitude,
			{card: _stct_card, card_instance: global.ref_cast_card}
		);
	}

	//================//
	//HIT MAIN TARGET//
	//================//
	scr_battle_damage_target(
		"LINEAR",
		_ref_caster,
		_ref_target,
		_stct_card._val_card_magnitude,
		{card: _stct_card, card_instance: global.ref_cast_card}
	);

	//===================//
	//HIT RIGHT ADJACENT//
	//===================//
	if (_ref_right_target != undefined){
		scr_battle_damage_target(
			"LINEAR",
			_ref_caster,
			_ref_right_target,
			_stct_card._val_card_magnitude,
			{card: _stct_card, card_instance: global.ref_cast_card}
		);
	}
}