function scr_card_fell(_target){
	
	//get 30% of max hp
	var _30p = ceil((_target._creature_hp_max)*0.30);
	
	
	_target._creature_hp_current -= abs(_target._creature_def-_30p);	
	_target._creature_def -= _30p;
	if (_target._creature_def <= 0){
		_target._creature_def = 0;
	}
	var _ref_effect = instance_create_layer(_target.x-64,_target.y-64,"Effects",obj_card_effect);
	_ref_effect.sprite_index = spr_effect_fell;
	audio_play_sound(snd_effect_fell,0,false);		
}