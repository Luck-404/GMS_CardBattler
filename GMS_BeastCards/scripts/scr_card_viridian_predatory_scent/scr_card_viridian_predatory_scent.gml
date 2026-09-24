//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_PREDATORY_SCENT
// FUNCTION: Resolves Predatory Scent.
//           Applies Focus to the selected enemy Beast for 3 rounds.
//           Allied Minions prioritize the Focused target.
//           Summons 1 random Viridian Minion on the caster.
//           METABOLIZE 3 consumes exactly 3 Poison to Cultivate every
//           Minion on the caster by 1, including the new summon.
//
// ARGUMENTS: _stct_card, _ref_caster, _ref_target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_viridian_predatory_scent(_stct_card,_ref_caster,_ref_target){

	#region FOCUS

	//================//
	//APPLY FOCUS//
	//================//
	scr_status_apply_debuff("FOCUS", _ref_target, 3);


	#endregion

	#region SUMMON

	//=======================//
	//SUMMON VIRIDIAN MINION//
	//=======================//
	scr_card_summon_focus_minion(
		_stct_card,
		_ref_caster,
		"VIRIDIAN"
	);

	#endregion

	#region METABOLIZE

	//================//
	//VALIDATE CASTER//
	//================//
	if (!instance_exists(_ref_caster)){
		return;
	}

	if (!ds_exists(_ref_caster._list_minions,ds_type_list)){
		return;
	}

	if (ds_list_size(_ref_caster._list_minions) <= 0){
		return;
	}

	//================//
	//CHECK POISON//
	//================//
	var _ref_poison = scr_status_check(
		"POISON",
		_ref_target
	);

	if (
		_ref_poison == -1 ||
		!instance_exists(_ref_poison) ||
		_ref_poison._ct_status_stacks < 3
	){
		return;
	}

	//================//
	//METABOLIZE 3//
	//================//
	var _ct_poison_consumed = scr_battle_trigger_metabolize(
		_ref_target,
		3
	);

	if (_ct_poison_consumed != 3){
		return;
	}

	#endregion

	#region CULTIVATE

	//================//
	//CULTIVATE MINIONS//
	//================//
	for (
		var _it_minion = 0;
		_it_minion < ds_list_size(_ref_caster._list_minions);
		_it_minion++
	){

		var _ref_minion = ds_list_find_value(
			_ref_caster._list_minions,
			_it_minion
		);

		if (!instance_exists(_ref_minion)){
			continue;
		}

		scr_minion_grow(
			_ref_minion,
			1
		);
	}

	#endregion
}
