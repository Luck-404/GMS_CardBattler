//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_ELITE_SIGHTING_GET_NEAREST_ZONE
// FUNCTION: Finds the nearest current-room encounter zone to an Elite Sighting
//           spawn position for ordinary encounter-pool and loot-zone metadata.
//
// ARGUMENTS: _val_x / _val_y - World position.
// RETURNS: Nearest encounter-zone instance or noone.
//
//===============================================================================//

function scr_world_event_elite_sighting_get_nearest_zone(_val_x,_val_y){

	var _ref_best = noone;
	var _val_best_distance = 1000000000;

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

		var _val_distance =
			point_distance(
				_val_x,
				_val_y,
				_ref_zone.x,
				_ref_zone.y
			);

		if (_val_distance < _val_best_distance){

			_val_best_distance =
				_val_distance;

			_ref_best =
				_ref_zone;
		}
	}

	return _ref_best;
}
