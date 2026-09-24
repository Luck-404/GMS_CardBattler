//===============================================================================//
//
// SCRIPT: SCR_STATUS_CONSUME_BLEED
// FUNCTION: Consumes up to the requested number of Bleed stacks.
//           Preserves remaining stacks and their current lifetime.
//
// INPUT:    _ref_target - Beast whose Bleed is consumed.
//           _ct_amount - Maximum number of stacks to consume.
//
// RETURNS: Number of Bleed stacks actually consumed.
//
//===============================================================================//

function scr_status_consume_bleed(_ref_target,_ct_amount=1){

	#region VALIDATION

	//================//
	//VALIDATE TARGET//
	//================//
	if (!instance_exists(_ref_target)){
		return 0;
	}

	if (!ds_exists(_ref_target._list_statuses,ds_type_list)){
		return 0;
	}

	//================//
	//VALIDATE AMOUNT//
	//================//
	_ct_amount = max(0,floor(_ct_amount));

	if (_ct_amount <= 0){
		return 0;
	}

	//================//
	//GET BLEED//
	//================//
	var _ref_bleed = scr_status_check(
		"BLEED",
		_ref_target
	);

	if (
		_ref_bleed == -1 ||
		!instance_exists(_ref_bleed)
	){
		return 0;
	}

	#endregion

	#region CONSUME BLEED

	//================//
	//GET STACKS//
	//================//
	var _ct_stacks_before = max(
		0,
		_ref_bleed._ct_status_stacks
	);

	//================//
	//CALCULATE CONSUMED//
	//================//
	var _ct_consumed = min(
		_ct_stacks_before,
		_ct_amount
	);

	if (_ct_consumed <= 0){
		return 0;
	}

	//================//
	//CALCULATE REMAINING//
	//================//
	var _ct_remaining = (
		_ct_stacks_before -
		_ct_consumed
	);

	//================//
	//REMOVE ALL BLEED//
	//================//
	if (_ct_remaining <= 0){

		scr_status_dot_bleed(
			"DEATH",
			_ref_bleed
		);

		return _ct_consumed;
	}

	//================//
	//REMOVE SOME BLEED//
	//================//
	_ref_bleed._ct_status_stacks = _ct_remaining;

	//================//
	//UPDATE STATUS ICONS//
	//================//
	scr_status_reposition(_ref_target);

	#endregion

	return _ct_consumed;
}