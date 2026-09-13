//===============================================================================//
//
// SCRIPT: SCR_STATUS_CONSUME_BURN
// FUNCTION: Consumes a specified number of Burn stacks from a target Beast.
//           Removes the Burn Status entirely when no stacks remain.
//           Preserves the current Burn lifetime when stacks remain.
//
// ARGUMENTS: _ref_target is the Beast losing Burn.
//            _ct_amount is the maximum number of Burn stacks consumed.
// RETURNS: The number of Burn stacks actually consumed.
//
//===============================================================================//

function scr_status_consume_burn(_ref_target,_ct_amount){

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
	//GET BURN//
	//================//
	var _ref_burn = scr_status_check("BURN",_ref_target);

	if (_ref_burn == -1 || !instance_exists(_ref_burn)){
		return 0;
	}

	//==================//
	//GET STACK COUNTS//
	//==================//
	var _ct_old_stacks = max(0,_ref_burn._ct_status_stacks);

	if (_ct_old_stacks <= 0){
		return 0;
	}

	var _ct_consumed = min(_ct_amount,_ct_old_stacks);
	var _ct_remaining = _ct_old_stacks - _ct_consumed;

	//====================//
	//CONSUME ALL STACKS//
	//====================//
	if (_ct_remaining <= 0){

		scr_status_dot_burn("DEATH",_ref_burn);

		return _ct_consumed;
	}

	//================//
	//UPDATE BURN//
	//================//
	_ref_burn._ct_status_stacks = _ct_remaining;

	scr_status_reposition(_ref_target);

	return _ct_consumed;
}