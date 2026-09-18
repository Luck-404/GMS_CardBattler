//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_RAGEFIRE
// FUNCTION: Resolves Ragefire.
//           Consumes all Rage from the caster.
//           Deals linear Magical damage to up to 3 adjacent targets,
//           gaining 4 additional damage per Rage consumed.
//           Applies 1 Burn to each surviving target.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_ragefire(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//VALIDATE BEASTS//
	//----------------//
	if (!instance_exists(_ref_caster)){
		return;
	}

	if (!instance_exists(_ref_target)){
		return;
	}

	//================//
	//GET RAGE//
	//================//
	var _ct_rage = 0;
	var _ref_rage = scr_status_check(
		"RAGE",
		_ref_caster
	);

	if (
		_ref_rage != -1 &&
		instance_exists(_ref_rage)
	){
		_ct_rage = _ref_rage._ct_status_stacks;
	}

	//================//
	//CONSUME ALL RAGE//
	//================//
	if (_ct_rage > 0){
		_ct_rage = scr_status_consume_rage(
			_ref_caster,
			_ct_rage
		);
	}

	//================//
	//GET DAMAGE//
	//================//
	var _val_damage =
		_stct_card._val_card_magnitude +
		(_ct_rage * 4);

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
		//DEAL DAMAGE//
		//================//
		scr_battle_damage_target(
			_val_damage,
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
		//APPLY 1 BURN//
		//================//
		var _ref_original_target = global.ref_target_beast;

		global.ref_target_beast = _ref_affected_target;

		scr_status_apply_dot("BURN");

		global.ref_target_beast = _ref_original_target;
	}
}