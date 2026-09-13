//===============================================================================//
//
// SCRIPT: SCR_BATTLE_TRIGGER_POISONFLOW
// FUNCTION: Resolves the Viridian POISONFLOW mechanic.
//           Consumes the requested number of Poison stacks from a target,
//           or all available stacks when no amount is supplied.
//           Removes Poison when no stacks remain and returns stacks consumed.
//
// INPUTS:   _ref_target - Beast whose Poison stacks are being consumed.
//           _ct_poison_amount - Maximum Poison stacks to consume.
// USES:     Poison status lookup/removal, shared battle feedback,
//           and battle-trigger debug logging.
//
//===============================================================================//

function scr_battle_trigger_poisonflow(_ref_target,_ct_poison_amount=undefined){

	#region VALIDATION

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return 0;
	}

	//----------------//
	//CHECK FOR POISON//
	//----------------//
	var _ref_poison = scr_status_check("POISON",_ref_target);

	if (_ref_poison == -1){
		return 0;
	}

	#endregion

	#region POISONFLOW

	//---------------------//
	//GET AVAILABLE STACKS//
	//---------------------//
	var _ct_poison_available = _ref_poison._ct_status_stacks;

	if (_ct_poison_available <= 0){
		return 0;
	}

	//-------------------//
	//CALCULATE CONSUME//
	//-------------------//
	var _ct_poison_consumed = _ct_poison_available;

	if (_ct_poison_amount != undefined){
		_ct_poison_consumed = clamp(_ct_poison_amount,0,_ct_poison_available);
	}

	if (_ct_poison_consumed <= 0){
		return 0;
	}

	//------------------//
	//GET STACKS REMAINING//
	//------------------//
	var _ct_poison_remaining = max(
		0,
		_ct_poison_available -
		_ct_poison_consumed
	);

	//---------------//
	//CONSUME POISON//
	//---------------//
	_ref_poison._ct_status_stacks -= _ct_poison_consumed;

	if (_ref_poison._ct_status_stacks <= 0){
		scr_status_destroy(_ref_poison);
	}

	#endregion

	#region FEEDBACK

	//--------------------//
	//POISONFLOW VFX / SFX//
	//--------------------//
	scr_battle_vfx(
		_ref_target,
		spr_battle_vfx_poisonflow,
		undefined,
		undefined,
		0,
		0,
		1,
		0,
		snd_battle_poisonflow
	);

	//----------//
	//NOTIFIER//
	//----------//
	scr_gui_spawn_popup_scrolling(
		"TEXT",
		"POISONFLOW",
		undefined,
		c_lime,
		_ref_target.x,
		_ref_target.y - 48
	);

	#endregion

	#region DEBUG TRIGGER

	//------------------//
	//LOG POISONFLOW//
	//------------------//
	scr_debug_log_battle_trigger(
		"POISONFLOW",
		global.ref_caster_beast,
		_ref_target,
		"POISON CONSUMED: " + string(_ct_poison_consumed) +
		" | REMAINING: " + string(_ct_poison_remaining),
		"SCR_BATTLE_TRIGGER_POISONFLOW"
	);

	#endregion

	return _ct_poison_consumed;
}