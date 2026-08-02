//===============================================================================//
//
// SCRIPT: SCR_TRIGGER_THORNS
// FUNCTION: Checks a defending Beast for Thorns.
//           Deals the stored neutral retaliation damage to the melee attacker.
//           Preserves and restores the active battle damage context.
//
//===============================================================================//

function scr_trigger_thorns(_ref_defender,_ref_attacker){

	if (!instance_exists(_ref_defender)){
		return false;
	}

	if (!instance_exists(_ref_attacker)){
		return false;
	}

	if (_ref_attacker._val_cur_hp <= 0){
		return false;
	}

	//-------------//
	//CHECK THORNS//
	//-------------//
	var _ref_thorns =
		scr_check_for_status(
			"THORNS",
			_ref_defender
		);

	if (_ref_thorns == -1){
		return false;
	}

	var _val_thorns_damage =
		_ref_thorns._val_status_magnitude;

	if (_val_thorns_damage <= 0){
		return false;
	}

	//----------------------//
	//STORE CURRENT CONTEXT//
	//----------------------//
	var _ref_original_caster =
		global.ref_caster_beast;

	var _ref_original_target =
		global.ref_target_beast;

	var _stct_card =
		global.ref_cast_card._ref_card;

	var _str_original_stat =
		_stct_card._str_card_stat;

	//-----------------------//
	//SET RETALIATION CONTEXT//
	//-----------------------//
	global.flag_thorns_retaliating =
		true;

	global.ref_caster_beast =
		_ref_defender;

	global.ref_target_beast =
		_ref_attacker;

	_stct_card._str_card_stat =
		"NEU";

	//-------------//
	//FEEDBACK//
	//-------------//
	scr_spawn_popup_scrolling(
		"TEXT",
		"THORNS",
		undefined,
		c_green,
		_ref_defender.x,
		_ref_defender.y - 48
	);

	//------------------//
	//RETALIATE//
	//------------------//
	scr_damage_target(
		_val_thorns_damage,
		_ref_attacker
	);

	//----------------//
	//RESTORE CONTEXT//
	//----------------//
	_stct_card._str_card_stat =
		_str_original_stat;

	global.ref_caster_beast =
		_ref_original_caster;

	global.ref_target_beast =
		_ref_original_target;

	global.flag_thorns_retaliating =
		false;

	return true;
}