//===============================================================================//
//
// SCRIPT: SCR_IS_BEAST_ACTION_LOCKED
// FUNCTION: Returns whether a Beast is prevented from performing actions.
//           Stun, Sleep, and Frozen are action-locking Crowd Control.
//           Other CC types retain their distinct restrictions.
//
//===============================================================================//
function scr_is_beast_action_locked(_ref_beast){

	if (!instance_exists(_ref_beast)){
		return true;
	}

	//------//
	//STUN//
	//------//
	if (
		scr_check_for_status(
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
		scr_check_for_status(
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
		scr_check_for_status(
			"FROZEN",
			_ref_beast
		) != -1
	){
		return true;
	}

	return false;
}