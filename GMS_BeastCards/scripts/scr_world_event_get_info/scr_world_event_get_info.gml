//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_GET_INFO
// FUNCTION: Returns immutable V1 metadata for a World Event ID.
//
// ARGUMENTS: _str_event_id - World Event logical ID.
// RETURNS: Event metadata struct or undefined.
//
// NOTE: Phase I defines identity and spawn-category requirements only. Event
//       generation, activation, objectives, and rewards are implemented later.
//
//===============================================================================//

function scr_world_event_get_info(_str_event_id){

	_str_event_id =
		string_upper(
			string(
				_str_event_id
			)
		);

	switch (_str_event_id){

		case "MIGRATION":
			return {
				_str_event_id : "MIGRATION",
				_str_display_name : "MIGRATION",
				_str_spawn_category : "MOB"
			};

		case "CHOOSE_A_CHEST":
			return {
				_str_event_id : "CHOOSE_A_CHEST",
				_str_display_name : "CHOOSE A CHEST",
				_str_spawn_category : "TREASURE"
			};

		case "RUNAWAY_TREASURE_BEAST":
			return {
				_str_event_id : "RUNAWAY_TREASURE_BEAST",
				_str_display_name : "RUNAWAY TREASURE BEAST",
				_str_spawn_category : "MOB"
			};

		case "WANDERING_MERCHANT":
			return {
				_str_event_id : "WANDERING_MERCHANT",
				_str_display_name : "WANDERING MERCHANT",
				_str_spawn_category : "MERCHANT"
			};

		case "ELITE_SIGHTING":
			return {
				_str_event_id : "ELITE_SIGHTING",
				_str_display_name : "ELITE SIGHTING",
				_str_spawn_category : "ELITE"
			};
	}

	return undefined;
}
