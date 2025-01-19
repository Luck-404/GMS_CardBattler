function scr_card_potent_fruit(_target){
	show_debug_message("!!=== SCR_POTENT_FRUIT: CASTING POTENT FRUIT ===!!");
	var _ref_counter = instance_create_layer(0,0,"GUI",obj_card_counter);
	_ref_counter.x = _target.x;
	_ref_counter.y = _target.y - 100;
	_ref_counter._draw_color = c_red;	
	_ref_counter._turn_lifespan = 3;
	_ref_counter._reference_script = scr_card_potent_fruit_repeat;
	_ref_counter._target = _target;
	_target._creature_attack_scalar = 2;
	var _ref_effect = instance_create_layer(_target.x,_target.y,"Effects",obj_card_effect);
	_ref_effect.sprite_index = spr_effect_potent_fruit;
	audio_play_sound(snd_effect_potent_fruit,0,false);
}