//===============================================================================//
//
// SCRIPT: SCR_STATUS_CONSUME_RAGE
// FUNCTION: Silently consumes Rage stacks from a battle Beast.
//           Removes the corresponding outgoing Linear damage bonus.
//           Destroys Rage when no stacks remain.
//           Does not play VFX, SFX, or popup feedback.
//
// ARGUMENTS: _ref_target is the Beast spending Rage.
//            _ct_amount is the maximum number of Rage stacks to consume.
// RETURNS: The number of Rage stacks actually consumed.
//
//===============================================================================//

function scr_status_consume_rage(_ref_target,_ct_amount=1){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return 0;
	}

	_ct_amount = max(0,floor(_ct_amount));

	if (_ct_amount <= 0){
		return 0;
	}

	//----------------//
	//CHECK FOR RAGE//
	//----------------//
	var _ref_rage = scr_status_check("RAGE",_ref_target);

	if (_ref_rage == -1 || !instance_exists(_ref_rage)){
		return 0;
	}

	//==================//
	//CALCULATE CONSUME//
	//==================//
	var _ct_rage_available = max(0,_ref_rage._ct_status_stacks);
	var _ct_rage_consumed = min(_ct_amount,_ct_rage_available);

	if (_ct_rage_consumed <= 0){
		return 0;
	}

	//================//
	//CHECK ENDLESS RAGE//
	//================//
	var _ref_endless_rage = scr_status_check(
		"ENDLESS_RAGE",
		_ref_target
	);

	//========================//
	//SPEND WITHOUT CONSUMING//
	//========================//
	if (
		_ref_endless_rage != -1 &&
		instance_exists(_ref_endless_rage)
	){

		// Return the amount spent for cards such as Ragefire
		// and Rageplate, but leave Rage and its damage bonus intact.

		return _ct_rage_consumed;
	}

	//================//
	//CONSUME RAGE//
	//================//
	_ref_rage._ct_status_stacks -= _ct_rage_consumed;

	//=====================//
	//REMOVE DAMAGE BONUS//
	//=====================//
	var _val_bonus_removed =
		_ct_rage_consumed *
		_ref_rage._val_status_magnitude;

	_ref_target._val_dmg_linear_bonus = max(
		0,
		_ref_target._val_dmg_linear_bonus - _val_bonus_removed
	);

	//==================//
	//REMOVE LAST STACK//
	//==================//
	if (_ref_rage._ct_status_stacks <= 0){

		scr_status_destroy(_ref_rage);

		return _ct_rage_consumed;
	}

	//------------------//
	//UPDATE DESCRIPTION//
	//------------------//
	_ref_rage._str_status_desc =
		"+" +
		string(_ref_rage._ct_status_stacks) +
		" OUTGOING DAMAGE; TAKE " +
		string(_ref_rage._ct_status_stacks) +
		" NEU DAMAGE EACH ROUND. MAX 5 STACKS.";

	scr_status_reposition(_ref_target);

	return _ct_rage_consumed;
}