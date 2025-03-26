function scr_death_rearrangement(_creature,_team) {
    show_debug_message("Starting rearrangement");
    global.rearranging = true;
var _pos = 1;

switch(_team){
	#region PLAYER
	case "Player":
		var _left = _creature._left_unit;
		var _right = _creature._right_unit;
		
		//update left and right references
		if (_left != undefined){
			_left._right_unit = _right;	
		} else if (_right != undefined){
			_right._left_unit = undefined;
		}
		
		if (_right != undefined){
			_right._left_unit = _left;	
		} else if (_left != undefined){
			_left._right_unit = undefined;
		}
		
		//update lists
		ds_list_delete(global.player_party_in_play,_creature._creature_position);
		ds_list_add(global.player_party_dead,self);	
		
		//update lists
		//update alive positions of creatures
		for (var _i = 0; _i < ds_list_size(global.player_party_in_play); _i++){
			var _unit = ds_list_find_value(global.player_party_in_play,_i);
			_unit._creature_position = _i;
			//update visual positions
			var _found_x = scr_find_new_creature_x("Player",_pos);
			_unit.x = _found_x;			
			show_debug_message("Player in play " + _unit._creature_name + " at pos "+ string(_pos)+" moving to x" + string(_found_x) + " ... new x:" +string(_unit.x));				
			_pos++;			
		}		
		//update dead positions of creatures
		for (var _i = 0; _i < ds_list_size(global.player_party_dead); _i++){
			var _unit = ds_list_find_value(global.player_party_dead,_i);
			_unit._creature_position = _i;
			_unit._creature_list = global.player_party_dead;				
			//update visual positions
			var _found_x = scr_find_new_creature_x("Player", _pos);
			_unit.x = _found_x;			
			show_debug_message("Player dead " + _unit._creature_name + " at pos "+ string(_pos)+" moving to x" + string(_found_x) + " ... new x:" +string(_unit.x));					
			_pos++;				
		}	
	break;
	#endregion

	#region Enemy
	case "Enemy":
		_left = _creature._left_unit;
		_right = _creature._right_unit;
		
		//update left and right references
		if (_left != undefined){
			_left._right_unit = _right;	
		} else if (_right != undefined){
			_right._left_unit = undefined;
		}
		
		if (_right != undefined){
			_right._left_unit = _left;	
		} else if (_left != undefined){
			_left._right_unit = undefined;
		}
		
		if (_creature._card_to_play != undefined){
			instance_destroy(_creature._card_to_play);	
		}
		
		ds_list_delete(global.enemy_party_in_play,_creature._creature_position);
		ds_list_add(global.enemy_party_dead,self);		
		
		//update lists
		//update alive positions of creatures
		for (var _i = 0; _i < ds_list_size(global.enemy_party_in_play); _i++){
			var _unit = ds_list_find_value(global.enemy_party_in_play,_i);
			_unit._creature_position = _i;
			//update visual positions
			var _found_x = scr_find_new_creature_x("Enemy",_pos);
			_unit.x = _found_x;
			show_debug_message("Enemy in play " + _unit._creature_name + " at pos "+ string(_pos)+" moving to x" + string(_found_x) + " ... new x:" +string(_unit.x));				
			_pos++;				
		}		
		//update dead positions of creatures
		for (var _i = 0; _i < ds_list_size(global.enemy_party_dead); _i++){
			var _unit = ds_list_find_value(global.enemy_party_dead,_i);
			_unit._creature_position = _i;
			_unit._creature_list = global.enemy_party_dead;					
			//update visual positions
			var _found_x = scr_find_new_creature_x("Enemy", _pos);
			_unit.x = _found_x;
			show_debug_message("Enemy dead " + _unit._creature_name + " at pos "+ string(_pos)+" moving to x" + string(_found_x) + " ... new x:" +string(_unit.x));			
			_pos++;
		}	
	break;
	#endregion
}


    global.rearranging = false;
    show_debug_message("Ending rearrangement");
}