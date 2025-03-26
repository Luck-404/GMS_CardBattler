function scr_death_rearrangement(_creature,_team) {
    show_debug_message("Starting rearrangement");
    global.rearranging = true;


switch(_team){
	#region PLAYER
	case "Player":
		//update left and right references
		//left's right (was self) becomes self's right
		if (_left_unit != undefined){
			_left_unit._right_unit = _right_unit;
		} else {
			_left_unit._right_unit = undefined;
		}
		
		if (_right_unit != undefined){
			_right_unit._left_unit = _left_unit;
		} else {
			_right_unit._left_unit = undefined;
		}
		
		//update lists
		ds_list_delete(global.player_party_in_play, _creature_position);
		ds_list_add(global.player_party_dead,self);	
		
		//update lists
		//update alive positions of creatures
		for (var _i = 0; _i < ds_list_size(global.player_party_in_play); _i++){
			var _unit = ds_list_find_value(global.player_party_in_play,_i);
			_unit._creature_position = _i;
			//update visual positions
			var _found_x = scr_find_new_creature_x("Player",_i);
			_unit.x = _found_x;
		}		
		//update dead positions of creatures
		for (var _i = 0; _i < ds_list_size(global.player_party_dead); _i++){
			var _unit = ds_list_find_value(global.player_party_dead,_i);
			_unit._creature_position = _i;
			//update visual positions
			var _found_x = scr_find_new_creature_x("Player", ds_list_size(global.enemy_party_in_play)+_i);
			_unit.x = _found_x;
		}	
	break;
	#endregion


	#region Enemy
	case "Enemy":
		
		//update left and right references
		if (_left_unit != undefined){
			_left_unit._right_unit = _right_unit;
		} else {
			_left_unit._right_unit = undefined;
		}
		
		if (_right_unit != undefined){
			_right_unit._left_unit = _left_unit;
		} else {
			_right_unit._left_unit = undefined;
		}
		
		if (_card_to_play != undefined){
			instance_destroy(_card_to_play);	
		}
		
		ds_list_delete(global.enemy_party_in_play,_creature_position);
		ds_list_add(global.enemy_party_dead,self);		
		
		//update lists
		//update alive positions of creatures
		for (var _i = 0; _i < ds_list_size(global.enemy_party_in_play); _i++){
			var _unit = ds_list_find_value(global.enemy_party_in_play,_i);
			_unit._creature_position = _i;
			//update visual positions
			var _found_x = scr_find_new_creature_x("Enemy",_i);
			_unit.x = _found_x;
		}		
		//update dead positions of creatures
		for (var _i = 0; _i < ds_list_size(global.enemy_party_dead); _i++){
			var _unit = ds_list_find_value(global.enemy_party_dead,_i);
			_unit._creature_position = _i;
			//update visual positions
			var _found_x = scr_find_new_creature_x("Enemy", ds_list_size(global.enemy_party_in_play)+_i);
			_unit.x = _found_x;
		}	
	break;
	#endregion
}


    global.rearranging = false;
    show_debug_message("Ending rearrangement");
}