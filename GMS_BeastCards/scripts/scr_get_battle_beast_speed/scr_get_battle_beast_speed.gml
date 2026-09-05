//===============================================================================//
//
// SCRIPT: SCR_GET_BATTLE_BEAST_SPEED
// FUNCTION: Returns a battle Beast's current Speed.
//           Combines base Speed with battle Speed bonuses.
//           Clamps the final value between 0 and 300.
//
//===============================================================================//

function scr_get_battle_beast_speed(_ref_beast){

	if (!instance_exists(_ref_beast)){
		return 0;
	}

	var _val_speed =
		_ref_beast._val_speed_base +
		_ref_beast._val_speed_bonus;

	return clamp(_val_speed,0,300);
}