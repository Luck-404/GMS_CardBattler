//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_GET_ROOM_INFO
// FUNCTION: Returns World Event metadata for the currently defined overworld
//           rooms. Ranch and Market are deliberately registered but ineligible.
//
// ARGUMENTS: _rm_room - Room asset to inspect.
// RETURNS: Room metadata struct or undefined.
//
//===============================================================================//

function scr_world_event_get_room_info(_rm_room){

	switch (_rm_room){

		case rm_ow_center:
			return {
				_rm_room : rm_ow_center,
				_str_room_id : "CENTER",
				_str_display_name : "CENTER",
				_str_banner : "CENTER ROOM",
				_flag_world_event_eligible : true
			};

		case rm_ow_northwest:
			return {
				_rm_room : rm_ow_northwest,
				_str_room_id : "NORTHWEST",
				_str_display_name : "NORTHWEST",
				_str_banner : "NORTHWEST ROOM",
				_flag_world_event_eligible : true
			};

		case rm_ow_north:
			return {
				_rm_room : rm_ow_north,
				_str_room_id : "NORTH",
				_str_display_name : "NORTH",
				_str_banner : "NORTH ROOM",
				_flag_world_event_eligible : true
			};

		case rm_ow_northeast:
			return {
				_rm_room : rm_ow_northeast,
				_str_room_id : "NORTHEAST",
				_str_display_name : "NORTHEAST",
				_str_banner : "NORTHEAST ROOM",
				_flag_world_event_eligible : true
			};

		case rm_ow_west:
			return {
				_rm_room : rm_ow_west,
				_str_room_id : "WEST",
				_str_display_name : "WEST",
				_str_banner : "WEST ROOM",
				_flag_world_event_eligible : true
			};

		case rm_ow_east:
			return {
				_rm_room : rm_ow_east,
				_str_room_id : "EAST",
				_str_display_name : "EAST",
				_str_banner : "EAST ROOM",
				_flag_world_event_eligible : true
			};

		case rm_ow_southwest:
			return {
				_rm_room : rm_ow_southwest,
				_str_room_id : "SOUTHWEST",
				_str_display_name : "SOUTHWEST",
				_str_banner : "SOUTHWEST ROOM",
				_flag_world_event_eligible : true
			};

		case rm_ow_south:
			return {
				_rm_room : rm_ow_south,
				_str_room_id : "SOUTH",
				_str_display_name : "SOUTH",
				_str_banner : "SOUTH ROOM",
				_flag_world_event_eligible : true
			};

		case rm_ow_southeast:
			return {
				_rm_room : rm_ow_southeast,
				_str_room_id : "SOUTHEAST",
				_str_display_name : "SOUTHEAST",
				_str_banner : "SOUTHEAST ROOM",
				_flag_world_event_eligible : true
			};

		case rm_ow_lakeside:
			return {
				_rm_room : rm_ow_lakeside,
				_str_room_id : "LAKESIDE",
				_str_display_name : "LAKESIDE",
				_str_banner : "LAKESIDE ROOM",
				_flag_world_event_eligible : true
			};

		case rm_ow_ranch:
			return {
				_rm_room : rm_ow_ranch,
				_str_room_id : "RANCH",
				_str_display_name : "RANCH",
				_str_banner : "RANCH ROOM",
				_flag_world_event_eligible : false
			};

		case rm_ow_market:
			return {
				_rm_room : rm_ow_market,
				_str_room_id : "MARKET",
				_str_display_name : "MARKET",
				_str_banner : "MARKET ROOM",
				_flag_world_event_eligible : false
			};
	}

	return undefined;
}
