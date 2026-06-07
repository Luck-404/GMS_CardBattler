//
//
// STEP: OBJ_BATTLE_ZONE | THE BATTLE ZONE CHECKS FOR PLAYER INTERACTION TO SEND TO AN ENCOUNTER
//
//

//IF TOUCHING PLAYER...
if (place_meeting(x,y,obj_player) && obj_player._flag_moving == true){
//
// BATTLE ATTEMPT AND TRIGGER | 10% CHANCE TO TRIGGER AN ENCOUNTER
//
#region BATTLE ATTEMPT AND TRIGGER
	//IF COOLDOWN IS 0, TRIGGER AN ATTEMPT AT GOING TO BATTLE
	if (_encounter_attempt_cooldown <= 0 && !instance_exists(obj_waiter)){
		randomize();
		var _random_number = irandom_range(0,100);
		if (_random_number < _chance){
			//TRIGGER A BATTLE	
			scr_spawn_popup("TEXT","BATTLE TRIGGERED",undefined,c_black,obj_player.x,obj_player.y);
			
			//STORE PLAYER POSITION
			global.last_player_x = obj_player.x;
			global.last_player_y = obj_player.y;
			global.last_player_rm = room;
			global.last_enemy_pool = _encounter_list;
			
			//STOP PLAYER MOVEMENT
			obj_player._player_speed = 0;
			obj_player._flag_moving = false;	
			obj_player._flag_sprinting = false;
			
			//HIDE PLAYER
			obj_player.visible = false;			
			
			//SPAWN NEW TRANSITION
			var _transition = instance_create_layer(room_width/2,room_height/2,"ily_fx",obj_transition);
			_transition._destination = rm_battle;
		}
		_encounter_attempt_cooldown = 30;
	} else {
		_encounter_attempt_cooldown--;
	}
#endregion
	
	
//
// LEAF SCENE FX | SPAWN LEAVES EVERY SO OFTEN WHEN WALKING IN TALL GRASS
//
#region LEAF SCENE FX
	//TRIGGER A LEAF EVERY SO OFTEN
	if (_grass_timer <= 0 && obj_player._flag_moving == true){
			_grass_timer = 15;	
		//TRIGGER A FEW LEAVES
		randomize();
		var _random_leaves = irandom_range(3,7);
		//SPAWN THE LEAVES
		for (var _i = 0; _i < _random_leaves; _i++){
			var _leaf = instance_create_layer(obj_player.x,obj_player.y-8,"ily_fx",obj_scene_fx_leaf);	
		}
	} else {
		_grass_timer--;
	}
#endregion
}