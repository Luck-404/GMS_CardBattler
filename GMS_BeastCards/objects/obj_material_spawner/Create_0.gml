//===============================================================================//
//
// CREATE: OBJ_MATERIAL_SPAWNER
// FUNCTION: Initializes an invisible wilderness Material-node generator.
//           Room-instance Variable Definitions determine the node category,
//           spawn chance, and spawn radius.
//
//===============================================================================//

#region VARIABLES

_ref_spawned_node =
	noone;

_ct_spawn_attempts =
	20;

#endregion

#region DEFAULT SAFETY

if (
	!variable_instance_exists(
		self,
		"_str_material_node_type"
	)
){

	_str_material_node_type =
		"HERBS";
}

if (
	!variable_instance_exists(
		self,
		"_val_spawn_chance"
	)
){

	_val_spawn_chance =
		20;
}

if (
	!variable_instance_exists(
		self,
		"_val_spawn_radius"
	)
){

	_val_spawn_radius =
		120;
}

#endregion

#region INIT

visible =
	false;

#endregion