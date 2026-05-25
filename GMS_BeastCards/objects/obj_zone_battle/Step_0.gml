//
//
// STEP: OBJ_ZONE_BATTLE
//
//

if (place_meeting(x,y,obj_player)){
	//IF COOLDOWN IS 0, TRIGGER AN ATTEMPT AT GOING TO BATTLE
	if (_encounter_attempt_cooldown <= 0){
		randomize();
		var _random_number = irandom_range(0,100);
		if (_random_number < 10){
			//TRIGGER A BATTLE	
			scr_create_popup("TEXT","BATTLE TRIGGERED",undefined,c_black,obj_player.x,obj_player.y);
		}
		_encounter_attempt_cooldown = 30;
	} else {
		_encounter_attempt_cooldown--;
	}
	
	
	
	//TRIGGER A LEAF EVERY SO OFTEN
	if (_grass_timer <= 0 && obj_player._flag_moving == true){
			_grass_timer = 15;	
		//TRIGGER A FEW LEAVES
		randomize();
		var _random_leaves = irandom_range(3,7);
		//SPAWN THE LEAVES
		for (var _i = 0; _i < _random_leaves; _i++){
			var _leaf = instance_create_layer(obj_player.x,obj_player.y-8,"ily_fx",obj_leaf);	
		}
	} else {
		_grass_timer--;
	}
}