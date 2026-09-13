//===============================================================================//
//
// SCRIPT: SCR_CC_IS_ACTION_LOCKED
// FUNCTION: Returns whether a Beast is prevented from performing actions.
//           Stun, Sleep, and Frozen are action-locking Crowd Control.
//           Beasts outside the active living formation cannot act.
//           Other CC types retain their distinct restrictions.
//
//===============================================================================//

function scr_cc_is_action_locked(_ref_beast){

	//----------------//
	//VALIDATE BEAST//
	//----------------//
	if (!instance_exists(_ref_beast)){
		return true;
	}

	if (
		_ref_beast._str_list != "ALIVE" ||
		_ref_beast._val_cur_hp <= 0
	){
		return true;
	}

	//========//
	//STUN//
	//========//
	var _ref_stun = scr_status_check("STUN",_ref_beast);

	if (
		_ref_stun != -1 &&
		instance_exists(_ref_stun)
	){
		return true;
	}

	//=========//
	//SLEEP//
	//=========//
	var _ref_sleep = scr_status_check("SLEEP",_ref_beast);

	if (
		_ref_sleep != -1 &&
		instance_exists(_ref_sleep)
	){
		return true;
	}

	//==========//
	//FROZEN//
	//==========//
	var _ref_frozen = scr_status_check("FROZEN",_ref_beast);

	if (
		_ref_frozen != -1 &&
		instance_exists(_ref_frozen)
	){
		return true;
	}

	return false;
}