//////////////////////////////////////////////////////////////////////
//					OBJ_CARD_ATTACK_PLAYER STEP						//
//																	//
// > CAST EACH SPELL IN ORDER WITH TIMING						    //
//////////////////////////////////////////////////////////////////////
if (_execute == true && instance_exists(obj_timer) == false){
	if (ds_list_size(global.enemy_party_in_play) == 0){
		instance_destroy();
	}
	if (ds_list_size(_playlist) > 0){
		show_debug_message("CASTING CARD");
		//find card to cast
		var _card_instance = ds_list_find_value(_playlist,0);
		var _card = _card_instance[0];
		var _channel_creature = _card_instance[1];
		var _target_creature = _card_instance[2];

		//cast card
		scr_play_card(_card,_channel_creature,_target_creature);

		//remove from playlist
		ds_list_delete(_playlist,0);

		//create timer 
		var _ref_timer = instance_create_layer(10,10,"GUI",obj_timer);
		_ref_timer._life = _play_speed; //0.25s
	} else {
		global.echoing = false;
		instance_destroy();	
	}
} 
else {

}










