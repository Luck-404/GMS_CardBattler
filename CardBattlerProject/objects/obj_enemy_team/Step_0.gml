////////////////////
// ENCOUNTER ROOM //
////////////////////
if (room == rm_encounter){
	//spawn enemy units ONCE	
	if (_flag_party_spawned == false){	
		for (var _i = 0; _i < ds_list_size(global.enemy_team); _i++){				
			//spawn the creature
			var _ref_creature = ds_list_find_value(global.enemy_team, _i);
			var _ref_creature_instance = instance_create_layer(1190+(170*_i), 650, "Creatures", obj_creature); //generate the creature	
			//pass the creature the proper stats it needs
			_ref_creature_instance._creature_name = _ref_creature[? "name"];
			_ref_creature_instance._creature_champion = _ref_creature[? "champion"];
			_ref_creature_instance._creature_color1 = _ref_creature[? "color1"];
			_ref_creature_instance._creature_color2 = _ref_creature[? "color2"];
			_ref_creature_instance._creature_subtype = _ref_creature[? "subtype"];
			_ref_creature_instance._creature_team = _ref_creature[? "team"];
			_ref_creature_instance._creature_breed = _ref_creature[? "breed"];
			_ref_creature_instance._creature_hp_max = _ref_creature[? "hp"];
			_ref_creature_instance._creature_hp_current = _ref_creature[? "hp"];
			_ref_creature_instance._creature_spec = _ref_creature[? "spec"];
			_ref_creature_instance._creature_class = _ref_creature[? "class"];
			_ref_creature_instance.sprite_index = _ref_creature[? "sprite"];
			_ref_creature_instance._creature_sprite = _ref_creature[? "sprite"];
			_ref_creature_instance._creature_hurtsound = _ref_creature[? "hurtsound"];
			_ref_creature_instance._creature_deathsound = _ref_creature[? "deathsound"];
			_ref_creature_instance._creature_defaultsound = _ref_creature[? "defaultsound"];
	ds_list_add(global.enemy_team_in_play, _ref_creature_instance);		
			_ref_creature_instance._creature_position = ds_list_find_index(global.enemy_team_in_play,_ref_creature_instance);			
		}
		_flag_party_spawned = true;					
	}
}