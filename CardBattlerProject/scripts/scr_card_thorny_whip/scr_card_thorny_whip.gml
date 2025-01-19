function scr_card_thorny_whip(_target){
	show_debug_message("!!=== SCR_THORNY_WHIP: CASTING THORNY WHIP ===!!");	
	_target._creature_hp_current -= abs(_target._creature_def-8);	
	_target._creature_def -= 8;
	if (_target._creature_def <= 0){
		_target._creature_def = 0;
	}
	var _ref_effect = instance_create_layer(_target.x-64,_target.y-64,"Effects",obj_card_effect);
	_ref_effect.sprite_index = spr_effect_thorny_whip;
	_ref_effect._count_lifetime = 20;
	audio_play_sound(snd_effect_thorny_whip,0,false);		
}