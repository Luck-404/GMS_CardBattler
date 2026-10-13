//===============================================================================//
//
// CREATE: OBJ_WORLD_EVENT_SPAWN_POINT
// FUNCTION: Establishes defaults for a manually placed safe World Event anchor.
//           Room-instance overrides are normalized during Room Start.
//
//           The object is invisible at runtime. Give it any convenient editor
//           sprite if a stronger Room Editor marker is desired.
//
//===============================================================================//

//================//
//LOGICAL ID//
//================//
if (!variable_instance_exists(id,"_str_spawn_id")){
	_str_spawn_id = "";
}

//================//
//SPAWN GEOMETRY//
//================//
if (!variable_instance_exists(id,"_ct_spawn_capacity")){
	_ct_spawn_capacity = 5;
}

if (!variable_instance_exists(id,"_val_spawn_radius")){
	_val_spawn_radius = 96;
}

if (!variable_instance_exists(id,"_val_mob_leash_radius")){
	_val_mob_leash_radius = 128;
}

//================//
//EVENT CATEGORIES//
//================//
if (!variable_instance_exists(id,"_flag_allow_mobs")){
	_flag_allow_mobs = true;
}

if (!variable_instance_exists(id,"_flag_allow_treasure")){
	_flag_allow_treasure = true;
}

if (!variable_instance_exists(id,"_flag_allow_merchant")){
	_flag_allow_merchant = true;
}

if (!variable_instance_exists(id,"_flag_allow_elite")){
	_flag_allow_elite = true;
}

//================//
//RUNTIME METADATA//
//================//
_rm_spawn_room =
	room;

_flag_spawn_id_auto =
	false;

_flag_world_event_spawn_point_valid =
	false;

//================//
//RUNTIME VISIBILITY//
//================//
visible =
	false;
