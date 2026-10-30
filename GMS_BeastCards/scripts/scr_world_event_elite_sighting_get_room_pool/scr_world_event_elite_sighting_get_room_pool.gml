//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_ELITE_SIGHTING_GET_ROOM_POOL
// FUNCTION: Returns the unique valid Beast species available from encounter zones
//           in the current Elite Sighting target room.
//
// ARGUMENTS: _rm_room - Expected current room.
// RETURNS: Array of valid Beast ID strings.
//
//===============================================================================//

function scr_world_event_elite_sighting_get_room_pool(_rm_room=room){

	var _arr_pool = [];

	if (_rm_room != room){
		return _arr_pool;
	}

	var _ct_zones =
		instance_number(
			obj_overworld_encounter_zone
		);

	for (
		var _it_zone = 0;
		_it_zone < _ct_zones;
		_it_zone++
	){

		var _ref_zone =
			instance_find(
				obj_overworld_encounter_zone,
				_it_zone
			);

		if (!instance_exists(_ref_zone)){
			continue;
		}

		if (
			!variable_instance_exists(
				_ref_zone,
				"_arr_encounter_beasts"
			) ||
			!is_array(
				_ref_zone._arr_encounter_beasts
			)
		){
			continue;
		}

		for (
			var _it_beast = 0;
			_it_beast <
				array_length(
					_ref_zone._arr_encounter_beasts
				);
			_it_beast++
		){

			var _str_beast_name =
				string_upper(
					string(
						_ref_zone
							._arr_encounter_beasts[
								_it_beast
							]
					)
				);

			if (_str_beast_name == ""){
				continue;
			}

			if (
				!is_struct(
					scr_beast_get_info(
						_str_beast_name
					)
				)
			){
				continue;
			}

			if (
				!array_contains(
					_arr_pool,
					_str_beast_name
				)
			){
				array_push(
					_arr_pool,
					_str_beast_name
				);
			}
		}
	}

	return _arr_pool;
}
