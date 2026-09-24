//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_SAPSPRING
// FUNCTION: Resolves Sapspring.
//           Heals the selected allied Beast and adjacent living allied Beasts.
//           Healing scales linearly from the caster's MAGPOW.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_sapspring(_stct_card,_ref_caster,_ref_target){

	if (!instance_exists(_ref_target)){
		return;
	}

	//=================//
	//GET AOE-3 TARGETS//
	//=================//
	var _arr_targets = [
		scr_battle_get_left_target(_ref_target),
		_ref_target,
		scr_battle_get_right_target(_ref_target)
	];

	//================//
	//HEAL TARGETS//
	//================//
	for (var _it_target = 0; _it_target < array_length(_arr_targets); _it_target++){

		var _ref_affected_target = _arr_targets[_it_target];

		if (!instance_exists(_ref_affected_target)){
			continue;
		}

		if (_ref_affected_target._val_cur_hp <= 0){
			continue;
		}

		scr_battle_heal_target(
			"LINEAR",
			_stct_card._val_card_magnitude,
			_ref_affected_target
		);
	}
}