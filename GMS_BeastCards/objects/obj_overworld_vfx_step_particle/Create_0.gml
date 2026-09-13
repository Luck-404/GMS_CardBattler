//===============================================================================//
//
// CREATE: OBJ_OVERWORLD_VFX_STEP_PARTICLE
// FUNCTION: Initializes a short-lived footstep particle.
//           Detects the terrain beneath the player.
//           Assigns an appropriate terrain-based particle color.
//
//===============================================================================//

//================//
//VARIABLES//
//================//

//----------------//
//MOVEMENT//
//----------------//
direction = irandom(359);
speed = 1;

//----------------//
//LIFETIME//
//----------------//
_ct_lifetime = 5;

//----------------//
//VISUALS//
//----------------//
_c_color = c_white;

//----------------//
//REFERENCES//
//----------------//
_ref_owner = undefined;

_val_path_tilemap = -1;
_val_tile_data = 0;
_val_tile_index = 0;

//================//
//INIT//
//================//

//----------------//
//GET OWNER//
//----------------//
if (instance_exists(obj_player)){
	_ref_owner = instance_find(obj_player,0);
}

//----------------//
//GET TERRAIN//
//----------------//
if (_ref_owner != undefined){

	_val_path_tilemap = layer_tilemap_get_id("tly_paths");

	if (_val_path_tilemap != -1){

		_val_tile_data = tilemap_get_at_pixel(
			_val_path_tilemap,
			_ref_owner.x,
			_ref_owner.y
		);

		_val_tile_index = tile_get_index(_val_tile_data);
	}
}

//----------------//
//SET TERRAIN COLOR//
//----------------//
switch (_val_tile_index){

	case 2:
		_c_color = make_colour_rgb(102,82,53);
	break;

	case 3:
		_c_color = make_colour_rgb(102,102,102);
	break;

	case 7:
		_c_color = make_colour_rgb(204,163,108);
	break;

	default:
		_c_color = make_colour_rgb(82,127,78);
	break;
}

//================//
//METHODS//
//================//