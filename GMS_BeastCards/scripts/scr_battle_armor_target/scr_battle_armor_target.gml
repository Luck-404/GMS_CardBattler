//===============================================================================//
//
// SCRIPT: SCR_BATTLE_ARMOR_TARGET
// FUNCTION: Grants Armor to a target battle Beast.
//           Applies active Armor-gain modifiers before granting Armor.
//           Armorbreak reduces Armor gained by 50% while active.
//           Logs the actual Armor gained and resulting Armor total.
//
// INPUTS:   _val_amount - Base Armor amount to grant.
//           _ref_target - Battle Beast receiving the Armor.
// USES:     Armorbreak status, shared Armor VFX/SFX, hosted Minion
//           Armor-gain triggers, and battle popup feedback.
//
//===============================================================================//

function scr_battle_armor_target(_val_amount,_ref_target){

	#region VALIDATION

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return false;
	}

	if (!is_struct(_ref_target._ref_unit)){
		return false;
	}

	if (_val_amount <= 0){
		return false;
	}

	#endregion

	#region ARMOR GAIN

	//----------------//
	//BASE ARMOR GAIN//
	//----------------//
	var _val_armor_requested = _val_amount;
	var _val_armor_gain = _val_amount;

	var _val_armor_before = _ref_target._val_armor;

	//----------------//
	//CHECK ARMORBREAK//
	//----------------//
	var _ref_armorbreak = scr_status_check("ARMORBREAK",_ref_target);
	var _flag_armorbreak = (_ref_armorbreak != -1);

	if (_flag_armorbreak){
		_val_armor_gain = floor(_val_armor_gain * 0.50);
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
	_ref_target._val_armor += _val_armor_gain;

	#endregion

	#region FEEDBACK

	//---------------//
	//ARMOR VFX / SFX//
	//---------------//
	scr_battle_vfx(
		_ref_target,
		spr_battle_vfx_armor,
		undefined,
		undefined,
		0,
		0,
		1,
		0,
		snd_battle_armor
	);

	//-------------//
	//SPAWN POPUP//
	//-------------//
	scr_gui_spawn_popup_scrolling(
		"TEXT",
		"+" + string(_val_armor_gain),
		undefined,
		c_blue,
		_ref_target.x + irandom_range(-32,32),
		_ref_target.y - 24 + irandom_range(-32,32)
	);

	#endregion

	#region DEBUG

	//----------------//
	//GET SOURCE CARD//
	//----------------//
	var _str_source = "SYSTEM";

	if (
		instance_exists(global.ref_cast_card) &&
		is_struct(global.ref_cast_card._ref_card)
	){
		_str_source = string_upper(global.ref_cast_card._ref_card._str_card_name);
	}

	//----------------//
	//BUILD MESSAGE//
	//----------------//
	var _str_message =
		string_upper(_ref_target._str_team) + " " +
		string_upper(_ref_target._ref_unit._str_beast_name) +
		" GAINED " + string(_val_armor_gain) +
		" ARMOR | " + string(_val_armor_before) +
		" -> " + string(_ref_target._val_armor) +
		" | SOURCE: " + _str_source;

	if (_flag_armorbreak){

		_str_message +=
			" | ARMORBREAK: " +
			string(_val_armor_requested) +
			" -> " +
			string(_val_armor_gain);
	}

	//----------------//
	//LOG ARMOR GAIN//
	//----------------//
	scr_debug_log(
		"BATTLE",
		"ARMOR",
		_ref_target,
		_str_message,
		"BATTLE",
		"SCR_BATTLE_ARMOR_TARGET"
	);

	#endregion

	#region MINION TRIGGERS

	//----------------------//
	//TRIGGER HOSTED MINIONS//
	//----------------------//
	scr_minion_trigger_host_armor_gain(_ref_target,_val_armor_gain);

	#endregion

	return true;
}