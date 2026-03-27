//////////////////////////////////////////////////////////////////////
//						SCR_CARD_URSINE_WRATH						//
//																	//
// > DEAL DAMAGE 3 TIMES TO MELEE UNIT								//
//////////////////////////////////////////////////////////////////////
function scr_card_ursine_wrath(_card,_channel,_target){

	////////////////////////////
	// TRIGGER ATTACK 3 TIMES //
	////////////////////////////
		var _hit_card = scr_load_card("Ursine Wrath Hit");
		var _new_card_object1 = scr_create_card_object("destroy",_hit_card);
		var _new_card_object2 = scr_create_card_object("destroy",_hit_card);
		var _new_card_object3 = scr_create_card_object("destroy",_hit_card);
	
		var _attack_player = instance_create_layer(room_width/2,room_height/2,"GUI",obj_card_attack_player);
	
		ds_list_add(_attack_player._playlist,[_new_card_object1,_channel,_target]);
		ds_list_add(_attack_player._playlist,[_new_card_object2,_channel,_target]);
		ds_list_add(_attack_player._playlist,[_new_card_object3,_channel,_target]);	
	
		_attack_player._execute = true;
	

	
	audio_play_sound(snd_effect_ursine_wrath,0,false);	
	
	////////////
	// BANNER //
	////////////
	scr_create_combat_banner(c_black,"" + _channel._creature_name + " casts " + _card._card_ref[?"name"] + " on " + _target._creature_name);

	///////////
	// DEBUG //
	///////////
	show_debug_message("COMBAT: " + _channel._creature_name + " casts " + _card._card_ref[?"name"] + " on " + _target._creature_name);
}