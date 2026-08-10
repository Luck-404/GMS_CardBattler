//===============================================================================//
//
// SCRIPT: SCR_ARMOR_TARGET
// FUNCTION: Grants Armor to a target battle Beast.
//           Applies active Armor-gain modifiers before granting Armor.
//           Armorbreak reduces Armor gained by 50% while active.
//
//===============================================================================//
function scr_armor_target(_val_amount,_ref_target){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return false;
	}

	if (_val_amount <= 0){
		return false;
	}

	//----------------//
	//BASE ARMOR GAIN//
	//----------------//
	var _val_armor_gain =
		_val_amount;

	//----------------//
	//CHECK ARMORBREAK//
	//----------------//
	var _ref_armorbreak =
		scr_check_for_status(
			"ARMORBREAK",
			_ref_target
		);

	if (_ref_armorbreak != -1){

		_val_armor_gain =
			floor(
				_val_armor_gain *
				0.50
			);
	}

	//------------------//
	//CHECK FINAL AMOUNT//
	//------------------//
	if (_val_armor_gain <= 0){
		return false;
	}

	//-------------//
	//GRANT ARMOR//
	//-------------//
	_ref_target._val_armor +=
		_val_armor_gain;

	//-------------//
	//SPAWN POPUP//
	//-------------//
	scr_spawn_popup_scrolling(
		"TEXT",
		"+" + string(_val_armor_gain),
		undefined,
		c_blue,
		_ref_target.x + irandom_range(-32,32),
		_ref_target.y - 24 + irandom_range(-32,32)
	);

	return true;
}