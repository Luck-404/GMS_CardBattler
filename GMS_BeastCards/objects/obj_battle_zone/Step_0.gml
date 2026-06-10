//===============================================================================//
//
// STEP: OBJ_BATTLE_ZONE
// FUNCTION:	Rolls for random encounters while the player is in the zone
//				Handles battle transitions and encounter state setup
//				Generates grass and plant litter movement effects during traversal
//
//===============================================================================//

if (place_meeting(x,y,obj_player) && obj_player._flag_player_moving  == true){ //IF TOUCHING PLAYER AND PLAYER IS MOVING

#region BATTLE ATTEMPT AND TRIGGER	
	//—------------------------------------------------------------------------------//
	// BATTLE ATTEMPT AND TRIGGER | Attempts to trigger an encounter off cooldown, 
	//								also prevents immediate re-battle after an 
	//								encounter is over.. via obj_wait.
	//—------------------------------------------------------------------------------//
	if (_encounter_attempt_cooldown <= 0 && !instance_exists(obj_wait)){ 
		
		//ROLL FOR ENCOUNTER
		var _random_number = irandom_range(0,100);
		if (_random_number < _encouter_chance){ //TRIGGER A BATTLE	
			//POPUP
			scr_spawn_popup("TEXT","BATTLE TRIGGERED",undefined,c_black,obj_player.x,obj_player.y);
			
			//STORE PLAYER POSITION
			global.last_player_x = obj_player.x;
			global.last_player_y = obj_player.y;
			global.last_player_rm = room;
			global.last_enemy_pool = _encounter_list;
			
			//STOP PLAYER MOVEMENT
			scr_toggle_player_movement("STOP");
			
			//HIDE PLAYER
			obj_player.visible = false;			
			
			//SPAWN NEW TRANSITION
			scr_trigger_transition(rm_battle);
		}
		
		//WAIT HALF A SECOND BEFORE TRYING AGAIN
		_encounter_attempt_cooldown = 30;
	} else {
		_encounter_attempt_cooldown--;
	}
#endregion
	
#region PLANT LITTER SCENE FX
	//—------------------------------------------------------------------------------//
	// PLANT LITTER SCENE FX | Spawn plant litter every so often walking in tall grass.
	//—------------------------------------------------------------------------------//
	if (_scene_fx_litter_timer <= 0){
		_scene_fx_litter_timer = 20;	
		scr_trigger_scene_fx_plant_litter();
	} else {
		_scene_fx_litter_timer--;
	}
#endregion

}