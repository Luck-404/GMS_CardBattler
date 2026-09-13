//===============================================================================//
//
// SCRIPT: SCR_BATTLE_TRIGGER_HEMORRHAGE
// FUNCTION: Resolves the Vermilion HEMORRHAGE mechanic.
//           Consumes all Bleed from the target.
//           Deals 2 NEU damage per Bleed consumed as separate damage instances.
//           Applies 1 Bloodlet afterward if the target survives.
//
// INPUT:    _ref_target - Living Beast whose Bleed will be consumed.
// RETURNS: The number of Bleed stacks consumed.
//
//===============================================================================//

function scr_battle_trigger_hemorrhage(_ref_target){

	#region VALIDATION

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return 0;
	}

	if (_ref_target._val_cur_hp <= 0){
		return 0;
	}

	//----------------//
	//CHECK FOR BLEED//
	//----------------//
	var _ref_bleed = scr_status_check("BLEED",_ref_target);

	if (_ref_bleed == -1 || !instance_exists(_ref_bleed)){
		return 0;
	}

	var _ct_bleed_consumed = max(0,_ref_bleed._ct_status_stacks);

	if (_ct_bleed_consumed <= 0){
		return 0;
	}

	#endregion

	#region FEEDBACK

	//================//
	//HEMORRHAGE VFX//
	//================//
	scr_battle_vfx_hemorrhage(_ref_target);

	#endregion

	#region CONSUME BLEED

	//================//
	//CONSUME BLEED//
	//================//
	scr_status_dot_bleed("DEATH",_ref_bleed);

	#endregion

	#region HEMORRHAGE DAMAGE

	//----------------//
	//VALIDATE CARD//
	//----------------//
	var _ref_cast_card = global.ref_cast_card;

	if (!instance_exists(_ref_cast_card)){
		return _ct_bleed_consumed;
	}

	if (!is_struct(_ref_cast_card._ref_card)){
		return _ct_bleed_consumed;
	}

	//--------------------//
	//STORE ORIGINAL STAT//
	//--------------------//
	var _stct_cast_card = _ref_cast_card._ref_card;
	var _str_original_stat = _stct_cast_card._str_card_stat;

	//================//
	//SET NEU DAMAGE//
	//================//
	_stct_cast_card._str_card_stat = "NEU";

	//=======================//
	//DEAL SEPARATE INSTANCES//
	//=======================//
	repeat (_ct_bleed_consumed){

		if (!instance_exists(_ref_target) || _ref_target._val_cur_hp <= 0){
			break;
		}

		scr_battle_damage_target(2,_ref_target);
	}

	//-----------------//
	//RESTORE CARD STAT//
	//-----------------//
	_stct_cast_card._str_card_stat = _str_original_stat;

	#endregion

	#region BLOODLET

	//================//
	//APPLY BLOODLET//
	//================//
	if (instance_exists(_ref_target) && _ref_target._val_cur_hp > 0){

		var _ref_original_target = global.ref_target_beast;

		global.ref_target_beast = _ref_target;

		scr_status_apply_debuff(
			"BLOODLET",
			undefined,
			undefined,
			true
		);

		global.ref_target_beast = _ref_original_target;
	}

	#endregion

	#region DEBUG

	//================//
	//LOG HEMORRHAGE//
	//================//
	scr_debug_log_battle_trigger(
		"HEMORRHAGE",
		global.ref_caster_beast,
		_ref_target,
		"BLEED CONSUMED: " + string(_ct_bleed_consumed) +
		" | NEU INSTANCES: " + string(_ct_bleed_consumed) +
		" | BASE DAMAGE EACH: 2" +
		" | BLOODLET: YES",
		"SCR_BATTLE_TRIGGER_HEMORRHAGE"
	);

	#endregion

	return _ct_bleed_consumed;
}