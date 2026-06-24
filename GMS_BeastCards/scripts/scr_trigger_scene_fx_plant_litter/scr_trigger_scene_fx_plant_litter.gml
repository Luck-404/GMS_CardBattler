//===============================================================================//
//
// SCRIPT: SCR_TRIGGER_SCENE_FX_PLANT_LITTER
// FUNCTION: Spawns a small burst of drifting plant litter.
//           Creates several randomized litter particles
//           around the player for ambient scene effects.
//
//===============================================================================//
function scr_trigger_scene_fx_plant_litter(){
	//TRIGGER A FEW LEAVES
	var _val_random_leaves = irandom_range(2,4);
	//SPAWN THE LEAVES
	for (var _it_leaf = 0; _it_leaf < _val_random_leaves; _it_leaf++){
		var _ref_leaf = instance_create_layer(obj_player.x,obj_player.y-8,"ily_fx",obj_scene_fx_plant_litter);	
	}
}