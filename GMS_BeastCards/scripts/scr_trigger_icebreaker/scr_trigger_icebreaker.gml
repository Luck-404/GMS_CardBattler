//===============================================================================//
//
// SCRIPT: scr_trigger_icebreaker
// FUNCTION: Resolves the Cerulean ICEBREAKER trigger.
//           Actual Frozen is consumed.
//           Frostform also counts as Frozen but is not consumed.
//           Returns 2 when triggered, otherwise 1.
//
//===============================================================================//

function scr_trigger_icebreaker(_ref_target){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return 1;
	}

	//----------------------//
	//CHECK FROZEN STATES//
	//----------------------//
	var _ref_frozen =
		scr_status_check(
			"FROZEN",
			_ref_target
		);

	var _ref_frostform =
		scr_status_check(
			"FROSTFORM",
			_ref_target
		);

	if (
		_ref_frozen == -1 &&
		_ref_frostform == -1
	){
		return 1;
	}

	//--------------------------//
	//STORE ICEBREAKER CONDITION//
	//--------------------------//
	global.ref_icebreaker_target =
		_ref_target;

	//------------------//
	//ICEBREAKER VFX/SFX//
	//------------------//
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
	scr_spawn_popup_scrolling(
		"TEXT",
		"ICEBREAKER",
		undefined,
		c_aqua,
		_ref_target.x,
		_ref_target.y - 48
	);

	//----------------------//
	//CONSUME ACTUAL FROZEN//
	//----------------------//
	if (_ref_frozen != -1){

		scr_status_cc_frozen(
			"DEATH",
			_ref_frozen
		);
	}

	return 2;
}