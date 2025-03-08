function scr_card_grow_manavine(_card,_channel,_target){
	//check for existing util
	var _existing_manavine = undefined;
	//see if the target already has a potent fruit buff on
	for (var _i = 0; _i < ds_list_size(global.encounter_utility_active); _i++){
		var _util = ds_list_find_value(global.encounter_utility_active,_i);
		if (_util._counter_name == "Inspiration"){
			_existing_manavine = _util;
		}
	}	
		
	//if no buff is found, apply the spell as usual
	if (_existing_manavine == undefined){	
		var _ref_counter = instance_create_layer(0,0,"GUI",obj_card_counter);
		_ref_counter.x = 100;
		_ref_counter.y = 170;
		_ref_counter._draw_color = c_aqua;	
		_ref_counter._turn_lifespan = 3;
		_ref_counter._reference_script = scr_card_grow_manavine_repeat;
		_ref_counter._target = _target;
		_ref_counter._counter_name = "Manavine";
		_ref_counter._counter_team = "Player";
		//add this type of buff to the global util list
		ds_list_add(global.encounter_utility_active,_ref_counter);
		_ref_counter._trigger_my_effect = true;
		//perform the effect
		global.bonus_mana = global.bonus_mana + 2;
		global.cur_mana = global.cur_mana + 2;
	}
	
	//if a buff is found, just renew its timer without adding anything to it!
	else {
		//renew
		_existing_manavine._turn_lifespan = 3;
	}
	var _ref_effect = instance_create_layer(room_width/2,room_height/2,"Effects",obj_card_effect);
	_ref_effect.sprite_index = spr_effect_grow_manavine;
	audio_play_sound(snd_effect_grow_manavine,0,false);
}