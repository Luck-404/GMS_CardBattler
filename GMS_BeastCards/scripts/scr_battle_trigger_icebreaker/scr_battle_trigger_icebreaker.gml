//===============================================================================//
//
// SCRIPT: SCR_BATTLE_TRIGGER_ICEBREAKER
// FUNCTION: Resolves the Cerulean ICEBREAKER mechanic.
//           Actual Frozen is consumed, while Frostform counts as Frozen
//           without being consumed. Returns 2 when triggered, otherwise 1.
//
// INPUT:    _ref_target - Beast being checked for an ICEBREAKER condition.
// USES:     Frozen and Frostform status lookup, Frozen status removal,
//           battle VFX, popup feedback, ICEBREAKER target context,
//           and battle-trigger debug logging.
//
//===============================================================================//

function scr_battle_trigger_icebreaker(_ref_target){

	#region VALIDATION

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return 1;
	}

	#endregion

	#region FROZEN STATE

	//-------------------//
	//CHECK FROZEN STATE//
	//-------------------//
	var _ref_frozen = scr_status_check("FROZEN",_ref_target);
	var _ref_frostform = scr_status_check("FROSTFORM",_ref_target);

	if (_ref_frozen == -1 && _ref_frostform == -1){
		return 1;
	}

	//--------------------------//
	//STORE ICEBREAKER CONDITION//
	//--------------------------//
	global.ref_icebreaker_target = _ref_target;

	#endregion

	#region FEEDBACK

	//--------------------//
	//ICEBREAKER VFX / SFX//
	//--------------------//
	scr_battle_vfx(
		_ref_target,
		spr_battle_vfx_icebreaker,
		undefined,
		undefined,
		0,
		0,
		1,
		0,
		snd_battle_icebreaker
	);

	//------------------//
	//ICEBREAKER POPUP//
	//------------------//
	scr_gui_spawn_popup_scrolling(
		"TEXT",
		"ICEBREAKER",
		undefined,
		c_aqua,
		_ref_target.x,
		_ref_target.y - 48
	);

	#endregion

	#region CONSUME FROZEN

	//-----------------------------//
	//GET ICEBREAKER FROZEN RESULT//
	//-----------------------------//
	var _str_frozen_result = "FROSTFORM";

	//----------------------//
	//CONSUME ACTUAL FROZEN//
	//----------------------//
	if (_ref_frozen != -1){

		_str_frozen_result = "FROZEN CONSUMED";

		scr_status_cc_frozen(
			"DEATH",
			_ref_frozen
		);
	}

	#endregion

	#region DEBUG TRIGGER

	//------------------//
	//LOG ICEBREAKER//
	//------------------//
	scr_debug_log_battle_trigger(
		"ICEBREAKER",
		global.ref_caster_beast,
		_ref_target,
		_str_frozen_result +
		" | DIRECT DAMAGE: 2X",
		"SCR_BATTLE_TRIGGER_ICEBREAKER"
	);

	#endregion

	return 2;
}