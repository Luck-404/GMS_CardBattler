function scr_card_stampede(_card,_channel,_target){
	//for each unit in the enemy team
	var _size = 0;
	var _tars = undefined;
	if (_target._creature_team == "Player"){
		_tars = global.player_party_in_play;	
	} else {
		_tars = global.enemy_party_in_play;
	}
		for (var _i = 0; _i < ds_list_size(_tars); _i++){
			var _unit = ds_list_find_value(_tars,_i);

			///////////////////////
			// CALC DAMAGE BONUS //
			///////////////////////
			var _base_dmg_percent = _card[?"damage"]; // e.g., 1%
			var _color_mult = scr_calculate_color_damage_bonus(_channel, _unit); // e.g., x2
			var _scalar = _channel._creature_attack_scalar; // e.g., x2
			var _linear = _channel._creature_attack_linear; // e.g., +3%

			// Calculate final damage percentage
			var _scaled_dmg_percent = _base_dmg_percent * _scalar * _color_mult; // e.g., 1 * 2 * 2 = 4
			var _final_dmg_percent = _scaled_dmg_percent + _linear; // e.g., 4 + 3 = 7%

			// Convert percentage to actual damage
			var _final_dmg = floor((_final_dmg_percent / 100) * _unit._creature_hp_max); // e.g., 7% of max HP

			////////////
			// DAMAGE //
			////////////
			var _damage_dealt = abs(_unit._creature_def - _final_dmg);

			// Apply damage to shield (defense) first
			_unit._creature_def -= _final_dmg;
			if (_unit._creature_def < 0) {
			    // Overflow damage goes to HP
			    _unit._creature_hp_current += _unit._creature_def; // Since _creature_def is negative, this subtracts the extra
			    _unit._creature_def = 0;
			}
	
			////////////
			// EFFECT //
			////////////
			var _ref_effect = instance_create_layer(_unit.x,_unit.y,"Effects",obj_card_effect);
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