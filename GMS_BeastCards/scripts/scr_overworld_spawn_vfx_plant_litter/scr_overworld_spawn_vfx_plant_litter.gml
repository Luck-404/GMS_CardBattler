//===============================================================================//
//
// SCRIPT: SCR_OVERWORLD_SPAWN_VFX_PLANT_LITTER
// FUNCTION: Spawns a small burst of drifting plant/brush litter.
//           Existing no-argument calls remain player-centered.
//           Optional source coordinates let moving Beasts emit the same scene VFX.
//           When _flag_require_brush is true, the source tile must be vegetation
//           rather than the known dirt/stone/sand path tile indices.
//
// ARGUMENTS:
//     _val_source_x       - Optional world X. Undefined uses OBJ_PLAYER.x.
//     _val_source_y       - Optional world Y. Undefined uses OBJ_PLAYER.y.
//     _flag_require_brush - If true, emit only on vegetation/brush terrain.
//
// RETURNS: True when litter is spawned; otherwise false.
//
//===============================================================================//

function scr_overworld_spawn_vfx_plant_litter(
	_val_source_x=undefined,
	_val_source_y=undefined,
	_flag_require_brush=false
){

	//================//
//RESOLVE SOURCE//
//================//
	if (
		_val_source_x == undefined ||
		_val_source_y == undefined
	){
		if (!instance_exists(obj_player)){
			return false;
		}

		_val_source_x = obj_player.x;
		_val_source_y = obj_player.y;
	}

	//====================//
	//OPTIONAL BRUSH CHECK//
	//====================//
	if (_flag_require_brush){

		var _val_path_tilemap =
			layer_tilemap_get_id(
				"tly_paths"
			);

		if (_val_path_tilemap != -1){

			var _val_tile_data =
				tilemap_get_at_pixel(
					_val_path_tilemap,
					_val_source_x,
					_val_source_y
				);

			var _val_tile_index =
				tile_get_index(
					_val_tile_data
				);

			// Known non-brush path materials used by the step-particle system.
			if (
				_val_tile_index == 2 ||
				_val_tile_index == 3 ||
				_val_tile_index == 7
			){
				return false;
			}
		}
	}

	//================//
	//ROLL LITTER COUNT//
	//================//
	var _ct_leaves = irandom_range(2,4);

	//================//
	//SPAWN LITTER//
	//================//
	for (var _it_leaf = 0; _it_leaf < _ct_leaves; _it_leaf++){

		instance_create_layer(
			_val_source_x,
			_val_source_y - 8,
			"ily_fx",
			obj_overworld_vfx_plant_litter
		);
	}

	return true;
}
