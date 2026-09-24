
//===============================================================================//
//
// SCRIPT: SCR_STATUS_CONSUME_FROSTBITE
// FUNCTION: Consumes Frostbite stacks and restores the temporary
//           Max HP, PHYDEF, and MAGDEF reductions no longer supported
//           by the remaining stacks.
//
// ARGUMENTS: _ref_target - Beast losing Frostbite.
//            _ct_amount - maximum stacks to consume.
// RETURNS: Number of stacks actually consumed.
//
//===============================================================================//

function scr_status_consume_frostbite(_ref_target,_ct_amount){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return 0;
	}

	_ct_amount = floor(_ct_amount);

	if (_ct_amount <= 0){
		return 0;
	}

	//================//
	//GET FROSTBITE//
	//================//
	var _ref_frostbite = scr_status_check(
		"FROSTBITE",
		_ref_target
	);

	if (
		_ref_frostbite == -1 ||
		!instance_exists(_ref_frostbite)
	){
		return 0;
	}

	//================//
	//GET STACK COUNTS//
	//================//
	var _ct_old_stacks = max(
		0,
		_ref_frostbite._ct_status_stacks
	);

	if (_ct_old_stacks <= 0){
		return 0;
	}

	var _ct_consumed = min(
		_ct_amount,
		_ct_old_stacks
	);

	var _ct_remaining = _ct_old_stacks - _ct_consumed;

	//====================//
	//CONSUME ALL STACKS//
	//====================//
	if (_ct_remaining <= 0){

		scr_status_dot_frostbite(
			"DEATH",
			_ref_frostbite
		);

		return _ct_consumed;
	}

	//====================//
	//RESTORE MAXIMUM HP//
	//====================//
	var _val_old_hp_reduction = max(
		0,
		_ref_frostbite._val_frostbite_max_hp_reduction
	);

	// A remaining stack supports at most 1 point of suppression.
	// Stacks that could not reduce a stat because it reached its
	// minimum are effectively consumed first.

	var _val_new_hp_reduction = min(
		_val_old_hp_reduction,
		_ct_remaining
	);

	var _val_hp_restore =
		_val_old_hp_reduction - _val_new_hp_reduction;

	if (_val_hp_restore > 0){
		_ref_target._val_max_hp += _val_hp_restore;
	}

	_ref_frostbite._val_frostbite_max_hp_reduction =
		_val_new_hp_reduction;

	//================//
	//RESTORE PHYDEF//
	//================//
	var _val_old_pdef_reduction = max(
		0,
		_ref_frostbite._val_frostbite_pdef_reduction
	);

	var _val_new_pdef_reduction = min(
		_val_old_pdef_reduction,
		_ct_remaining
	);

	var _val_pdef_restore =
		_val_old_pdef_reduction - _val_new_pdef_reduction;

	//================//
	//RESTORE MAGDEF//
	//================//
	var _val_old_mdef_reduction = max(
		0,
		_ref_frostbite._val_frostbite_mdef_reduction
	);

	var _val_new_mdef_reduction = min(
		_val_old_mdef_reduction,
		_ct_remaining
	);

	var _val_mdef_restore =
		_val_old_mdef_reduction - _val_new_mdef_reduction;

	//================//
	//APPLY RESTORATION//
	//================//
	if (is_struct(_ref_target._ref_unit)){

		_ref_target._ref_unit._val_beast_pdef_stat +=
			_val_pdef_restore;

		_ref_target._ref_unit._val_beast_mdef_stat +=
			_val_mdef_restore;
	}

	//================//
	//UPDATE FROSTBITE//
	//================//
	_ref_frostbite._ct_status_stacks = _ct_remaining;

	_ref_frostbite._val_frostbite_pdef_reduction =
		_val_new_pdef_reduction;

	_ref_frostbite._val_frostbite_mdef_reduction =
		_val_new_mdef_reduction;

	scr_status_reposition(_ref_target);

	return _ct_consumed;
}