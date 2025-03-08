function scr_card_inspiration(_card,_channel,_target){

	
	///////////////////
	// COUNTER/TIMER //
	///////////////////
		
		//check for existing util
		var _existing_insire = undefined;
		//see if the target already has a potent fruit buff on
		for (var _i = 0; _i < ds_list_size(global.encounter_utility_active); _i++){
			var _util = ds_list_find_value(global.encounter_utility_active,_i);
			if (_util._counter_name == "Inspiration"){
				_existing_insire = _util;
			}
		}	
		
	//if no buff is found, apply the spell as usual
	if (_existing_insire == undefined){	
		var _ref_counter = instance_create_layer(0,0,"GUI",obj_card_counter);
		_ref_counter.x = 100;
		_ref_counter.y = 150;
		_ref_counter._draw_color = c_blue;	
		_ref_counter._turn_lifespan = 2;
		_ref_counter._reference_script = scr_card_inspire;
		_ref_counter._target = _target;
		_ref_counter._counter_name = "Inspiration";
		_ref_counter._counter_team = "Player";
		//add this type of buff to the global util list
		ds_list_add(global.encounter_utility_active,_ref_counter);
		_ref_counter._trigger_my_effect = true;
		//perform the effect
		global.bonus_mana++;
		global.cur_mana++;
	}
	
	//if a buff is found, just renew its timer without adding anything to it!
	else {
		//renew
		_existing_insire._turn_lifespan = 2;
	}
	
	////////////
	// EFFECT //
	////////////
	var _ref_effect = instance_create_layer(room_width/2,room_height/2,"Effects",obj_card_effect);
	_ref_effect.sprite_index = spr_effect_inspiration;
	
	///////////
	// SOUND //
	///////////
	audio_play_sound(snd_effect_inspiration,0,false);	
	
	////////////
	// BANNER //
	////////////
	var _ref_banner = instance_create_layer(room_width/2,room_height/2-400,"GUI",obj_zone_banner);
	_ref_banner._ban_color = c_black;
	_ref_banner._ban_text = "" + _channel._creature_name + " casts inspiration";
}