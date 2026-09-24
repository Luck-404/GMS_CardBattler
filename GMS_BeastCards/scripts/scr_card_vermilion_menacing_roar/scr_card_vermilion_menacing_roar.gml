//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_MENACING_ROAR
// FUNCTION: Applies Weakness for 2 rounds to the selected enemy Beast and
//           its adjacent living enemies.
//           At 4+ Rage, also applies Vulnerable for 1 round and 1 Bleed.
//           Rage is checked once and is not consumed.
//
// ARGUMENTS: _stct_card, _ref_caster, _ref_target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_vermilion_menacing_roar(_stct_card,_ref_caster,_ref_target){

	//================//
	//CHECK CASTER RAGE//
	//================//
	var _ref_rage = scr_status_check(
		"RAGE",
		_ref_caster
	);

	var _flag_rage_bonus = false;

	if (
		_ref_rage != -1 &&
		instance_exists(_ref_rage)
	){
		_flag_rage_bonus = _ref_rage._ct_status_stacks >= 4;
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
	//RESOLVE TARGETS//
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

		//------------------//
		//ENEMY TARGETS ONLY//
		//------------------//
		if (_ref_affected_target._str_team == _ref_caster._str_team){
			continue;
		}


		//================//
		//APPLY WEAKNESS//
		//================//
		scr_status_apply_debuff("WEAKNESS", _ref_affected_target, 2);

		//================//
		//CHECK RAGE BONUS//
		//================//
		if (!_flag_rage_bonus){
			continue;
		}

		//================//
		//APPLY VULNERABLE//
		//================//
		scr_status_apply_debuff("VULNERABLE", _ref_affected_target, 1);

		//================//
		//APPLY 1 BLEED//
		//================//
		scr_status_apply_dot("BLEED", _ref_affected_target);
	}

}