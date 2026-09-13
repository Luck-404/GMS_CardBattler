//===============================================================================//
//
// SCRIPT: SCR_BATTLE_TRIGGER_SHATTER
// FUNCTION: Resolves the Cerulean SHATTER mechanic.
//           Consumes all Frostbite stacks from the target, restoring Maximum HP
//           suppressed by Frostbite, then deals 3 NEU damage per stack consumed.
//
// INPUT:    _ref_target - Living Beast whose Frostbite will be SHATTERED.
// USES:     Frostbite status lookup/removal, shared battle damage,
//           Card cast context, shared battle feedback,
//           and battle-trigger debug logging.
//
//===============================================================================//

function scr_battle_trigger_shatter(_ref_target){

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

	//-----------------//
	//CHECK FROSTBITE//
	//-----------------//
	var _ref_frostbite = scr_status_check("FROSTBITE",_ref_target);

	if (_ref_frostbite == -1){
		return 0;
	}

	var _ct_frostbite_stacks = _ref_frostbite._ct_status_stacks;

	if (_ct_frostbite_stacks <= 0){
		return 0;
	}

	#endregion

	#region FEEDBACK

	//------------------//
	//SHATTER VFX / SFX//
	//------------------//
	scr_battle_vfx(
		_ref_target,
		spr_battle_vfx_shatter,
		undefined,
		undefined,
		0,
		0,
		1,
		0,
		snd_battle_shatter
	);

	//---------------//
	//SHATTER POPUP//
	//---------------//
	scr_gui_spawn_popup_scrolling(
		"TEXT",
		"SHATTER",
		undefined,
		c_aqua,
		_ref_target.x,
		_ref_target.y - 48
	);

	#endregion

	#region CONSUME FROSTBITE

	//------------------//
	//CONSUME FROSTBITE//
	//------------------//
	scr_status_dot_frostbite(
		"DEATH",
		_ref_frostbite
	);

	#endregion

	#region SHATTER DAMAGE

	//------------------//
	//CALCULATE DAMAGE//
	//------------------//
	var _val_shatter_damage = _ct_frostbite_stacks * 3;

	//================//
	//DEBUG TRIGGER//
	//================//
	scr_debug_log_battle_trigger(
		"SHATTER",
		global.ref_caster_beast,
		_ref_target,
		"FROSTBITE CONSUMED: " + string(_ct_frostbite_stacks) +
		" | BASE NEU DAMAGE: " + string(_val_shatter_damage),
		"SCR_BATTLE_TRIGGER_SHATTER"
	);

	//--------------------//
	//GET CAST CARD STATE//
	//--------------------//
	var _stct_cast_card = global.ref_cast_card._ref_card;
	var _str_original_stat = _stct_cast_card._str_card_stat;

	//----------------//
	//SET NEU DAMAGE//
	//----------------//
	_stct_cast_card._str_card_stat = "NEU";

	scr_battle_damage_target(
		_val_shatter_damage,
		_ref_target
	);

	//-----------------//
	//RESTORE CARD STAT//
	//-----------------//
	_stct_cast_card._str_card_stat = _str_original_stat;

	#endregion

	return _ct_frostbite_stacks;
}