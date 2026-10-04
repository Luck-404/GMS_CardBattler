//===============================================================================//
//
// ROOM START: OBJ_MATERIAL_SPAWNER
// FUNCTION: Rolls once when the room begins.
//           Has a configurable chance to create one Material node at a valid
//           random position within the configured radius.
//
//           Existing uncollected nodes prevent duplicate spawning.
//
//===============================================================================//

//====================//
//NORMALIZE NODE TYPE//
//====================//
_str_material_node_type =
	string_upper(
		string(
			_str_material_node_type
		)
	);

//================//
//EXISTING NODE//
//================//
if (
	instance_exists(
		_ref_spawned_node
	)
){
	exit;
}

//================//
//VALIDATE TYPE//
//================//
var _spr_node =
	scr_material_get_node_sprite(
		_str_material_node_type
	);

if (_spr_node == undefined){

	scr_debug_log(
		"OVERWORLD",
		"MATERIAL_SPAWNER",
		self,
		"MATERIAL NODE SPAWN FAILED" +
		" | TYPE: " +
		_str_material_node_type +
		" | REASON: INVALID NODE TYPE" +
		" | ROOM: " +
		room_get_name(room),
		"WARNING",
		"OBJ_MATERIAL_SPAWNER:ROOM_START"
	);

	exit;
}

//================//
//SPAWN CHANCE//
//================//
var _val_spawn_roll =
	random(100);

if (
	_val_spawn_roll >=
	clamp(
		_val_spawn_chance,
		0,
		100
	)
){

	scr_debug_log(
		"OVERWORLD",
		"MATERIAL_SPAWNER",
		self,
		"MATERIAL NODE NOT SPAWNED" +
		" | TYPE: " +
		_str_material_node_type +
		" | ROLL: " +
		string_format(
			_val_spawn_roll,
			0,
			1
		) +
		" | CHANCE: " +
		string(
			_val_spawn_chance
		) +
		"%" +
		" | ROOM: " +
		room_get_name(room),
		"INFO",
		"OBJ_MATERIAL_SPAWNER:ROOM_START"
	);

	exit;
}

//================//
//FIND SPAWN POINT//
//================//
var _flag_position_found =
	false;

var _val_spawn_x =
	x;

var _val_spawn_y =
	y;

for (
	var _it_attempt = 0;
	_it_attempt <
		_ct_spawn_attempts;
	_it_attempt++
){

	//----------------------//
	//RANDOM POINT IN CIRCLE//
	//----------------------//
	var _val_angle =
		random(360);

	/*
		SQRT keeps the points distributed across the full circle
		instead of clustering heavily around the center.
	*/
	var _val_distance =
		sqrt(
			random(1)
		) *
		max(
			0,
			_val_spawn_radius
		);

	var _val_try_x =
		x +
		lengthdir_x(
			_val_distance,
			_val_angle
		);

	var _val_try_y =
		y +
		lengthdir_y(
			_val_distance,
			_val_angle
		);

	//--------------//
	//ROOM BOUNDARY//
	//--------------//
	if (
		_val_try_x < 0 ||
		_val_try_x > room_width ||
		_val_try_y < 0 ||
		_val_try_y > room_height
	){
		continue;
	}

	//-------------//
	//WALL SAFETY//
	//-------------//
	if (
		position_meeting(
			_val_try_x,
			_val_try_y,
			obj_overworld_wall
		)
	){
		continue;
	}

	//----------------//
	//PLAYER DISTANCE//
	//----------------//
	if (
		instance_exists(
			obj_player
		) &&
		point_distance(
			_val_try_x,
			_val_try_y,
			obj_player.x,
			obj_player.y
		) <
		48
	){
		continue;
	}

	//--------------------//
	//OTHER MATERIAL NODE//
	//--------------------//
	if (
		position_meeting(
			_val_try_x,
			_val_try_y,
			obj_material_node
		)
	){
		continue;
	}

	//================//
	//VALID POSITION//
	//================//
	_val_spawn_x =
		_val_try_x;

	_val_spawn_y =
		_val_try_y;

	_flag_position_found =
		true;

	break;
}

//================//
//NO VALID POINT//
//================//
if (!_flag_position_found){

	scr_debug_log(
		"OVERWORLD",
		"MATERIAL_SPAWNER",
		self,
		"MATERIAL NODE SPAWN FAILED" +
		" | TYPE: " +
		_str_material_node_type +
		" | REASON: NO VALID POSITION" +
		" | ATTEMPTS: " +
		string(
			_ct_spawn_attempts
		) +
		" | ROOM: " +
		room_get_name(room),
		"WARNING",
		"OBJ_MATERIAL_SPAWNER:ROOM_START"
	);

	exit;
}

//================//
//CREATE NODE//
//================//
_ref_spawned_node =
	instance_create_layer(
		_val_spawn_x,
		_val_spawn_y,
		layer,
		obj_material_node
	);

//================//
//INITIALIZE NODE//
//================//
if (
	instance_exists(
		_ref_spawned_node
	)
){

	_ref_spawned_node
		._str_material_node_type =
			_str_material_node_type;

	_ref_spawned_node
		._ref_material_spawner =
			self;

	_ref_spawned_node
		.hscr_material_node_refresh();

	scr_debug_log(
		"OVERWORLD",
		"MATERIAL_SPAWNER",
		self,
		"MATERIAL NODE SPAWNED" +
		" | TYPE: " +
		_str_material_node_type +
		" | ROOM: " +
		room_get_name(room) +
		" | POSITION: (" +
		string(
			round(
				_val_spawn_x
			)
		) +
		"," +
		string(
			round(
				_val_spawn_y
			)
		) +
		")",
		"INFO",
		"OBJ_MATERIAL_SPAWNER:ROOM_START"
	);
}