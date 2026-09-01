//===============================================================================//
//
// SCRIPT: SCR_TRIGGER_ICEBREAKER
// FUNCTION: Resolves the Cerulean ICEBREAKER trigger.
//           If the target is Frozen, consumes Frozen and returns 2.
//           Otherwise returns 1.
//           The returned value multiplies the triggering card's direct damage.
//
//===============================================================================//

function scr_trigger_icebreaker(_ref_target){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return 1;
	}

	//-------------//
	//CHECK FROZEN//
	//-------------//
	var _ref_frozen = scr_check_for_status("FROZEN",_ref_target);

	if (_ref_frozen == -1){
		return 1;
	}

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

	//---------------//
	//CONSUME FROZEN//
	//---------------//
	scr_status_cc_frozen("DEATH",_ref_frozen);

	return 2;
}