// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_card_echo(){
	//show_debug_message("!!=== SCR_ECHO: PLAYING ECHO ===!!");			
	global.echo = true;
	global.echo_count+=1;	
	var _ref_effect = instance_create_layer(room_width/2,room_height/2,"Effects",obj_card_effect);
	_ref_effect.sprite_index = spr_effect_echo;
	audio_play_sound(snd_effect_echo,0,false);		
	
	// remove the echo card
	//ds_list_add(global.card_inventory, global.card_selected);
	//show_debug_message("!!=== SCR_ECHO: EXHAUSTING ECHO ===!!");	
	ds_list_delete(global.current_hand, ds_list_find_index(global.current_hand,global.card_selected));
	//ds_list_delete(global.card_inventory, ds_list_find_index(global.card_inventory,global.card_selected));
	ds_list_add(global.exhausted,global.card_selected);
	// Reset the selected card
	global.card_selected = undefined;
}