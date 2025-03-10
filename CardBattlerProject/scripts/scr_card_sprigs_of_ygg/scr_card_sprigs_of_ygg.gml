//////////////////////////////////////////////////////////////////////
//						SCR_CARD_SPRIGS_OF_YGG						//
//																	//
// > SUMMON A SPRIGGAN IN EACH OPEN SPOT, SET UP COUNTER			//
//////////////////////////////////////////////////////////////////////
function scr_card_sprigs_of_ygg(_card,_channel,_target){
		
	//spawn counter- so the spriggans at the BEGINNING of every turn
	//check for existing util
	var _existing_sprig = undefined;
	//see if the target already has a potent fruit buff on
	for (var _i = 0; _i < ds_list_size(global.encounter_utility_active); _i++){
		var _util = ds_list_find_value(global.encounter_utility_active,_i);
		if (_util._counter_name == "Sprigs of Ygg" && _util._counter_team == _channel._creature_team){
			_existing_sprig = _util;
		}
	}	
		
	//if no buff is found, apply the spell as usual
	if (_existing_sprig == undefined){	
		var _ref_counter = instance_create_layer(0,0,"GUI",obj_card_effect_counter);
		_ref_counter.x = 100;
		_ref_counter.y = 250;
		_ref_counter._draw_color = c_lime;	
		_ref_counter._turn_lifespan = 5;
		_ref_counter._reference_script = scr_card_sprigs_of_ygg_tick;
		_ref_counter._target = _channel;
		_ref_counter._trigger_time = "Begin";
		_ref_counter._counter_name = "Sprigs of Ygg";
		_ref_counter._counter_team = _channel._creature_team;
		//add this type of buff to the global util list
		ds_list_add(global.encounter_utility_active,_ref_counter);
		_ref_counter._trigger_my_effect = true;	
		
		//spawning handled in tick
	}
	
	//if a buff is found, just renew its timer without adding anything to it!
	else {
		//renew
		_existing_sprig._turn_lifespan = 5;
	}
	
	///////////
	// SOUND //
	///////////
	audio_play_sound(snd_effect_grow_manavine,0,false);	
	
	////////////
	// BANNER //
	////////////
	var _ref_banner = instance_create_layer(room_width/2,room_height/2-400,"GUI",obj_zone_banner);
	_ref_banner._ban_color = c_black;
	_ref_banner._ban_text = "" + _channel._creature_name + " casts " + _card[?"name"];
	
	scr_trigger_minion_reactions(_card,_target,_channel,0);	
}