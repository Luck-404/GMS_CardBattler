function scr_card_block(_target){
	show_debug_message("!!=== SCR_BLOCK: CASTING BLOCK ===!!");		
	_target._creature_def += 5;
	var _ref_effect = instance_create_layer(_target.x,_target.y,"Effects",obj_card_effect);
	_ref_effect.sprite_index = spr_effect_block;
	audio_play_sound(snd_effect_block,0,false);
}