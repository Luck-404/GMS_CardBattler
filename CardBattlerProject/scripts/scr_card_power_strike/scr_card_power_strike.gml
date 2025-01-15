// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_card_power_strike(_target){
	show_debug_message("!!=== SCR_POWER_STRIKE: CASTING POWER STRIKE ===!!");	
	_target._creature_hp_current -= abs(_target._creature_def-12);		
	_target._creature_def -= 12;
	if (_target._creature_def <= 0){
		_target._creature_def = 0;
	}	
	var _ref_effect = instance_create_layer(_target.x,_target.y,"Effects",obj_card_effect);
	_ref_effect.sprite_index = spr_effect_strike;
	audio_play_sound(snd_effect_power_strike,0,false);	
}