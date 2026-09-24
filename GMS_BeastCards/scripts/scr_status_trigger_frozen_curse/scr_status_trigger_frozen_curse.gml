
//===============================================================================//
//
// SCRIPT: SCR_STATUS_TRIGGER_FROZEN_CURSE
// FUNCTION: Checks a defending Beast for Frozen Curse.
//           If the defender is Frostbitten, Frostburned, Frozen, or was the
//           current ICEBREAKER target, deals additional NEU damage.
//           Bonus damage = stored magnitude * active stacks.
//           Preserves combat context and logs the successful trigger.
//
// ARGUMENTS: _ref_defender is the Beast struck.
//            _ref_attacker is the Beast responsible for the Attack.
// RETURNS: True when Frozen Curse triggers; otherwise false.
//
//===============================================================================//

function scr_status_trigger_frozen_curse(_ref_defender,_ref_attacker){

	//-------------------//
	//VALIDATE DEFENDER//
	//-------------------//
	if (!instance_exists(_ref_defender)){
		return false;
	}

	if (_ref_defender._val_cur_hp <= 0){
		return false;
	}

	//-------------------//
	//VALIDATE ATTACKER//
	//-------------------//
	if (!instance_exists(_ref_attacker)){
		return false;
	}

	//================//
	//CHECK CURSE//
	//================//
	var _ref_frozen_curse = scr_status_check(
		"FROZEN_CURSE",
		_ref_defender
	);

	if (_ref_frozen_curse == -1){
		return false;
	}

	if (!instance_exists(_ref_frozen_curse)){
		return false;
	}

	//=======================//
	//CHECK FROST CONDITION//
	//=======================//
	var _ref_frostbite = scr_status_check(
		"FROSTBITE",
		_ref_defender
	);

	var _ref_frostburn = scr_status_check(
		"FROSTBURN",
		_ref_defender
	);

	var _ref_frozen = scr_status_check(
		"FROZEN",
		_ref_defender
	);

	if (
		_ref_frostbite == -1 &&
		_ref_frostburn == -1 &&
		_ref_frozen == -1 &&
		global.ref_icebreaker_target != _ref_defender
	){
		return false;
	}

	//============================//
	//CALCULATE TOTAL BONUS DAMAGE//
	//============================//
	var _val_bonus_damage =
		_ref_frozen_curse._val_status_magnitude *
		_ref_frozen_curse._ct_status_stacks;

	if (_val_bonus_damage <= 0){
		return false;
	}

	//-----------------------//
	//VALIDATE CARD CONTEXT//
	//-----------------------//
	if (!instance_exists(global.ref_cast_card)){
		return false;
	}

	var _stct_card = global.ref_cast_card._ref_card;

	if (!is_struct(_stct_card)){
		return false;
	}

	//=======================//
	//STORE CURRENT CONTEXT//
	//=======================//
	var _ref_original_caster = global.ref_caster_beast;
	var _str_original_stat = _stct_card._str_card_stat;
	var _flag_original_triggering = global.flag_frozen_curse_triggering;

	//======================//
	//SET REACTIVE CONTEXT//
	//======================//
	global.flag_frozen_curse_triggering = true;
	global.ref_caster_beast = _ref_attacker;

	_stct_card._str_card_stat = "NEU";

	//================//
	//DEBUG TRIGGER//
	//================//
	scr_debug_log_battle_trigger(
		"FROZEN CURSE",
		_ref_defender,
		_ref_defender,
		"ATTACKER: " +
		string_upper(_ref_attacker._str_team) + " " +
		string_upper(_ref_attacker._ref_unit._str_beast_name) +
		" | STACKS: " +
		string(_ref_frozen_curse._ct_status_stacks) +
		" | BONUS NEU DAMAGE: " +
		string(_val_bonus_damage),
		"SCR_STATUS_TRIGGER_FROZEN_CURSE"
	);

	//================//
	//DEAL BONUS DAMAGE//
	//================//
	scr_battle_damage_target(
		"LINEAR",
		_ref_attacker,
		_ref_defender,
		_val_bonus_damage,
		{
			card: _stct_card,
			card_instance: global.ref_cast_card
		}
	);

	//========================//
	//RESTORE CURRENT CONTEXT//
	//========================//
	_stct_card._str_card_stat = _str_original_stat;

	global.ref_caster_beast = _ref_original_caster;
	global.flag_frozen_curse_triggering = _flag_original_triggering;

	return true;
}