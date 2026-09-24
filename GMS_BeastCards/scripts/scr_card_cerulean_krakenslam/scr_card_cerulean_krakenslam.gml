//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_KRAKENSLAM
// FUNCTION: Resolves Krakenslam.
//           Deals linear physical damage to the selected target.
//           Applies 1 Bleed and 1 Stormstruck if the target survives.
//
// ARGUMENTS: _stct_card is the Krakenslam card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_cerulean_krakenslam(_stct_card,_ref_caster,_ref_target){

	//================//
	//DEAL DAMAGE//
	//================//
	scr_battle_damage_target(
		"LINEAR",
		_ref_caster,
		_ref_target,
		_stct_card._val_card_magnitude,
		{card: _stct_card, card_instance: global.ref_cast_card}
	);

	//================//
	//APPLY STATUSES//
	//================//
	if (
		instance_exists(_ref_target) &&
		_ref_target._val_cur_hp > 0
	){

		//----------------//
		//APPLY BLEED//
		//----------------//
		scr_status_apply_dot("BLEED", _ref_target);

		//------------------//
		//APPLY STORMSTRUCK//
		//------------------//
		scr_status_apply_dot("STORMSTRUCK", _ref_target);
	}
}