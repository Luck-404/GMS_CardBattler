//////////////////////////////////////////////////////////////////////
//					SCR_CARD_SPRIGS_OF_YGG_TICK						//
//																	//
// > SPAWN SPRIGGANS IN EMPTY SPOTS, INCREASE THE SPRIGGANS STACKS  //
//////////////////////////////////////////////////////////////////////
function scr_card_sprigs_of_ygg_tick(_target,_repeat){
	if (_repeat == false){
		
	} else {
	    var _list = undefined;
		if (_target != undefined && _target._creature_team == "Player"){
			//show_debug_message("SPAWNING PLAYER UNITS");
			_list = global.player_party_in_play;	
		} else {
			//show_debug_message("SPAWNING ENEMY UNITS");
			_list = global.enemy_party_in_play;	
		}		
		//////////////////
		// DO THE SPELL //
		//////////////////
		//for each unit on the target team
		for (var _i = 0; _i < ds_list_size(_list); _i++){
			var _unit = ds_list_find_value(_list,_i);
			//show_debug_message("unit " + _unit._creature_name + " found");
			var _minions = _unit._creature_minion_references;
			for (var _j = 0; _j < _unit._creature_minion_limit; _j++){
				//spawn as many minions as there are open spots in unit's places
				var _spot = ds_list_find_value(_minions,_j);
				if (_spot == undefined){ 
					//show_debug_message("making new minion in spot " + string(_j));
					//////////////////
					// SPAWN MINION //
					//////////////////
					var _ref_minion = instance_create_layer(_unit.x,_unit.y,"Creatures",obj_minion);
					_ref_minion._minion_hp_cur = 1;
					_ref_minion._minion_hp_max = 1;
					_ref_minion._minion_def = 0;
					_ref_minion._minion_name = "Spriggan";
					_ref_minion._minion_team = _unit._creature_team;
					_ref_minion._minion_cast_types = ["Minion Step","None","None"];
					_ref_minion._minion_sprite = spr_minion_spriggan;
					_ref_minion.sprite_index = _ref_minion._minion_sprite;
					_ref_minion._minion_hurtsound = snd_creature_wraith_hurt;
					_ref_minion._minion_deathsound = snd_creature_wraith_death;
					_ref_minion._minion_defaultsound = snd_creature_wraith_default;
					_ref_minion._minion_unit_attached = _unit;
					_ref_minion._minion_effect_script = scr_minion_spriggan_tick;
	
					///////////////////
					// ADD TO TARGET //
					///////////////////
					//check target's list
					if (_unit._creature_minion_count < _unit._creature_minion_limit){ //if open spot
						//if open spot- play normally
						ds_list_add(_unit._creature_minion_references,_ref_minion);
						_ref_minion._minion_position = _unit._creature_minion_count;
						_unit._creature_minion_count++;
	
		
					}
					else { //overwrite old
						//else overwrite oldest unit (delete oldest unit)
						var _removal_unit = ds_list_find_value(_unit._creature_minion_references,0);
						ds_list_delete(_unit._creature_minion_references,0);
						instance_destroy(_removal_unit);

						//add new to back of the list
						ds_list_add(_unit._creature_minion_references,_ref_minion);
						_ref_minion._minion_position = _unit._creature_minion_limit-1;
					}
	
					//update positions of creatures
					for (var _k = 0; _k < ds_list_size(_unit._creature_minion_references); _k++){
						var _minion = ds_list_find_value(_unit._creature_minion_references,_k);
						_minion._minion_position = _k;
					}							
				}
				else { //buff current spriggans
					//show_debug_message("buffing spriggan in spot " + string(_j));
					_spot._minion_hp_cur++;
					_spot._minion_hp_max++;
					_spot._stacks++;	
				}
			}
		}	
	}
}