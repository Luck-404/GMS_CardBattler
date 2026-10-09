//===============================================================================//
//
// SCRIPT: SCR_STATUS_GET_ENDLESS_BLOOM
// FUNCTION: Returns Endless Bloom from the supplied Team Status registry.
// RETURNS: Matching Status instance, or -1.
//
//===============================================================================//

function scr_status_get_endless_bloom(_str_team){

	var _str_team_upper = string_upper(string(_str_team));

	if (
		_str_team_upper != "PLAYER" &&
		_str_team_upper != "ENEMY"
	){
		return -1;
	}

	return scr_status_check(
		"ENDLESS_BLOOM",
		_str_team_upper
	);
}
