function scr_trigger_scene_fx_plant_litter(){
	//TRIGGER A FEW LEAVES
	var _random_leaves = irandom_range(2,4);
	//SPAWN THE LEAVES
	for (var _i = 0; _i < _random_leaves; _i++){
		var _leaf = instance_create_layer(obj_player.x,obj_player.y-8,"ily_fx",obj_scene_fx_plant_litter);	
	}
}