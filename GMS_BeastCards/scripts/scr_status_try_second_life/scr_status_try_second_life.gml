//===============================================================================//
//
// SCRIPT: SCR_STATUS_TRY_SECOND_LIFE
// FUNCTION: Checks whether a defeated Beast has Second Life.
//           Triggers Second Life when available.
//           Returns whether normal death handling should be cancelled.
//
//===============================================================================//

function scr_status_try_second_life(_ref_beast){

	//----------------//
	//VALIDATE BEAST//
	//----------------//
	if (!instance_exists(_ref_beast)){
		return false;
	}

	//===================//
	//CHECK SECOND LIFE//
	//===================//
	var _ref_second_life = scr_status_check("SECOND_LIFE",_ref_beast);

	if (_ref_second_life == -1){
		return false;
	}

	if (!instance_exists(_ref_second_life)){
		return false;
	}

	//=====================//
	//TRIGGER SECOND LIFE//
	//=====================//
	return scr_status_buff_second_life(
		"TRIGGER",
		_ref_second_life,
		undefined
	);
}