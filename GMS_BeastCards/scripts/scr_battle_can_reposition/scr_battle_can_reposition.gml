//===============================================================================//
//
// SCRIPT: SCR_BATTLE_CAN_REPOSITION
// FUNCTION: Returns whether a battle Beast may currently be repositioned.
//           Requires the Beast to be alive and free of all active
//           reposition-locking effects.
//
// INPUT:    _ref_beast - Battle Beast being checked for reposition eligibility.
// USES:     Beast life state and shared reposition-lock detection.
//
//===============================================================================//

function scr_battle_can_reposition(_ref_beast){

	#region VALIDATION

	//----------------//
	//VALIDATE BEAST//
	//----------------//
	if (!instance_exists(_ref_beast)){
		return false;
	}

	//-------------//
	//MUST BE ALIVE//
	//-------------//
	if (_ref_beast._str_list != "ALIVE" || _ref_beast._val_cur_hp <= 0){
		return false;
	}

	#endregion

	#region REPOSITION LOCK

	//----------------------//
	//CHECK REPOSITION LOCK//
	//----------------------//
	if (scr_battle_has_reposition_lock(_ref_beast)){
		return false;
	}

	#endregion

	return true;
}