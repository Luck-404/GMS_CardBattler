//////////////////////////////////////////////////////////////////////
//							SCR_CARD_BLOODBEAK						//
//																	//
// > SUMMON A BLOODBEAK MINION ON A UNIT							//
//////////////////////////////////////////////////////////////////////
function scr_card_bloodbeak(_card,_channel,_target){
	//////////////////
	// SPAWN MINION //
	//////////////////
	var _ref_minion = instance_create_layer(_target.x,_target.y,"Creatures",obj_minion);
	_ref_minion._minion_hp_cur = 5;
	_ref_minion._minion_hp_max = 5;
	_ref_minion._minion_def = 0;
	_ref_minion._minion_name = "Bloodbeak";
	_ref_minion._minion_team = _target._creature_team;
	_ref_minion._minion_cast_types = ["None","None","Host Damage Dealt"];
	_ref_minion._minion_sprite = spr_minion_bloodbeak;
	_ref_minion.sprite_index = _ref_minion._minion_sprite;
	_ref_minion._minion_hurtsound = snd_creature_wraith_hurt;
	_ref_minion._minion_deathsound = snd_creature_wraith_death;
	_ref_minion._minion_defaultsound = snd_creature_wraith_default;
	_ref_minion._minion_unit_attached = _target;
	
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
	
	///////////
	// SOUND //
	///////////
	audio_play_sound(snd_effect_potent_fruit,0,false);	
	
	////////////
	// BANNER //
	////////////
	var _ref_banner = instance_create_layer(room_width/2,room_height/2-400,"GUI",obj_banner);
	_ref_banner._ban_color = c_black;
	_ref_banner._ban_text = "" + _channel._creature_name + " casts " + _card[?"name"] + " on " + _target._creature_name;
	
	scr_trigger_minion_reactions(_card,_target,_channel,0);
}