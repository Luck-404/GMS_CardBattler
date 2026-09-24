//===============================================================================//
//
// SCRIPT: SCR_BATTLE_TRIGGER_HEMORRHAGE
// FUNCTION: Resolves the Vermilion HEMORRHAGE mechanic.
//           Consumes all Bleed from the target.
//           Deals 2 NEU damage per Bleed consumed as separate damage instances.
//           Uses fixed damage when no valid Card/caster context exists.
//           Applies 1 Bloodlet afterward if the target survives.
//
// ARGUMENTS:    _ref_target - Living Beast whose Bleed will be consumed.
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

	#region DAMAGE CONTEXT

	//================//
	//GET CAST CONTEXT//
	//================//
	var _ref_cast_card = global.ref_cast_card;
	var _ref_caster = global.ref_caster_beast;

	var _stct_cast_card = undefined;
	var _str_original_stat = undefined;

	var _flag_use_card_damage = false;

	//----------------//
	//VALIDATE CARD//
	//----------------//
	if (instance_exists(_ref_cast_card)){

		if (is_struct(_ref_cast_card._ref_card)){

			_stct_cast_card = _ref_cast_card._ref_card;

			//----------------//
			//VALIDATE CASTER//
			//----------------//
			if (instance_exists(_ref_caster)){

				if (is_struct(_ref_caster._ref_unit)){
					_flag_use_card_damage = true;
				}
			}
		}
	}

	//====================//
	//STORE ORIGINAL STAT//
	//====================//
	if (_flag_use_card_damage){

		_str_original_stat = _stct_cast_card._str_card_stat;

		//================//
		//SET NEU DAMAGE//
		//================//
		_stct_cast_card._str_card_stat = "NEU";
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

	//=======================//
	//DEAL SEPARATE INSTANCES//
	//=======================//
	var _ct_damage_instances = 0;

	repeat (_ct_bleed_consumed){

		//----------------//
		//VALIDATE TARGET//
		//----------------//
		if (
			!instance_exists(_ref_target) ||
			_ref_target._val_cur_hp <= 0
		){
			break;
		}

		//================//
		//CARD DAMAGE//
		//================//
		if (
			_flag_use_card_damage &&
			instance_exists(_ref_cast_card) &&
			instance_exists(_ref_caster)
		){

			scr_battle_damage_target(
				"LINEAR",
				_ref_caster,
				_ref_target,
				2,
				{card: _stct_cast_card, card_instance: _ref_cast_card}
			);
		}

		//================//
		//FIXED DAMAGE//
		//================//
		else{

			scr_battle_damage_target(
				"FIXED",
				undefined,
				_ref_target,
				2
			);
		}

		_ct_damage_instances++;
	}

	//===================//
	//RESTORE CARD STAT//
	//===================//
	if (_flag_use_card_damage){
		_stct_cast_card._str_card_stat = _str_original_stat;
	}

	#endregion

	#region BLOODLET

	//================//
	//APPLY BLOODLET//
	//================//
	var _flag_bloodlet_applied = false;

	if (
		instance_exists(_ref_target) &&
		_ref_target._val_cur_hp > 0
	){

		//================//
		//APPLY BLOODLET//
		//================//
		var _ref_bloodlet = scr_status_apply_debuff(
			"BLOODLET",
			_ref_target,
			undefined,
			undefined,
			true
		);

		_flag_bloodlet_applied = instance_exists(_ref_bloodlet);

	}

	#endregion

	#region DEBUG

	//================//
	//LOG HEMORRHAGE//
	//================//
	scr_debug_log_battle_trigger(
		"HEMORRHAGE",
		_ref_caster,
		_ref_target,
		"BLEED CONSUMED: " + string(_ct_bleed_consumed) +
		" | NEU INSTANCES ATTEMPTED: " + string(_ct_damage_instances) +
		" | BASE DAMAGE EACH: 2" +
		" | DAMAGE MODE: " + (_flag_use_card_damage ? "CARD" : "FIXED") +
		" | BLOODLET: " + (_flag_bloodlet_applied ? "YES" : "NO"),
		"SCR_BATTLE_TRIGGER_HEMORRHAGE"
	);

	#endregion

	return _ct_bleed_consumed;
}