//===============================================================================//
//
// SCRIPT: SCR_STATUS_TRIGGER_PAIN_RESPONSE
// FUNCTION: Checks a Beast for Pain Response after actual HP damage.
//           Ignores Armor and Overhealth damage.
//           The Buff handles the once-per-round restriction.
//
//===============================================================================//

function scr_status_trigger_pain_response(_ref_target,_val_hp_damage){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return false;
	}

	//----------------//
	//VALIDATE DAMAGE//
	//----------------//
	if (_val_hp_damage <= 0){
		return false;
	}

	//================//
	//CHECK STATUS//
	//================//
	var _ref_status = scr_status_check(
		"PAIN_RESPONSE",
		_ref_target
	);

	if (
		_ref_status == -1 ||
		!instance_exists(_ref_status)
	){
		return false;
	}

	//================//
	//TRIGGER STATUS//
	//================//
	return scr_status_buff_pain_response(
		"TRIGGER",
		_ref_status,
		undefined,
		undefined,
		_val_hp_damage
	);
}