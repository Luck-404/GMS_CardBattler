//===============================================================================//
//
// SCRIPT: SCR_BATTLE_GET_BEAST_SPEED
// FUNCTION: Returns a battle Beast's current Speed.
//           Combines base Speed with battle Speed bonuses and clamps
//           the final value between 0 and 300.
//
// INPUT:    _ref_beast - Battle Beast whose current Speed is being calculated.
//
//===============================================================================//

function scr_battle_get_beast_speed(_ref_beast){

	//----------------//
	//VALIDATE BEAST//
	//----------------//
	if (!instance_exists(_ref_beast)){
		return 0;
	}

	//----------------//
	//CALCULATE SPEED//
	//----------------//
	var _val_speed =
		_ref_beast._val_speed_base +
		_ref_beast._val_speed_bonus;

	return clamp(_val_speed,0,300);
}