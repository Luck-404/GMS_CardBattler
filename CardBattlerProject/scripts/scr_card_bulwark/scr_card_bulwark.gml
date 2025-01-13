// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_card_bulwark(_target){
	_target._creature_def += 10;
	show_debug_message("\n\n\n\ CASTING BULWARK \n\n\n");	
	var _ref_effect = instance_create_layer(_target.x,_target.y,"Effects",obj_card_effect);
	_ref_effect.sprite_index = spr_effect_bulwark;
	audio_play_sound(snd_effect_bulwark,0,false);	
}