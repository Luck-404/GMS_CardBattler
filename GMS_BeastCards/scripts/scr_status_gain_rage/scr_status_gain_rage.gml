//===============================================================================//
//
// SCRIPT: SCR_STATUS_GAIN_RAGE
// FUNCTION: Grants Rage directly to a living battle Beast.
//           Uses Rage's normal APPLY callback without a CON resistance check.
//           Uses the supplied Beast reference without changing battle selection.
//
// ARGUMENTS: _ref_target is the Beast gaining Rage.
//            _ct_amount is the number of Rage stacks to gain.
// RETURNS: The active Rage Status, or undefined if no Rage is applied.
//
//===============================================================================//

function scr_status_gain_rage(_ref_target,_ct_amount=1){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return undefined;
	}

	if (_ref_target._val_cur_hp <= 0){
		return undefined;
	}

	_ct_amount = max(0,floor(_ct_amount));

	if (_ct_amount <= 0){
		return undefined;
	}

	//================//
	//GAIN RAGE//
	//================//
	var _ref_rage = undefined;

	repeat (_ct_amount){
		_ref_rage = scr_status_dot_rage("APPLY", undefined, undefined, _ref_target);
	}


	return _ref_rage;
}