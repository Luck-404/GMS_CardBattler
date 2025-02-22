function scr_card_natures_remedy(_target){
	
	//get 30% of max hp
	var _30p = ceil((_target._creature_hp_max)*0.30);
	
	//add the hp
	_target._creature_hp_current += _30p;
	
	//check for overflow
	if (_target._creature_hp_current > _target._creature_hp_max){
		_target._creature_hp_current = _target._creature_hp_max;
	}
	
	//play effects!
	var _ref_effect = instance_create_layer(_target.x,_target.y,"Effects",obj_card_effect);
	_ref_effect.sprite_index = spr_effect_grow_natures_remedy;
	audio_play_sound(snd_effect_natures_remedy,0,false);	
}