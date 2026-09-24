//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_ERUPTING_SLAM
// FUNCTION: Resolves Erupting Slam.
//           Deals linear Physical damage to the selected target.
//           Applies 1 Burn.
//           ERUPTION 5 attacks each Beast that was adjacent to the primary
//           target when the Card was cast for 25% of the primary hit as NEU.
//           ERUPTION can resolve even if the primary target is defeated.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_vermilion_erupting_slam(_stct_card,_ref_caster,_ref_target){

	//======================//
	//SNAPSHOT ADJACENT TARGETS//
	//======================//
	var _arr_targets = [
		scr_battle_get_left_target(_ref_target),
		scr_battle_get_right_target(_ref_target)
	];

	//===================//
	//RESET DAMAGE RESULT//
	//===================//
	if (instance_exists(global.ref_cast_card)){
		global.ref_cast_card._stct_last_damage_result = undefined;
	}

	//================//
	//PRIMARY HIT//
	//================//
	scr_battle_damage_target(
		"LINEAR",
		_ref_caster,
		_ref_target,
		_stct_card._val_card_magnitude,
		{card: _stct_card, card_instance: global.ref_cast_card}
	);

	//====================//
	//GET PRIMARY DAMAGE//
	//====================//
	var _val_primary_damage = 0;

	if (
		instance_exists(global.ref_cast_card) &&
		is_struct(global.ref_cast_card._stct_last_damage_result)
	){
		_val_primary_damage =
			global.ref_cast_card._stct_last_damage_result._val_final_damage;
	}

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return;
	}

	//================//
	//APPLY 1 BURN//
	//================//


	scr_status_apply_dot("BURN", _ref_target);


	//================//
	//ERUPTION 5//
	//================//
	if (!scr_battle_trigger_eruption(_ref_target,5)){
		return;
	}

	if (_val_primary_damage <= 0){
		return;
	}

	//======================//
	//GET ERUPTION DAMAGE//
	//======================//
	var _val_eruption_damage = max(
		1,
		ceil(_val_primary_damage * 0.25)
	);

	//=======================//
	//STORE DAMAGE CONTEXT//
	//=======================//
	var _str_original_stat = _stct_card._str_card_stat;


	//================//
	//SET NEU DAMAGE//
	//================//
	_stct_card._str_card_stat = "NEU";

	//===================//
	//ERUPTION ATTACKS//
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


		scr_battle_damage_target(
			"LINEAR",
			_ref_caster,
			_ref_affected_target,
			_val_eruption_damage,
			{card: _stct_card, card_instance: global.ref_cast_card}
		);
	}

	//========================//
	//RESTORE DAMAGE CONTEXT//
	//========================//
	_stct_card._str_card_stat = _str_original_stat;
}
