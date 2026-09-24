//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_RAGING_HOWL
// FUNCTION: Applies Stun for 1 round to the selected enemy Beast and its
//           adjacent living enemies, affecting up to 3 targets.
//
// ARGUMENTS: _stct_card, _ref_caster, _ref_target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_vermilion_raging_howl(_stct_card,_ref_caster,_ref_target){

	//=================//
	//GET AOE-3 TARGETS//
	//=================//
	var _arr_targets = scr_battle_get_card_preview_targets(
		_stct_card,
		_ref_target
	);


	//================//
	//APPLY STUN//
	//================//
	for (var _it_target = 0;_it_target < array_length(_arr_targets);_it_target++){

		var _ref_affected_target = _arr_targets[_it_target];

		//----------------//
		//VALIDATE TARGET//
		//----------------//
		if (!instance_exists(_ref_affected_target)){
			continue;
		}

		if (
			_ref_affected_target._str_list != "ALIVE" ||
			_ref_affected_target._val_cur_hp <= 0
		){
			continue;
		}

		//------------------//
		//ENEMY TARGETS ONLY//
		//------------------//
		if (_ref_affected_target._str_team == _ref_caster._str_team){
			continue;
		}


		//================//
		//APPLY 1-ROUND STUN//
		//================//
		scr_status_apply_cc("STUN", _ref_affected_target, _stct_card._val_card_magnitude);
	}

}