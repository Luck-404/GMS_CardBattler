//===============================================================================//
//
// SCRIPT: SCR_OVERWORLD_SPAWN_VFX_PLANT_LITTER
// FUNCTION: Spawns a small burst of drifting plant litter.
//           Creates several randomized litter particles around the player.
//
// ARGUMENTS: None.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_overworld_spawn_vfx_plant_litter(){

	//================//
	//VALIDATE PLAYER//
	//================//
	if (!instance_exists(obj_player)){
		return;
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
			obj_player.x,
			obj_player.y - 8,
			"ily_fx",
			obj_overworld_vfx_plant_litter
		);
	}
}