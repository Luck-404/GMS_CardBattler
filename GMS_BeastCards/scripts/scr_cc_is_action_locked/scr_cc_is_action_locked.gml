//===============================================================================//
//
// SCRIPT: scr_cc_is_action_locked
// FUNCTION: Returns whether a Beast is prevented from performing actions.
//           Stun, Sleep, and Frozen are action-locking Crowd Control.
//           Other CC types retain their distinct restrictions.
//
//===============================================================================//
function scr_cc_is_action_locked(_ref_beast){

	if (!instance_exists(_ref_beast)){
		return true;
	}

	//------//
	//STUN//
	//------//
	if (
		scr_status_check(
			"STUN",
			_ref_beast
		) != -1
	){
		return true;
	}

	//------//
	//SLEEP//
	//------//
	if (
		scr_status_check(
			"SLEEP",
			_ref_beast
		) != -1
	){
		return true;
	}

	//--------//
	//FROZEN//
	//--------//
	if (
		scr_status_check(
			"FROZEN",
			_ref_beast
		) != -1
	){
		return true;
	}

	return false;
}