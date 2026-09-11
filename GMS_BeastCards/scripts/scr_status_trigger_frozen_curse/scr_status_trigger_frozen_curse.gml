//===============================================================================//
//
// SCRIPT: scr_status_trigger_frozen_curse
// FUNCTION: Checks a defending Beast for Frozen Curse.
//           If the defender is Frostbitten, Frostburned, or Frozen,
//           deals the stored additional NEU damage to the defender.
//           Preserves and restores the active battle damage context.
//
//===============================================================================//

function scr_status_trigger_frozen_curse(_ref_defender,_ref_attacker){

	if (!instance_exists(_ref_defender)){
		return false;
	}

	if (!instance_exists(_ref_attacker)){
		return false;
	}

	if (_ref_defender._val_cur_hp <= 0){
		return false;
	}

	//-------------//
	//CHECK CURSE//
	//-------------//
	var _ref_frozen_curse =
		scr_status_check(
			"FROZEN_CURSE",
			_ref_defender
		);

	if (_ref_frozen_curse == -1){
		return false;
	}

	//------------------//
	//CHECK FROSTBITE//
	//------------------//
	var _ref_frostbite =
		scr_status_check(
			"FROSTBITE",
			_ref_defender
		);

	//------------------//
	//CHECK FROSTBURN//
	//------------------//
	var _ref_frostburn =
		scr_status_check(
			"FROSTBURN",
			_ref_defender
		);

	//---------------//
	//CHECK FROZEN//
	//---------------//
	var _ref_frozen =
		scr_status_check(
			"FROZEN",
			_ref_defender
		);

	//--------------------//
	//NO FROST CONDITION//
	//--------------------//
	if (
		_ref_frostbite == -1 &&
		_ref_frostburn == -1 &&
		_ref_frozen == -1 &&
		global.ref_icebreaker_target != _ref_defender
	){
		return false;
	}

	//----------------//
	//GET BONUS DAMAGE//
	//----------------//
	var _val_bonus_damage =
		_ref_frozen_curse._val_status_magnitude;

	if (_val_bonus_damage <= 0){
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
	//SET REACTIVE CONTEXT//
	//-----------------------//
	global.flag_frozen_curse_triggering =
		true;

	global.ref_caster_beast =
		_ref_attacker;

	global.ref_target_beast =
		_ref_defender;

	_stct_card._str_card_stat =
		"NEU";

	//-------------//
	//FEEDBACK//
	//-------------//
	scr_gui_spawn_popup_scrolling(
		"TEXT",
		"FROZEN CURSE",
		undefined,
		c_aqua,
		_ref_defender.x,
		_ref_defender.y - 48
	);

	//----------------//
	//PREVENT REDODGE//
	//----------------//
	_ref_defender._ct_dodge_disabled++;

	//------------------//
	//BONUS DAMAGE HOST//
	//------------------//
	scr_battle_damage_target(
		_val_bonus_damage,
		_ref_defender
	);

	//----------------//
	//RESTORE DODGE//
	//----------------//
	_ref_defender._ct_dodge_disabled =
		max(
			0,
			_ref_defender._ct_dodge_disabled - 1
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

	global.flag_frozen_curse_triggering =
		false;

	return true;
}