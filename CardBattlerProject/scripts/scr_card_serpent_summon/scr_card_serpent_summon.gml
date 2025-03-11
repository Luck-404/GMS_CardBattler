//////////////////////////////////////////////////////////////////////
//						SCR_CARD_SERPENT_SUMMON						//
//																	//
// > SUMMON 3 SERPENTS												//
//////////////////////////////////////////////////////////////////////
function scr_card_serpent_summon(_card,_channel,_target){
	/////////////////////
	// SPAWN 3 MINIONS //
	/////////////////////
	for (var _j = 0; _j < 3; _j++){
		var _ref_minion = instance_create_layer(_target.x,_target.y,"Creatures",obj_minion);
		_ref_minion._minion_hp_cur = 6;
		_ref_minion._minion_hp_max = 6;
		_ref_minion._minion_def = 0;
		_ref_minion._minion_name = "Serpent";
		_ref_minion._minion_team = _target._creature_team;
		_ref_minion._minion_cast_types = ["None","Host Damage Taken","Host Damage Dealt"];
		_ref_minion._minion_sprite = spr_minion_coiled_serpent;
		_ref_minion.sprite_index = _ref_minion._minion_sprite;
		_ref_minion._minion_hurtsound = snd_creature_wraith_hurt;
		_ref_minion._minion_deathsound = snd_creature_wraith_death;
		_ref_minion._minion_defaultsound = snd_creature_wraith_default;
		_ref_minion._minion_unit_attached = _target;
		_ref_minion._minion_effect_script = scr_minion_serpent_tick;
	
		///////////////////
		// ADD TO TARGET //
		///////////////////
		//check target's list
		if (_target._creature_minion_count < _target._creature_minion_limit){ //if open spot
			//if open spot- play normally
			ds_list_add(_target._creature_minion_references,_ref_minion);
			_ref_minion._minion_position = _target._creature_minion_count;
			_target._creature_minion_count++;
	
		
		}
		else { //overwrite old
			//else overwrite oldest unit (delete oldest unit)
			var _removal_unit = ds_list_find_value(_target._creature_minion_references,0);
			ds_list_delete(_target._creature_minion_references,0);
			instance_destroy(_removal_unit);

			//add new to back of the list
			ds_list_add(_target._creature_minion_references,_ref_minion);
			_ref_minion._minion_position = _target._creature_minion_limit-1;
		}
	
		//update positions of creatures
		for (var _i = 0; _i < ds_list_size(_target._creature_minion_references); _i++){
			var _minion = ds_list_find_value(_target._creature_minion_references,_i);
			_minion._minion_position = _i;
		}			
	}
	
	/////////////////////////////
	// GIVE 10 LINEAR DMG BUFF //
	/////////////////////////////
	#region BUFF
		/////////////////////////
		// CHECK EFFECT EXISTS //
		/////////////////////////
		var _existing_serpent_buff = undefined;
			//see if the target already has a potent fruit buff on
			for (var _i = 0; _i < ds_list_size(_target._buffs); _i++){
				var _buff = ds_list_find_value(_target._buffs,_i);
				if (_buff._counter_name == "Serpent Summon DMG Bonus"){
					_existing_serpent_buff = _buff
				}
			}
		
		///////////////////////////////
		// IF NOT EXISTS, CAST SPELL //
		///////////////////////////////
		if (_existing_serpent_buff == undefined){			
			var _ref_counter = instance_create_layer(0,0,"GUI",obj_card_effect_counter);
			_ref_counter.x = _target.x;
			_ref_counter.y = _target.y - 100;
			_ref_counter._draw_color = c_red;	
			_ref_counter._turn_lifespan = 999;
			_ref_counter._reference_script = scr_card_serpent_summon_tick;
			_ref_counter._target = _target;
			_ref_counter._counter_name = "Serpent Summon DMG Bonus";
			_ref_counter._checker_script = scr_card_serpent_summon_disable;
			//add this type of buff to the buffs list
			ds_list_add(_target._buffs,_ref_counter);
			_ref_counter._trigger_my_effect = true;
			_target._creature_attack_linear = _target._creature_attack_linear+10;
		} 
	
		//////////////////////
		// IF EXISTS, RENEW //
		//////////////////////	
		else {
			_existing_serpent_buff._turn_lifespan = 999;
		}
	#endregion
	
	///////////
	// SOUND //
	///////////
	audio_play_sound(snd_effect_potent_fruit,0,false);	
	
	////////////
	// BANNER //
	////////////
	var _ref_banner = instance_create_layer(room_width/2,room_height/2-400,"GUI",obj_zone_banner);
	_ref_banner._ban_color = c_black;
	_ref_banner._ban_text = "" + _channel._creature_name + " casts " + _card[?"name"] + " on " + _target._creature_name;
	
	scr_trigger_minion_reactions(_card,_target,_channel,0);	
}