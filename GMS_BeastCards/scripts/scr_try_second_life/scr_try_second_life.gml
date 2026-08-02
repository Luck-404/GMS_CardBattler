//===============================================================================//
//
// SCRIPT: SCR_TRY_SECOND_LIFE
// FUNCTION: Checks whether a defeated Beast has Second Life.
//           Consumes Second Life and restores HP when available.
//           Returns whether normal death handling should be cancelled.
//
//===============================================================================//

function scr_try_second_life(_ref_beast){

	if (!instance_exists(_ref_beast)){
		return false;
	}

	var _ref_second_life =
		scr_check_for_status(
			"SECOND_LIFE",
			_ref_beast
		);

	if (_ref_second_life == -1){
		return false;
	}

	return scr_status_buff_second_life(
		"TRIGGER",
		_ref_second_life,
		undefined
	);
}