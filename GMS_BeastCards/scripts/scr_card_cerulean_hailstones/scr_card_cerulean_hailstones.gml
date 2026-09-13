//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_HAILSTONES
// FUNCTION: Resolves Hailstones.
//           Deals linear magical damage to the selected target
//           and both adjacent living Beasts.
//
// ARGUMENTS: _stct_card is the Hailstones card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_hailstones(_stct_card,_ref_caster,_ref_target){

	//=================//
	//GET AOE-3 TARGETS//
	//=================//
	var _arr_targets = [
		scr_battle_get_left_target(_ref_target),
		_ref_target,
		scr_battle_get_right_target(_ref_target)
	];

	//================//
	//DAMAGE TARGETS//
	//================//
	for (var _it_target = 0;_it_target < array_length(_arr_targets);_it_target++){

		var _ref_affected_target = _arr_targets[_it_target];

		if (!instance_exists(_ref_affected_target)){
			continue;
		}

		scr_battle_damage_target(
			_stct_card._val_card_magnitude,
			_ref_affected_target
		);
	}
}