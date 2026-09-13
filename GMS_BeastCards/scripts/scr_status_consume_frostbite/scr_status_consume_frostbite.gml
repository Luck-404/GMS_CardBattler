//===============================================================================//
//
// SCRIPT: SCR_STATUS_CONSUME_FROSTBITE
// FUNCTION: Consumes a specified number of Frostbite stacks from a target.
//           Restores Maximum HP suppression no longer supported by the
//           remaining Frostbite stacks.
//
// ARGUMENTS: _ref_target is the Beast losing Frostbite and _ct_amount is the
//            maximum number of Frostbite stacks to consume.
// RETURNS: The number of Frostbite stacks actually consumed.
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
	var _ref_frostbite = scr_status_check("FROSTBITE",_ref_target);

	if (
		_ref_frostbite == -1 ||
		!instance_exists(_ref_frostbite)
	){
		return 0;
	}

	//==================//
	//GET STACK COUNTS//
	//==================//
	var _ct_old_stacks = max(0,_ref_frostbite._ct_status_stacks);

	if (_ct_old_stacks <= 0){
		return 0;
	}

	var _ct_consumed = min(_ct_amount,_ct_old_stacks);
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

	//==========================//
	//UPDATE MAX HP SUPPRESSION//
	//==========================//
	var _val_old_reduction = max(0,_ref_frostbite._val_frostbite_max_hp_reduction);

	/*
		Each remaining Frostbite stack can support at most
		1 point of Maximum HP suppression.

		If Frostbite previously accumulated while the Beast
		was already at the 1-Max-HP floor, those unsupported
		stacks are effectively consumed first.
	*/
	var _val_new_reduction = min(_val_old_reduction,_ct_remaining);
	var _val_restore = _val_old_reduction - _val_new_reduction;

	if (_val_restore > 0){
		_ref_target._val_max_hp += _val_restore;
	}

	//==================//
	//UPDATE FROSTBITE//
	//==================//
	_ref_frostbite._ct_status_stacks = _ct_remaining;
	_ref_frostbite._val_frostbite_max_hp_reduction = _val_new_reduction;

	scr_status_reposition(_ref_target);

	return _ct_consumed;
}