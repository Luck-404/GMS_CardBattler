function scr_card_stampede(_card,_channel,_target){
	//for each unit in the enemy team
	for (var _i = 0; _i < ds_list_size(global.enemy_party_in_play); i++){
		var _unit = ds_list_find_index(global.enemy_party_in_play,_i);
		///////////////////////
		// CALC DAMAGE BONUS //
		///////////////////////
		var _base_dmg = _card[?"damage"];
		var _dmg_mult = scr_calculate_color_damage_bonus(_channel,_base_dmg,_unit);
		var _mult = _channel._creature_attack_scalar;
		var _linear = _channel._creature_attack_linear;
		_base_dmg = _base_dmg*_mult;
		_base_dmg = _base_dmg+_linear;		
	
		////////////
		// DAMAGE //
		////////////
		_unit._creature_hp_current -= abs(_unit._creature_def-_dmg_mult);	
		_unit._creature_def -= _dmg_mult;
		if (_unit._creature_def <= 0){
			_unit._creature_def = 0;
		}
	
		////////////
		// EFFECT //
		////////////
		var _ref_effect = instance_create_layer(_target.x,_target.y,"Effects",obj_card_effect);
		_ref_effect.sprite_index = spr_effect_strike;
	}

	///////////
	// SOUND //
	///////////
	audio_play_sound(snd_effect_stampede,0,false);		
	
	////////////
	// BANNER //
	////////////
	var _ref_banner = instance_create_layer(room_width/2,room_height/2-400,"GUI",obj_zone_banner);
	_ref_banner._ban_color = c_black;
	_ref_banner._ban_text = "" + _channel._creature_name + " casts " + _card[?"name"] + " on all targets";
}