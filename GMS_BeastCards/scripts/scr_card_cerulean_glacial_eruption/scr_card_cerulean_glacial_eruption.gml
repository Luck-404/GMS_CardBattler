//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_GLACIAL_ERUPTION
// FUNCTION: Resolves Glacial Eruption.
//           Deals linear magical damage to the selected target
//           and its adjacent enemies.
//           Freezes the surviving center target.
//
// ARGUMENTS: _stct_card is the Glacial Eruption card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_cerulean_glacial_eruption(_stct_card,_ref_caster,_ref_target){

	//=================//
	//GET AOE-3 TARGETS//
	//=================//
	var _arr_targets = [
		scr_battle_get_left_target(_ref_target),
		_ref_target,
		scr_battle_get_right_target(_ref_target)
	];

	//================//
	//DEAL DAMAGE//
	//================//
	for (var _it_target = 0;_it_target < array_length(_arr_targets);_it_target++){

		var _ref_affected_target = _arr_targets[_it_target];

		if (!instance_exists(_ref_affected_target)){
			continue;
		}

		if (
			_ref_affected_target._str_list != "ALIVE" ||
			_ref_affected_target._val_cur_hp <= 0
		){
			continue;
		}

		scr_battle_damage_target(
			_stct_card._val_card_magnitude,
			_ref_affected_target
		);
	}

	//====================//
	//FREEZE CENTER TARGET//
	//====================//
	if (
		instance_exists(_ref_target) &&
		_ref_target._val_cur_hp > 0
	){

		scr_status_apply_cc("FROZEN", _ref_target);

	}
}