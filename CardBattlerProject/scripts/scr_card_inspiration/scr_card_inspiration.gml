// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_card_inspiration(){
	global.current_mana++;
	
	show_debug_message("\n\n\n\ CASTING INSPIRATION \n\n\n");
	var eff = instance_create_layer(room_width/2,room_height/2,"Effects",obj_card_effect);
	eff.sprite_index = spr_effect_inspiration;
	audio_play_sound(snd_effect_inspiration,0,false);			
}