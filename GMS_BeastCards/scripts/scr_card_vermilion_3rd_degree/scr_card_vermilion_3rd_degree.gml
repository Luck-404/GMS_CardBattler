//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_3RD_DEGREE
// FUNCTION: Resolves 3rd Degree.
//           Applies its Aura to the selected allied Beast and adjacent allies.
//           Each affected Beast gains 25% outgoing damage and takes
//           15% increased incoming damage.
//
// ARGUMENTS: _stct_card is the 3rd Degree Card struct.
//            _ref_caster is the casting Beast.
//            _ref_target is the selected allied Beast.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_vermilion_3rd_degree(_stct_card,_ref_caster,_ref_target){

	if (_ref_target._str_team != _ref_caster._str_team){
		return;
	}

	//================//
	//GET AOE TARGETS//
	//================//
	var _arr_targets = [
		scr_battle_get_left_target(_ref_target),
		_ref_target,
		scr_battle_get_right_target(_ref_target)
	];


	//================//
	//APPLY AURA//
	//================//
	for (var _it_target = 0;_it_target < array_length(_arr_targets);_it_target++){

		var _ref_ally = _arr_targets[_it_target];

		//----------------//
		//VALIDATE ALLY//
		//----------------//
		if (!instance_exists(_ref_ally)){
			continue;
		}

		if (
			_ref_ally._str_team != _ref_caster._str_team ||
			_ref_ally._str_list != "ALIVE" ||
			_ref_ally._val_cur_hp <= 0
		){
			continue;
		}

		//================//
		//APPLY 3RD DEGREE//
		//================//

		scr_status_apply_aura("3RD_DEGREE", _ref_ally, 0);
	}

}