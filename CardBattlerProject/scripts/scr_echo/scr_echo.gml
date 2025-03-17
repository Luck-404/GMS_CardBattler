//////////////////////////////////////////////////////////////////////
//							SCR_ECHO								//
//																	//
// > PLAYS AN INPUT CARD X TIMES									//
//////////////////////////////////////////////////////////////////////
function scr_echo(_count,_card,_channel_creature,_target_creature){
	audio_play_sound(snd_effect_echoing,0,false);		
	var _attack_player = instance_create_layer(room_width/2,room_height/2,"GUI",obj_card_attack_player);	
	
	for (var _i = -1; _i < _count; _i++){
		//add card to player
		ds_list_add(_attack_player._playlist,[_card,_channel_creature,_target_creature]);
	}
	
	global.echoing = true;
	audio_play_sound(snd_effect_echoing,0,false);
	_attack_player._execute = true;
}