//===============================================================================//
//
// SCRIPT: SCR_STATUS_GET_HEART_OF_THE_FOREST
// FUNCTION: Returns Heart of the Forest from the supplied Team Status registry.
// RETURNS: Matching Status instance, or -1.
//
//===============================================================================//

function scr_status_get_heart_of_the_forest(_str_team){

	var _str_team_upper = string_upper(string(_str_team));

	if (
		_str_team_upper != "PLAYER" &&
		_str_team_upper != "ENEMY"
	){
		return -1;
	}

	return scr_status_check(
		"HEART_OF_THE_FOREST",
		_str_team_upper
	);
}
