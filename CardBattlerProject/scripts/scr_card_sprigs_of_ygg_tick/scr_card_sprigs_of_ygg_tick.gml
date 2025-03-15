//////////////////////////////////////////////////////////////////////
//					SCR_CARD_SPRIGS_OF_YGG_TICK						//
//																	//
// > SPAWN SPRIGGANS IN EMPTY SPOTS, INCREASE THE SPRIGGANS STACKS  //
//////////////////////////////////////////////////////////////////////
function scr_card_sprigs_of_ygg_tick(_counter,_target,_repeat){
	////////////////////
	// TRIGGER EFFECT //
	////////////////////
	if (_repeat == true){
		//////////////////////////////
		// SPAWN AND BUFF SPRIGGANS //
		//////////////////////////////
		//for each unit on the target team
		for (var _i = 0; _i < ds_list_size(global.player_party_in_play); _i++){
			var _unit = ds_list_find_value(global.player_party_in_play,_i);
			var _minions = _unit._creature_minion_references;
			for (var _j = 0; _j < _unit._creature_minion_limit; _j++){
				var _spot = ds_list_find_value(_minions,_j);
				if (_spot == undefined){ 
					//////////////////
					// SPAWN MINION //
					//////////////////
					scr_create_combat_minion(undefined,undefined,_unit,"Spriggan");
				}
				else if (_spot._minion_name == "Spriggan") { //buff current spriggans
					/////////////////
					// BUFF MINION //
					/////////////////
					_spot._minion_hp_cur++;
					_spot._minion_hp_max++;
					_spot._minion_stacks++;	
				}
			}
		}	
		audio_play_sound(snd_effect_minion_poof,0,false);	
	}
	
	/////////////////
	// UNDO EFFECT //
	/////////////////	
	else {
		_counter._counter_delete_flag = true;
	}
}