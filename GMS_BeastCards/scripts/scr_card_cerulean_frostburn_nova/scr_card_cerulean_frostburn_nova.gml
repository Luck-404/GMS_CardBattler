//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_FROSTBURN_NOVA
// FUNCTION: Resolves Frostburn Nova.
//           Applies 1 Frostburn to the selected enemy Beast
//           and its adjacent living Beasts.
//           Frozen targets receive 1 additional Frostburn.
//
// ARGUMENTS: _stct_card is the Frostburn Nova card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_cerulean_frostburn_nova(_stct_card,_ref_caster,_ref_target){

	//=================//
	//GET AOE-3 TARGETS//
	//=================//
	var _arr_targets = [
		scr_battle_get_left_target(_ref_target),
		_ref_target,
		scr_battle_get_right_target(_ref_target)
	];


	//===================//
	//APPLY FROSTBURN//
	//===================//
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

		//----------------//
		//CHECK FROZEN//
		//----------------//
		var _flag_frozen = scr_status_check("FROZEN",_ref_affected_target) != -1;


		//------------------//
		//APPLY FROSTBURN//
		//------------------//
		scr_status_apply_dot("FROSTBURN", _ref_affected_target);

		if (_flag_frozen){
			scr_status_apply_dot("FROSTBURN", _ref_affected_target);
		}
	}

}
