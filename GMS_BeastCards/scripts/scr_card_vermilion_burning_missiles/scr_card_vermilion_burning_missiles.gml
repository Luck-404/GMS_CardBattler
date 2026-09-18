//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_BURNING_MISSILES
// FUNCTION: Resolves Burning Missiles.
//           Deals linear Magical damage to the selected target and adjacent
//           living Beasts.
//           Any target already Burning before the hit gains 1 additional Burn.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_burning_missiles(_stct_card,_ref_caster,_ref_target){

	//=================//
	//GET AOE-3 TARGETS//
	//=================//
	var _arr_targets = [
		scr_battle_get_left_target(_ref_target),
		_ref_target,
		scr_battle_get_right_target(_ref_target)
	];

	//================//
	//RESOLVE TARGETS//
	//================//
	for (var _it_target = 0;_it_target < array_length(_arr_targets);_it_target++){

		var _ref_affected_target = _arr_targets[_it_target];

		if (!instance_exists(_ref_affected_target)){
			continue;
		}

		if (_ref_affected_target._val_cur_hp <= 0){
			continue;
		}

		//================//
		//CHECK BURN//
		//================//
		var _ref_burn = scr_status_check(
			"BURN",
			_ref_affected_target
		);

		var _flag_already_burning =
			_ref_burn != -1 &&
			instance_exists(_ref_burn);

		//================//
		//DEAL DAMAGE//
		//================//
		scr_battle_damage_target(
			_stct_card._val_card_magnitude,
			_ref_affected_target
		);

		//----------------//
		//VALIDATE TARGET//
		//----------------//
		if (!instance_exists(_ref_affected_target)){
			continue;
		}

		if (_ref_affected_target._val_cur_hp <= 0){
			continue;
		}

		//================//
		//APPLY BURN//
		//================//
		if (_flag_already_burning){

			var _ref_original_target = global.ref_target_beast;

			global.ref_target_beast = _ref_affected_target;

			scr_status_apply_dot("BURN");

			global.ref_target_beast = _ref_original_target;
		}
	}
}