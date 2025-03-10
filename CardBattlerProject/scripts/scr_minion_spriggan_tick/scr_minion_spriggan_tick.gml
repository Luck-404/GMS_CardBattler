//////////////////////////////////////////////////////////////////////
//						SCR_MINION_SPRIGGAN_TICK					//
//																	//
// > HEAL HOST FOR 2*STACK, DEAL 2*STACKS DAMAGE TO A RANDOM ENEMY  //	
//////////////////////////////////////////////////////////////////////
function scr_minion_spriggan_tick(_host,_self){
	//HEAL HOST 2*STACK
	_host._creature_hp_current += (2*_self._stacks); //add the hp
	
	if (_host._creature_hp_current > _host._creature_hp_max){ //check for overflow
		_host._creature_hp_current = _host._creature_hp_max;
	
		////////////
		// EFFECT //
		////////////
		var _ref_effect = instance_create_layer(_host.x,_host.y,"Effects",obj_card_effect);
		_ref_effect.sprite_index = spr_effect_grow_natures_remedy;
	
		///////////
		// SOUND //
		///////////
		audio_play_sound(snd_effect_natures_remedy,0,false);	
	}
	
	if (_self._minion_team == "Player"){
		if (ds_list_size(global.enemy_party_in_play) >0){
	//DAMAGE RANDOM UNIT 2*STACK
		//pick a random enemy target
		var _ref_tar_num = irandom_range(1,ds_list_size(global.enemy_party_in_play));
		var _ref_tar = ds_list_find_value(global.enemy_party_in_play,_ref_tar_num-1);
		scr_damage_creature(_ref_tar,(2*_self._stacks));
		////////////
		// EFFECT //
		////////////
		var _ref_effect2 = instance_create_layer(_ref_tar.x,_ref_tar.y,"Effects",obj_card_effect);
		_ref_effect2.sprite_index = spr_effect_strike;
	
		///////////
		// SOUND //
		///////////
		audio_play_sound(snd_effect_strike,0,false);	
		}
	} 
	else {
	if (ds_list_size(global.player_party_in_play) >0){
	//DAMAGE RANDOM UNIT 2*STACK
		//pick a random enemy target
		var _ref_tar_num = irandom_range(1,ds_list_size(global.player_party_in_play));
		var _ref_tar = ds_list_find_value(global.player_party_in_play,_ref_tar_num-1);
		scr_damage_creature(_ref_tar,(2*_self._stacks));
		////////////
		// EFFECT //
		////////////
		var _ref_effect2 = instance_create_layer(_ref_tar.x,_ref_tar.y,"Effects",obj_card_effect);
		_ref_effect2.sprite_index = spr_effect_strike;
	
		///////////
		// SOUND //
		///////////
		audio_play_sound(snd_effect_strike,0,false);	
	}
	}
}