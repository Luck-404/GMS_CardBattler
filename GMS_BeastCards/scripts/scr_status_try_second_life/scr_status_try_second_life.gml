//===============================================================================//
//
// SCRIPT: SCR_STATUS_TRY_SECOND_LIFE
// FUNCTION: Checks whether a defeated Beast has an active death-prevention Buff.
//           Last Stand takes priority over Second Life.
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

	//================//
	//TRY LAST STAND//
	//================//
	var _ref_last_stand = scr_status_check("LAST_STAND",_ref_beast);

	if (
		_ref_last_stand != -1 &&
		instance_exists(_ref_last_stand)
	){

		return scr_status_buff_last_stand(
			"TRIGGER",
			_ref_last_stand
		);
	}

	//===================//
	//TRY SECOND LIFE//
	//===================//
	var _ref_second_life = scr_status_check("SECOND_LIFE",_ref_beast);

	if (
		_ref_second_life == -1 ||
		!instance_exists(_ref_second_life)
	){
		return false;
	}

	return scr_status_buff_second_life(
		"TRIGGER",
		_ref_second_life,
		undefined
	);
}