//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_OVERGROWTH
// FUNCTION: Resolves Overgrowth.
//           Grants linearly scaled physical Armor to the caster
//           and the caster's adjacent living allied Beasts.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_overgrowth(_stct_card,_ref_caster,_ref_target){

	//====================//
	//GET ADJACENT ALLIES//
	//====================//
	var _arr_targets = [
		scr_battle_get_left_target(_ref_caster),
		_ref_caster,
		scr_battle_get_right_target(_ref_caster)
	];

	//================//
	//GRANT AOE ARMOR//
	//================//
	for (var _it_target = 0; _it_target < array_length(_arr_targets); _it_target++){

		var _ref_affected_target = _arr_targets[_it_target];

		if (!instance_exists(_ref_affected_target)){
			continue;
		}

		scr_battle_armor_target_linear(_stct_card._val_card_magnitude,_ref_affected_target);
	}
}