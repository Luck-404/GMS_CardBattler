//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_SELECT_RANDOM_EVENT
// FUNCTION: Selects one equally weighted V1 World Event ID.
//
// RETURNS: World Event ID string or empty string.
//
//===============================================================================//

function scr_world_event_select_random_event(){

	var _arr_event_ids =
		scr_world_event_get_event_ids();

	if (
		!is_array(
			_arr_event_ids
		) ||
		array_length(
			_arr_event_ids
		) <=
		0
	){
		return "";
	}

	return _arr_event_ids[
		irandom(
			array_length(
				_arr_event_ids
			) -
			1
		)
	];
}
