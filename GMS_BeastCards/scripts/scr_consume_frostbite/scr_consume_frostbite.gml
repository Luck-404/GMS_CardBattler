//===============================================================================//
//
// SCRIPT: SCR_CONSUME_FROSTBITE
// FUNCTION: Consumes a specified number of Frostbite stacks from a target.
//           Restores any Maximum HP suppression no longer supported by
//           the remaining Frostbite stacks.
//           Returns the number of Frostbite stacks actually consumed.
//
//===============================================================================//

function scr_consume_frostbite(_ref_target,_ct_amount){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return 0;
	}

	if (_ct_amount <= 0){
		return 0;
	}

	//----------------//
	//GET FROSTBITE//
	//----------------//
	var _ref_frostbite =
		scr_check_for_status(
			"FROSTBITE",
			_ref_target
		);

	if (_ref_frostbite == -1){
		return 0;
	}

	//----------------//
	//GET STACK COUNTS//
	//----------------//
	var _ct_old_stacks =
		_ref_frostbite._ct_status_stacks;

	var _ct_consumed =
		min(
			_ct_amount,
			_ct_old_stacks
		);

	var _ct_remaining =
		_ct_old_stacks -
		_ct_consumed;

	//------------------//
	//CONSUME ALL STACKS//
	//------------------//
	if (_ct_remaining <= 0){

		scr_status_dot_frostbite(
			"DEATH",
			_ref_frostbite
		);

		return _ct_consumed;
	}

	//-------------------------//
	//GET TRACKED HP REDUCTION//
	//-------------------------//
	var _val_old_reduction =
		_ref_frostbite._val_frostbite_max_hp_reduction;

	/*
		Each remaining Frostbite stack can support at most
		1 point of Maximum HP suppression.

		This matters if the target previously reached the
		1-Max-HP floor and accumulated extra Frostbite stacks.
	*/
	var _val_new_reduction =
		min(
			_val_old_reduction,
			_ct_remaining
		);

	var _val_restore =
		_val_old_reduction -
		_val_new_reduction;

	//----------------//
	//RESTORE MAX HP//
	//----------------//
	if (_val_restore > 0){

		_ref_target._val_max_hp +=
			_val_restore;
	}

	//------------------//
	//UPDATE FROSTBITE//
	//------------------//
	_ref_frostbite._ct_status_stacks =
		_ct_remaining;

	_ref_frostbite._val_frostbite_max_hp_reduction =
		_val_new_reduction;

	scr_reposition_statuses(
		_ref_target
	);

	return _ct_consumed;
}