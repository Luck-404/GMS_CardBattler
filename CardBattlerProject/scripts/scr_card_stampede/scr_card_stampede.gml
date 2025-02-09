function scr_card_stampede(){
	for (var _i = 0; _i < ds_list_size(global.enemy_team); i++){
		var _target = ds_list_find_value(global.enemy_team,_i);
		//get 10% of max hp
		var _10p = ceil((_target._creature_hp_max)*0.30);
		_target._creature_hp_current -= abs(_target._creature_def-_10p);	
		_target._creature_def -= _10p;
		if (_target._creature_def <= 0){
			_target._creature_def = 0;
		}
		var _ref_effect = instance_create_layer(_target.x-64,_target.y-64,"Effects",obj_card_effect);
		_ref_effect.sprite_index = spr_effect_strike;
	}
	audio_play_sound(snd_effect_stampede,0,false);		
}