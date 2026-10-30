//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_SELECT_RANDOM_ROOM
// FUNCTION: Selects one random V1-eligible World Event target room.
//           The battle-source room is intentionally allowed.
//
// RETURNS: Eligible room asset or undefined.
//
//===============================================================================//

function scr_world_event_select_random_room(){

	var _ref_controller =
		scr_world_event_get_controller();

	if (!instance_exists(_ref_controller)){
		return undefined;
	}

	var _arr_rooms =
		_ref_controller
			._arr_eligible_rooms;

	if (
		!is_array(
			_arr_rooms
		) ||
		array_length(
			_arr_rooms
		) <=
		0
	){
		return undefined;
	}

	var _arr_valid_rooms = [];

	for (
		var _it_room = 0;
		_it_room <
			array_length(
				_arr_rooms
			);
		_it_room++
	){

		var _rm_candidate =
			_arr_rooms[
				_it_room
			];

		if (
			scr_world_event_is_room_eligible(
				_rm_candidate
			)
		){
			array_push(
				_arr_valid_rooms,
				_rm_candidate
			);
		}
	}

	if (
		array_length(
			_arr_valid_rooms
		) <=
		0
	){
		return undefined;
	}

	return _arr_valid_rooms[
		irandom(
			array_length(
				_arr_valid_rooms
			) -
			1
		)
	];
}
