// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_card_block(_target){
	_target._creature_def += 5;
	show_debug_message("\n\n\n\ CASTING BLOCK \n\n\n");	
	var eff = instance_create_layer(_target.x,_target.y,"Effects",obj_card_effect);
	eff.sprite_index = spr_effect_block;
	audio_play_sound(snd_effect_block,0,false);
}