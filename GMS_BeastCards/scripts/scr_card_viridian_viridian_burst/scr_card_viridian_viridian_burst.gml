//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_VIRIDIAN_BURST
// FUNCTION: Resolves Viridian Burst.
//           Damages the selected target and its immediate adjacent allies.
//           Applies 1 Poison stack to each affected target that survives.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_viridian_viridian_burst(_stct_card,_ref_caster,_ref_target){

	//====================//
	//GET AFFECTED TARGETS//
	//====================//
	var _arr_targets = [
		scr_battle_get_left_target(_ref_target),
		_ref_target,
		scr_battle_get_right_target(_ref_target)
	];


	//====================//
	//HIT AFFECTED TARGETS//
	//====================//
	for (var _it_target = 0; _it_target < array_length(_arr_targets); _it_target++){

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


		//------------//
		//DEAL DAMAGE//
		//------------//
		scr_battle_damage_target(
			"LINEAR",
			_ref_caster,
			_ref_affected_target,
			_stct_card._val_card_magnitude,
			{card: _stct_card, card_instance: global.ref_cast_card}
		);

		//--------------//
		//APPLY POISON//
		//--------------//
		if (instance_exists(_ref_affected_target) && _ref_affected_target._val_cur_hp > 0){
			scr_status_apply_dot("POISON", _ref_affected_target);
		}
	}

}